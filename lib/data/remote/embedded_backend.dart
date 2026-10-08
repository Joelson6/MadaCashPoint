import 'dart:math';

import 'package:flutter/foundation.dart';

import '../../core/config/app_config.dart';
import '../../core/db/local_store.dart';
import '../../core/security/secure_store.dart';
import '../../core/utils/formatters.dart';
import '../../core/utils/validators.dart';
import '../local/repositories/anomalie_repo.dart';
import '../local/repositories/demande_repo.dart';
import '../local/repositories/encaissement_repo.dart';
import '../local/repositories/kiosque_repo.dart';
import '../local/repositories/notification_repo.dart';
import '../local/repositories/user_repo.dart';
import '../models/anomalie.dart';
import '../models/app_user.dart';
import '../models/demande.dart';
import '../models/encaissement.dart';
import '../models/kiosque.dart';
import '../models/notification_item.dart';
import 'cuf_backend.dart';
import 'demande_payload.dart';
import 'kiosque_mapper.dart';

/// ============================================================================
/// BACK-END EMBARQUÉ SUR LE TÉLÉPHONE
/// ============================================================================
/// Implémente la logique serveur (équivalente aux méthodes XML-RPC du site web
/// CUF, section 8) directement sur la base locale Isar du terminal.
/// Résultat : une application 100 % autonome, utilisable sur téléphone sans
/// serveur externe, tout en conservant l'interface XML-RPC (basculable vers le
/// site web réel via [RemoteXmlRpcBackend]).
/// ============================================================================
class EmbeddedBackend implements CufBackend {
  final LocalStore _db;
  final SecureStore _store;

  late final UserRepo _users;
  late final KiosqueRepo _kiosques;
  late final DemandeRepo _demandes;
  late final EncaissementRepo _encaissements;
  late final AnomalieRepo _anomalies;
  late final NotificationRepo _notifications;

  EmbeddedBackend(this._db, this._store) {
    _users = UserRepo(_db);
    _kiosques = KiosqueRepo(_db);
    _demandes = DemandeRepo(_db);
    _encaissements = EncaissementRepo(_db);
    _anomalies = AnomalieRepo(_db);
    _notifications = NotificationRepo(_db);
  }

  final _random = Random.secure();

  String _token() {
    final buf = StringBuffer();
    const chars =
        'abcdefghijklmnopqrstuvwxyz0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    for (var i = 0; i < 32; i++) {
      buf.write(chars[_random.nextInt(chars.length)]);
    }
    return 'CUF-${DateTime.now().year}-$buf';
  }

  // --------------------------------------------------------------------------
  // user_login(phone_number, pin_code)
  // --------------------------------------------------------------------------
  @override
  Future<SessionInfo> userLogin(String telephone, String pin) async {
    final norm = PhoneValidator.normalize(telephone);
    if (norm == null) {
      throw ArgumentError(
        'Numéro de téléphone invalide (format local 9 chiffres requis)',
      );
    }
    final user = await _users.findByTelephone(norm);
    if (user == null || !user.isActive) {
      throw ArgumentError('Identifiant inconnu ou compte désactivé');
    }
    final pinHash = Crypto.sha256(pin);
    if (user.pinCode != pinHash) {
      throw ArgumentError('Code PIN incorrect');
    }
    final token = _token();
    user.sessionToken = token;
    user.lastLoginAt = DateTime.now();
    await _users.put(user);

    final session = SessionInfo(
      telephone: norm,
      nom: user.nom,
      role: user.role,
      sessionToken: token,
    );
    await _store.saveSession(
      telephone: session.telephone,
      nom: session.nom,
      role: session.role,
      sessionToken: session.sessionToken,
    );
    return session;
  }

  // --------------------------------------------------------------------------
  // Émission OTP (création de compte citoyen uniquement)
  // --------------------------------------------------------------------------
  @override
  Future<String> requestOtp(String telephone) async {
    final norm = PhoneValidator.normalize(telephone);
    if (norm == null) {
      throw ArgumentError('Numéro de téléphone invalide');
    }
    final existing = await _users.findByTelephone(norm);
    if (existing != null && existing.role == 'demandeur') {
      throw ArgumentError(
        'Un compte existe déjà pour ce numéro. Connectez-vous.',
      );
    }
    // Génération du code à usage unique (SMS simulé en mode embarqué).
    final code = (_random.nextInt(900000) + 100000).toString();
    await _store.saveOtp(norm, code);
    return code;
  }

  // --------------------------------------------------------------------------
  // Vérification OTP + création du compte demandeur
  // --------------------------------------------------------------------------
  @override
  Future<SessionInfo> verifyOtpAndRegister(Map<String, dynamic> payload) async {
    final telephone = payload['telephone']?.toString() ?? '';
    final otp = payload['otp']?.toString() ?? '';
    final pin = payload['pin']?.toString() ?? '';
    final nom = payload['nom']?.toString() ?? '';

    final norm = PhoneValidator.normalize(telephone);
    if (norm == null) throw ArgumentError('Numéro de téléphone invalide');
    final otpError = _store.verifOtp(norm, otp);
    if (otpError != null) throw ArgumentError(otpError);
    if (!PinValidator.isValid(pin)) {
      throw ArgumentError('Le code PIN doit comporter 4 ou 6 chiffres');
    }
    if (nom.trim().isEmpty) throw ArgumentError('Nom obligatoire');

    final user = AppUser(
      telephone: norm,
      pinCode: Crypto.sha256(pin),
      nom: nom.trim(),
      role: 'demandeur',
    );
    user.prenom = payload['prenom']?.toString() ?? '';
    user.cin = payload['cin']?.toString() ?? '';
    user.cinDate = payload['cinDate']?.toString() ?? '';
    user.cinLieu = payload['cinLieu']?.toString() ?? '';
    user.quartier = payload['quartier']?.toString() ?? '';
    user.fokontany = payload['fokontany']?.toString() ?? '';
    user.isVerified = true;
    await _users.put(user);

    final token = _token();
    user.sessionToken = token;
    user.lastLoginAt = DateTime.now();
    await _users.put(user);

    final session = SessionInfo(
      telephone: norm,
      nom: user.nom,
      role: user.role,
      sessionToken: token,
    );
    await _store.saveSession(
      telephone: session.telephone,
      nom: session.nom,
      role: session.role,
      sessionToken: session.sessionToken,
    );
    return session;
  }

  // --------------------------------------------------------------------------
  // Zones interdites (section 5.3) : trottoir, RN7, zones administratives.
  // --------------------------------------------------------------------------
  static const List<Map<String, dynamic>> _zonesInterdites = [
    {
      'lat': -21.4536,
      'lon': 47.0856,
      'rayon': 220.0,
      'label': 'Trottoir intégral — zone piétonne centre-ville',
    },
    {
      'lat': -21.4516,
      'lon': 47.0904,
      'rayon': 150.0,
      'label': 'Périmètre administratif protégé (Hôtel de Ville)',
    },
    {
      'lat': -21.4588,
      'lon': 47.1002,
      'rayon': 180.0,
      'label': 'Emprise routière dangereuse RN7 (corridor)',
    },
  ];

  @override
  Future<LocationAllowance> checkLocationAllowance(
    double latitude,
    double longitude,
  ) async {
    if (latitude < -26 || latitude > -11 || longitude < 43 || longitude > 51) {
      return LocationAllowance(
        allowed: false,
        message: 'Coordonnées hors territoire de la Commune Urbaine de Fianarantsoa.',
        zoneDescription: 'Hors zone CUF',
      );
    }
    for (final z in _zonesInterdites) {
      final d = distanceMetres(latitude, longitude, z['lat'], z['lon']);
      if (d <= (z['rayon'] as double)) {
        return LocationAllowance(
          allowed: false,
          message:
              'Implantation bloquée : l\'emplacement se situe dans la zone interdite « ${z['label']} ».',
          zoneDescription: z['label'],
        );
      }
    }
    return LocationAllowance(
      allowed: true,
      message: 'Emplacement autorisé pour l\'implantation du kiosque.',
    );
  }

  // --------------------------------------------------------------------------
  // submit_demande_autorisation(payload)
  // --------------------------------------------------------------------------
  @override
  Future<DemandeResult> submitDemande(Map<String, dynamic> payload) async {
    final telephone = payload['telephone']?.toString() ?? '';

    // Idempotence : un dossier déjà transmis n'est pas dupliqué.
    final codeExistant = payload['code_dossier']?.toString() ?? '';
    if (codeExistant.isNotEmpty) {
      final d = await _demandes.byCode(codeExistant);
      if (d != null) {
        if (!estCodeOffline(codeExistant)) {
          // Réception déjà confirmée (rejeu de la file) : on renvoie
          // l'existant sans rien réécrire.
          return DemandeResult(
            codeDossier: d.codeDossier,
            statut: d.statut,
            montantDroitInstallation: d.montantDroitInstallation,
          );
        }
        return _migrerDossierOffline(d, payload, telephone);
      }
      if (estCodeOffline(codeExistant)) {
        // Le dossier provisoire n'existe plus alors que la ligne de file si :
        // il a DÉJÀ été promu (l'appareil a été tué entre la promotion et le
        // marquage « fait » de la ligne). Refaire ce que la purge précédente a
        // déjà fait créerait un second dossier.
        debugPrint(
          '[EmbeddedBackend] Rejeu après promotion ignoré ($codeExistant)',
        );
        return DemandeResult(
          codeDossier: codeExistant,
          statut: 'EN_COURS_INSTRUCTION',
          montantDroitInstallation:
              intOf(payload, 'montant_droit_installation') > 0
              ? intOf(payload, 'montant_droit_installation')
              : AppConfig.droitInstallationAriary,
        );
      }
    }

    final codeDossier = await _codeDossierLibre();
    final demande = demandeDepuisPayload(
      payload,
      telephone: telephone,
      codeDossier: codeDossier,
    );
    demande.synchronise = true;
    await _demandes.put(demande);

    debugPrint('[EmbeddedBackend] Demande soumise: $codeDossier');
    return DemandeResult(
      codeDossier: codeDossier,
      statut: demande.statut,
      montantDroitInstallation: demande.montantDroitInstallation,
    );
  }

  /// Un dossier créé pendant une panne réseau reçoit enfin son numéro
  /// officiel : la ligne provisoire `OFFLINE-…` est **remplacée** (même `id`
  /// Isar) par le dossier complet issu du payload rejoué.
  ///
  /// Sans cette migration, le replay de la file générait un SECOND dossier
  /// (le code provisoire ne correspondant à rien côté « serveur ») et le
  /// demandeur se retrouvait avec deux ou trois dossiers pour une seule
  /// soumission.
  Future<DemandeResult> _migrerDossierOffline(
    Demande provisoire,
    Map<String, dynamic> payload,
    String telephone,
  ) async {
    final codeDossier = await _codeDossierLibre();
    final demande =
        demandeDepuisPayload(
            payload,
            telephone: telephone,
            codeDossier: codeDossier,
          )
          ..id = provisoire
              .id // remplace la ligne provisoire, pas de doublon
          ..dateCreation = provisoire.dateCreation
          ..dateSoumission = provisoire.dateSoumission
          ..statut = provisoire.statut
          ..synchronise = true;
    await _demandes.put(demande);

    debugPrint(
      '[EmbeddedBackend] Dossier ${provisoire.codeDossier} confirmé sous $codeDossier',
    );
    return DemandeResult(
      codeDossier: codeDossier,
      statut: demande.statut,
      montantDroitInstallation: demande.montantDroitInstallation,
    );
  }

  /// Numéro officiel non déjà attribué (deux soumissions dans la même
  /// milliseconde produisaient sinon le même `CUF{année}-{5 chiffres}`).
  Future<String> _codeDossierLibre() async {
    for (var i = 0; i < 10; i++) {
      final code = _genererCodeDossier();
      if (await _demandes.byCode(code) == null) return code;
    }
    // Repli improbable : suffixe strictement incrémental.
    return 'CUF${DateTime.now().year}-${_random.nextInt(90000) + 10000}'
        '${DateTime.now().microsecond % 10}';
  }

  String _genererCodeDossier() {
    final now = DateTime.now();
    final tail = (now.millisecondsSinceEpoch % 90000 + 10000).toString();
    return 'CUF${now.year}-$tail';
  }

  // --------------------------------------------------------------------------
  // get_kiosque_by_qrcode / get_kiosque_by_id + voisinage
  // --------------------------------------------------------------------------
  @override
  Future<Map<String, dynamic>?> getKiosqueByQrcode(String code) async {
    final clean = code.trim().toUpperCase();
    final kiosque = await _kiosques.byCode(clean);
    if (kiosque == null) return null;

    kiosque.lastSeenAt = DateTime.now();
    kiosque.isSynchronised = true;
    await _kiosques.put(kiosque);

    final voisins = await _voisinsDu(clean);
    return kiosqueVersFiche(kiosque, voisins: voisins);
  }

  @override
  Future<Map<String, dynamic>?> getKiosqueById(String code) async {
    final clean = code.trim().toUpperCase();
    final kiosque = await _kiosques.byCode(clean);
    if (kiosque == null) return null;

    kiosque.lastSeenAt = DateTime.now();
    await _kiosques.put(kiosque);

    final voisins = await _voisinsDu(clean);
    return kiosqueVersFiche(kiosque, voisins: voisins);
  }

  @override
  Future<List<Map<String, dynamic>>> getKiosquesVoisins(String code) async {
    final clean = code.trim().toUpperCase();
    final voisins = await _voisinsDu(clean);
    final resultat = <Map<String, dynamic>>[];
    for (final v in voisins) {
      final fiche = kiosqueVersFiche(
        Kiosque(codeKiosque: v.codeKiosque),
        voisins: const [],
      );
      final liste = (fiche['kiosques_voisins'] as List?) ?? const [];
      for (final m in liste) {
        if (m is Map) {
          resultat.add(Map<String, dynamic>.from(m));
        }
      }
    }
    return resultat;
  }

  /// Voisins : même fokontany OU rayon de 50 m, hors kiosque lui-même.
  Future<List<Kiosque>> _voisinsDu(String code) async {
    final principal = await _kiosques.byCode(code);
    if (principal == null) return [];
    final tous = await _kiosques.all();
    final voisins = <Kiosque>[];
    for (final k in tous) {
      if (k.codeKiosque == principal.codeKiosque) continue;
      final memeFokontany = k.fokontany == principal.fokontany;
      final d = distanceMetres(
        principal.gpsLatitude,
        principal.gpsLongitude,
        k.gpsLatitude,
        k.gpsLongitude,
      );
      if (memeFokontany || d <= AppConfig.neighbourRadiusMeters) {
        voisins.add(k);
      }
    }
    voisins.sort(
      (a, b) =>
          distanceMetres(
            principal.gpsLatitude,
            principal.gpsLongitude,
            a.gpsLatitude,
            a.gpsLongitude,
          ).compareTo(
            distanceMetres(
              principal.gpsLatitude,
              principal.gpsLongitude,
              b.gpsLatitude,
              b.gpsLongitude,
            ),
          ),
    );
    return voisins.take(10).toList();
  }

  // --------------------------------------------------------------------------
  // get_kiosques_redevables()
  // Liste de travail recouvrement (section 6) : les kiosques en retard de taxe
  // mensuelle ou au droit d'installation non réglé, triés par dette décroissante.
  // --------------------------------------------------------------------------
  @override
  Future<List<Map<String, dynamic>>> getKiosquesRedevables() async {
    final tous = await _kiosques.all();
    final redevables =
        tous
            .where(
              (k) =>
                  k.statutTaxeMensuelle == 'REDEVABLE' ||
                  k.totalDetteAriary > 0 ||
                  k.statutDroitInstallation == 'EN_ATTENTE',
            )
            .toList()
          ..sort((a, b) => b.totalDetteAriary.compareTo(a.totalDetteAriary));
    return [
      for (final k in redevables)
        {
          'code_kiosque': k.codeKiosque,
          'proprietaire_nom': k.proprietaireNom,
          'proprietaire_telephone': k.proprietaireTelephone,
          'emplacement_repere': k.emplacementRepere,
          'fokontany': k.fokontany,
          'statut_droit_installation': k.statutDroitInstallation,
          'statut_taxe_mensuelle': k.statutTaxeMensuelle,
          'mois_retard_calcules': k.moisRetardCalcules,
          'total_dette_ariary': k.totalDetteAriary,
          'gps_latitude': k.gpsLatitude,
          'gps_longitude': k.gpsLongitude,
        },
    ];
  }

  // --------------------------------------------------------------------------
  // register_encaissement(payload)
  // --------------------------------------------------------------------------
  @override
  Future<EncaissementResult> registerEncaissement(
    Map<String, dynamic> payload,
  ) async {
    final code = payload['code_kiosque']?.toString() ?? '';
    final montant = intOf(payload, 'montant');
    final nature =
        payload['nature_taxe']?.toString().toUpperCase() ?? 'RENOUVELLEMENT';

    // Idempotence : rejouer un encaissement déjà enregistré ne crée pas de doublon.
    final quittanceFournie = payload['numero_quittance']?.toString() ?? '';
    if (quittanceFournie.isNotEmpty) {
      final existants = await _encaissements.all();
      for (final e in existants) {
        if (e.numeroQuittance == quittanceFournie) {
          return EncaissementResult(
            numeroQuittance: e.numeroQuittance,
            numeroAvisPaiement: await _avisPour(code),
            horodatage: e.horodatage,
            message:
                'Encaissement déjà enregistré (réception dupliquée ignorée).',
          );
        }
      }
    }

    final kiosque = await _kiosques.byCode(code.toUpperCase());
    if (kiosque == null) {
      throw ArgumentError(
        'Kiosque inconnu : impossible d\'enregistrer l\'encaissement.',
      );
    }

    final numeroQuittance = _genererQuittance();
    final encaissement = Encaissement(
      codeKiosque: kiosque.codeKiosque,
      nomKiosque: kiosque.codeKiosque,
      proprietaireNom: kiosque.proprietaireNom,
      montant: montant,
      natureTaxe: nature,
      agentTelephone: payload['agent_telephone']?.toString() ?? '',
      agentSessionToken: payload['session_token']?.toString() ?? '',
    );
    encaissement.gpsLatitude = dblOf(payload, 'gps_lat');
    encaissement.gpsLongitude = dblOf(payload, 'gps_lon');
    encaissement.numeroQuittance = numeroQuittance;
    encaissement.horodatage = payload['horodatage'] is DateTime
        ? payload['horodatage'] as DateTime
        : DateTime.now();

    await _encaissements.put(encaissement);

    // Mise à jour de la situation fiscale (section 7.2).
    await _db.writeTxn(() async {
      final k = await _kiosques.byCode(kiosque.codeKiosque);
      if (k == null) return;
      if (nature == 'INSTALLATION' || nature == 'DROIT_INSTALLATION') {
        k.statutDroitInstallation = 'PAYE';
      }
      if (nature == 'RENOUVELLEMENT') {
        final reste = k.totalDetteAriary - montant;
        k.totalDetteAriary = reste < 0 ? 0 : reste;
        k.moisRetardCalcules = reste <= 0
            ? 0
            : (k.moisRetardCalcules - 1).clamp(0, 60);
        k.taxesAnnuel.add(
          '${DateTime.now().year}|$montant|PAYE|$numeroQuittance',
        );
        if (k.moisRetardCalcules == 0) k.statutTaxeMensuelle = 'A_JOUR';
      }
      k.quittanceNumero = numeroQuittance;
      k.quittanceDate = _isoDate(DateTime.now());
      await _kiosques.put(k);
    });

    // Hors transaction : `putDemande` ouvre la sienne (Isar interdit les
    // transactions imbriquées).
    if (nature == 'INSTALLATION' || nature == 'DROIT_INSTALLATION') {
      await _propagerDroitInstallationPaye(kiosque.codeKiosque);
    }

    debugPrint(
      '[EmbeddedBackend] Encaissement $montant Ar enregistré ($numeroQuittance)',
    );
    return EncaissementResult(
      numeroQuittance: numeroQuittance,
      numeroAvisPaiement: kiosque.avisPaiementNumero,
      horodatage: encaissement.horodatage,
      message: 'Encaissement enregistré avec succès.',
    );
  }

  Future<String> _avisPour(String code) async {
    final k = await _kiosques.byCode(code.toUpperCase());
    return k?.avisPaiementNumero ?? '';
  }

  /// Le droit d'installation est encaissé sur le KIOSQUE ; le DOSSIER du
  /// demandeur doit suivre, sinon son écran de suivi continue d'afficher
  /// « en attente » et son historique affiche un solde dû alors que la
  /// quittance existe déjà.
  ///
  /// Lien retenu : le numéro de dossier porté par le kiosque s'il est renseigné,
  /// sinon le propriétaire du kiosque (évite d'édulcorer d'autres dossiers).
  Future<void> _propagerDroitInstallationPaye(String codeKiosque) async {
    final k = await _kiosques.byCode(codeKiosque.toUpperCase());
    if (k == null) return;
    final demandes = await _demandes.all();
    for (final d in demandes) {
      if (d.statutDroitInstallation == 'PAYE') continue;
      final lie = k.dossierEncoursNumero.isNotEmpty
          ? k.dossierEncoursNumero.toUpperCase() == d.codeDossier.toUpperCase()
          : PhoneValidator.normalize(d.telephone) == k.proprietaireTelephone;
      if (!lie) continue;
      d.statutDroitInstallation = 'PAYE';
      await _demandes.put(d);
    }
  }

  /// Droit d'installation payé si le DOSSIER dit PAYE, ou si le KIOSQUE qui
  /// porte CE numéro de dossier le dit (le kiosque est la source de vérité de
  /// l'encaissement).
  ///
  /// Un kiosque retrouvé par le seul propriétaire concerne un autre projet :
  /// il ne doit pas solder le droit d'un dossier sans kiosque.
  bool _droitPaye(Demande d, Kiosque? kiosque) {
    if (d.statutDroitInstallation == 'PAYE') return true;
    if (kiosque == null) return false;
    if (kiosque.dossierEncoursNumero.toUpperCase() !=
        d.codeDossier.toUpperCase()) {
      return false;
    }
    return kiosque.statutDroitInstallation == 'PAYE';
  }

  String _genererQuittance() {
    final now = DateTime.now();
    String p(int v) => v.toString().padLeft(2, '0');
    final seq = (_random.nextInt(900000) + 100000).toString();
    return 'QUIT-${now.year}${p(now.month)}${p(now.day)}-$seq';
  }

  String _isoDate(DateTime d) {
    String p(int v) => v.toString().padLeft(2, '0');
    return '${d.year}-${p(d.month)}-${p(d.day)}';
  }

  // --------------------------------------------------------------------------
  // sync_offline_queue(payload_list)
  // --------------------------------------------------------------------------
  @override
  Future<SyncResult> syncOfflineQueue(
    List<Map<String, dynamic>> payloadList,
  ) async {
    var success = 0;
    final erreurs = <String>[];
    final echecIds = <int>[];
    for (final item in payloadList) {
      final id = item['id'] is int ? item['id'] as int : -1;
      try {
        final method = item['method']?.toString() ?? '';
        final payload = item['payload'] is Map
            ? Map<String, dynamic>.from(item['payload'] as Map)
            : <String, dynamic>{};
        if (method == 'register_encaissement') {
          await registerEncaissement(payload);
          success++;
        } else if (method == 'submit_demande_autorisation') {
          await submitDemande(payload);
          success++;
        } else if (method == 'signaler_anomalie') {
          await signalerAnomalie(payload);
          success++;
        } else if (method == 'decider_demande') {
          await deciderDemande(payload);
          success++;
        } else {
          erreurs.add('Méthode inconnue: $method');
          if (id >= 0) echecIds.add(id);
        }
      } catch (e) {
        erreurs.add('$e');
        if (id >= 0) echecIds.add(id);
      }
    }
    return SyncResult(
      total: payloadList.length,
      success: success,
      erreurs: erreurs.length,
      messages: erreurs,
      echecIds: echecIds,
    );
  }

  // --------------------------------------------------------------------------
  // get_mes_dossiers(telephone) — enrichi de la situation fiscale réelle
  // (section 5.4 : historique des taxes annuelles de renouvellement).
  // --------------------------------------------------------------------------
  @override
  Future<List<Map<String, dynamic>>> getMesDossiers(String telephone) async {
    final norm = PhoneValidator.normalize(telephone);
    if (norm == null) return [];
    final list = await _demandes.byTelephone(norm);
    final kiosques = await _kiosques.all();

    // Déduplication par numéro de dossier : une base ayant conservé d'anciens
    // doublons (même `code_dossier`) ne doit pas les présenter au demandeur.
    // La liste est triée par date de création décroissante → le plus récent
    // l'emporte.
    final vus = <String>{};
    return list.where((d) => vus.add(d.codeDossier)).map((d) {
      final kiosque = _kiosqueLiantLeverage(kiosques, d.codeDossier, norm);
      // Parsing des lignes "année|montant|statut|quittance" du kiosque lié.
      final taxesAnnuel = kiosque?.taxesAnnuel ?? <String>[];
      return {
        'code_dossier': d.codeDossier,
        'statut': d.statut,
        'note_rejet': d.noteRejet,
        'montant_droit_installation': d.montantDroitInstallation,
        'statut_droit_installation': _droitPaye(d, kiosque)
            ? 'PAYE'
            : d.statutDroitInstallation,
        'nom_commercial': d.nomCommercial,
        'nom_prenoms': d.nomPrenoms,
        'fokontany': d.fokontany,
        // Lien vers le kiosque créé (quand il existe) : permet au demandeur
        // d'afficher le QR de référence de SON kiosque depuis le suivi.
        'code_kiosque': kiosque?.codeKiosque ?? '',
        'date_soumission': Formatters.dateISO(
          d.dateSoumission ?? d.dateCreation,
        ),
        'autorisation_numero': kiosque?.autorisationNumero ?? '',
        // --- Situation fiscale (source de vérité = serveur/kiosque lié) ---
        'statut_taxe_mensuelle': kiosque?.statutTaxeMensuelle ?? 'A_JOUR',
        'mois_retard_calcules': kiosque?.moisRetardCalcules ?? 0,
        'total_dette_ariary': kiosque?.totalDetteAriary ?? 0,
        'taxes_annuel': taxesAnnuel,
      };
    }).toList();
  }

  // --------------------------------------------------------------------------
  // get_demandes_agent() — liste d'instruction de l'agent communal (§ 4.4).
  // Aucun cloisonnement : l'agent voit TOUS les dossiers de la commune, du
  // plus récent au plus ancien. Les dossiers provisoires `OFFLINE-…` sont
  // exclus : leur numéro n'est pas encore officiel et il sera remplacé par la
  // reprise de la file (ce qui romprait le lien du kiosque).
  // --------------------------------------------------------------------------
  @override
  Future<List<Map<String, dynamic>>> getDemandesAgent() async {
    final demandes = await _demandes.all();
    final kiosques = await _kiosques.all();

    final vus = <String>{};
    final lignes = <Map<String, dynamic>>[];
    for (final d in demandes) {
      if (estCodeOffline(d.codeDossier)) continue;
      if (!vus.add(d.codeDossier)) continue;
      final kiosque = _kiosquePorteur(kiosques, d.codeDossier);
      lignes.add({
        'code_dossier': d.codeDossier,
        'statut': d.statut,
        'note_rejet': d.noteRejet,
        'telephone': d.telephone,
        'nom_prenoms': d.nomPrenoms,
        'cin': d.cin,
        'cin_date': d.cinDate,
        'cin_lieu': d.cinLieu,
        'quartier': d.quartier,
        'fokontany': d.fokontany,
        'nom_commercial': d.nomCommercial,
        'type_identification': d.typeIdentification,
        'operateurs': List<String>.from(d.operateurs),
        'materiaux_construction': d.materiauxConstruction,
        'kiosque_longueur': d.kiosqueLongueur,
        'kiosque_largeur': d.kiosqueLargeur,
        'emplacement_repere': d.emplacementRepere,
        'gps_latitude': d.gpsLatitude,
        'gps_longitude': d.gpsLongitude,
        'georestriction_resultat': d.georestrictionResultat,
        'pieces_jointes': [
          if (d.photoCinRectoPath.isNotEmpty) 'CIN recto',
          if (d.photoCinVersoPath.isNotEmpty) 'CIN verso',
          if (d.photoEmplacementPath.isNotEmpty) 'Emplacement',
        ],
        // Pièces numériques (chemins locaux lisibles sur l'appareil) : seul le
        // back-end embarqué les expose — le back-end distant n'a pas ces
        // champs, l'écran de détail affiche alors « NON DISPONIBLE DANS LE
        // BACKEND » plutôt qu'un vide trompeur.
        'photo_cin_recto': d.photoCinRectoPath,
        'photo_cin_verso': d.photoCinVersoPath,
        'photo_emplacement': d.photoEmplacementPath,
        'date_creation': Formatters.dateISO(d.dateCreation),
        'date_soumission': Formatters.dateISO(
          d.dateSoumission ?? d.dateCreation,
        ),
        'montant_droit_installation': d.montantDroitInstallation,
        'statut_droit_installation': _droitPaye(d, kiosque)
            ? 'PAYE'
            : d.statutDroitInstallation,
        'code_kiosque': kiosque?.codeKiosque ?? '',
        'autorisation_numero': kiosque?.autorisationNumero ?? '',
      });
    }
    lignes.sort((a, b) => (b['date_soumission'] ?? '')
        .toString()
        .compareTo((a['date_soumission'] ?? '').toString()));
    return lignes;
  }

  // --------------------------------------------------------------------------
  // decider_demande(payload) — approbation / rejet / corrections (§ 4.4).
  // --------------------------------------------------------------------------
  @override
  Future<DemandeDecision> deciderDemande(Map<String, dynamic> payload) async {
    final code = payload['code_dossier']?.toString().trim() ?? '';
    final decision = (payload['decision']?.toString() ?? '').toUpperCase();
    final note = payload['note']?.toString().trim() ?? '';

    if (code.isEmpty) throw ArgumentError('Numéro de dossier manquant.');
    if (estCodeOffline(code)) {
      throw ArgumentError(
        'Dossier hors-ligne provisoire : décision impossible tant que le '
        'numéro officiel n\'est pas attribué.',
      );
    }
    if (decision != 'APPROUVE' &&
        decision != 'REJETE' &&
        decision != 'EN_COURS_INSTRUCTION') {
      throw ArgumentError(
        'Décision inconnue : APPROUVE, REJETE ou EN_COURS_INSTRUCTION attendu.',
      );
    }
    if (decision != 'APPROUVE' && note.isEmpty) {
      throw ArgumentError(
        decision == 'REJETE'
            ? 'Le motif de rejet est obligatoire.'
            : 'La consigne de correction est obligatoire.',
      );
    }

    final d = await _demandes.byCode(code);
    if (d == null) throw ArgumentError('Dossier introuvable : $code');

    final noteFinale = decision == 'APPROUVE' ? '' : note;
    final kiosqueExistant = await _kiosqueDuDossier(d.codeDossier);

    // Idempotence : rejouer la même décision (file de synchronisation)
    // n'écrit rien et ne crée surtout pas un SECOND kiosque.
    if (d.statut == decision && d.noteRejet == noteFinale) {
      return DemandeDecision(
        codeDossier: d.codeDossier,
        statut: d.statut,
        note: d.noteRejet,
        codeKiosque: kiosqueExistant?.codeKiosque ?? '',
        autorisationNumero: kiosqueExistant?.autorisationNumero ?? '',
        message: 'Décision déjà enregistrée (réception dupliquée ignorée).',
      );
    }

    d.statut = decision;
    d.noteRejet = noteFinale;
    d.synchronise = true;
    await _demandes.put(d);

    // Approbation : la fiche kiosque naît ici. Elle rend le kiosque scannable
    // et permet l'encaissement du droit d'installation (§ 7.2) — sans elle le
    // dossier approuvé resterait sans suite.
    var codeKiosque = '';
    var autorisation = '';
    String message;
    if (decision == 'APPROUVE') {
      final kiosque = kiosqueExistant ?? await _creerKiosqueDuDossier(d);
      codeKiosque = kiosque.codeKiosque;
      autorisation = kiosque.autorisationNumero;
      message = kiosqueExistant != null
          ? 'Dossier approuvé (kiosque $codeKiosque déjà existant).'
          : 'Dossier approuvé : kiosque $codeKiosque créé, autorisation '
                '$autorisation délivrée.';
    } else if (decision == 'REJETE') {
      message = 'Dossier rejeté : $note';
    } else {
      message = 'Corrections demandées au demandeur : $note';
    }

    debugPrint('[EmbeddedBackend] Décision $decision — dossier $code');
    return DemandeDecision(
      codeDossier: d.codeDossier,
      statut: d.statut,
      note: d.noteRejet,
      codeKiosque: codeKiosque,
      autorisationNumero: autorisation,
      message: message,
    );
  }

  /// Kiosque qui porte CE numéro de dossier (lien direct — le repli par
  /// propriétaire rattacherait les autres projets du même demandeur).
  Kiosque? _kiosquePorteur(List<Kiosque> tous, String codeDossier) {
    for (final k in tous) {
      if (k.dossierEncoursNumero.isNotEmpty &&
          k.dossierEncoursNumero.toUpperCase() == codeDossier.toUpperCase()) {
        return k;
      }
    }
    return null;
  }

  Future<Kiosque?> _kiosqueDuDossier(String codeDossier) async =>
      _kiosquePorteur(await _kiosques.all(), codeDossier);

  /// Fiche kiosque issue du dossier approuvé (§ 5 → § 6).
  Future<Kiosque> _creerKiosqueDuDossier(Demande d) async {
    final kiosque = Kiosque(codeKiosque: await _codeKiosqueLibre())
      ..typeIdentification = d.typeIdentification.isEmpty
          ? AppConfig.typeIndividuel
          : d.typeIdentification
      ..proprietaireNom = d.nomPrenoms
      ..proprietaireTelephone =
          PhoneValidator.normalize(d.telephone) ?? d.telephone
      ..dossierEncoursNumero = d.codeDossier
      ..dossierEncoursDate = _isoDate(DateTime.now())
      ..autorisationNumero = await _autorisationLibre()
      ..autorisationDate = _isoDate(DateTime.now())
      ..kiosqueLongueur = d.kiosqueLongueur
      ..kiosqueLargeur = d.kiosqueLargeur
      ..emplacementRepere = d.emplacementRepere
      ..gpsLatitude = d.gpsLatitude
      ..gpsLongitude = d.gpsLongitude
      ..fokontany = d.fokontany
      ..materiauxConstruction = d.materiauxConstruction
      ..operationsActives = List<String>.from(d.operateurs)
      // Naissance fiscale : droit d'installation à régler, aucun retard.
      ..statutDroitInstallation = 'EN_ATTENTE'
      ..statutTaxeMensuelle = 'A_JOUR'
      ..isSynchronised = true
      ..lastSeenAt = DateTime.now();
    await _kiosques.put(kiosque);
    return kiosque;
  }

  /// Code kiosque non déjà attribué, au format du CDC (ex. « 6S001 »).
  Future<String> _codeKiosqueLibre() async {
    final annee = DateTime.now().year % 10;
    const lettres = 'SDKC';
    final lettre = lettres[DateTime.now().millisecondsSinceEpoch % 4];
    for (var i = 1; i < 1000; i++) {
      final code = '$annee$lettre${i.toString().padLeft(3, '0')}';
      if (await _kiosques.byCode(code) == null) return code;
    }
    return '$annee$lettre${_random.nextInt(900) + 100}';
  }

  /// Numéro d'autorisation non déjà délivré (format « 001CUF2026 »).
  Future<String> _autorisationLibre() async {
    final annee = DateTime.now().year;
    final attribues = (await _kiosques.all())
        .map((k) => k.autorisationNumero)
        .toSet();
    for (var i = 1; i < 1000; i++) {
      final numero = '${i.toString().padLeft(3, '0')}CUF$annee';
      if (!attribues.contains(numero)) return numero;
    }
    return '${_random.nextInt(900) + 100}CUF$annee';
  }

  // --------------------------------------------------------------------------
  // get_mes_paiements(telephone) — accès cloisonné (section 4.2).
  // Reconstruit l'historique du citoyen à partir des seules données le
  // concernant : demandes → kiosques liés → taxes + encaissements.
  // --------------------------------------------------------------------------
  @override
  Future<List<Map<String, dynamic>>> getMesPaiements(String telephone) async {
    final norm = PhoneValidator.normalize(telephone);
    if (norm == null) return [];
    final demandes = await _demandes.byTelephone(norm);
    final kiosques = await _kiosques.all();
    final anneeCourante = DateTime.now().year;

    final lignes = <Map<String, dynamic>>[];
    final quittancesVues = <String>{};
    // Voir getMesDossiers : un même numéro ne doit produire qu'une ligne.
    final dossiersVus = <String>{};

    for (final d in demandes) {
      if (!dossiersVus.add(d.codeDossier)) continue;
      final kiosque = _kiosqueLiantLeverage(kiosques, d.codeDossier, norm);
      final diPaye = _droitPaye(d, kiosque);
      // La quittance réelle de l'encaissement (le versement se fait chez
      // l'agent) plutôt qu'un « payé » sans preuve.
      Encaissement? diQuittance;
      if (diPaye && kiosque != null) {
        for (final e in await _encaissements.forKiosque(kiosque.codeKiosque)) {
          if (e.natureTaxe == 'INSTALLATION' ||
              e.natureTaxe == 'DROIT_INSTALLATION') {
            diQuittance = e;
            break;
          }
        }
      }
      lignes.add({
        'type': 'DROIT_INSTALLATION',
        'code_dossier': d.codeDossier,
        'nom_commercial': d.nomCommercial,
        'montant': d.montantDroitInstallation,
        'montant_paye': diPaye ? d.montantDroitInstallation : 0,
        'montant_du': diPaye ? 0 : d.montantDroitInstallation,
        'statut': diPaye ? 'PAYE' : 'EN_ATTENTE',
        'annee': null,
        'echeance': '',
        'date_paiement': diPaye
            ? Formatters.dateISO(
                diQuittance?.horodatage ?? d.dateSoumission ?? d.dateCreation,
              )
            : '',
        'numero_quittance': diQuittance?.numeroQuittance ?? '',
      });

      if (kiosque == null) continue;

      // --- Taxes annuelles déjà réglées (historique) ---
      for (final ligne in kiosque.taxesAnnuel) {
        final parts = ligne.split('|');
        if (parts.length < 3) continue;
        final annee = int.tryParse(parts[0]) ?? anneeCourante;
        final montant = int.tryParse(parts[1]) ?? 0;
        final statut = parts[2].toUpperCase();
        final quittance = parts.length > 3 ? parts[3] : '';
        if (quittance.isNotEmpty) quittancesVues.add(quittance);
        lignes.add({
          'type': 'RENOUVELLEMENT',
          'code_dossier': d.codeDossier,
          'nom_commercial': d.nomCommercial,
          'montant': montant,
          'montant_paye': statut == 'PAYE' ? montant : 0,
          'montant_du': statut == 'PAYE' ? 0 : montant,
          'statut': statut == 'PAYE' ? 'A_JOUR' : 'EN_RETARD',
          'annee': annee,
          'echeance': '$annee-11-11',
          'date_paiement': parts.length > 3 && parts[3].isNotEmpty
              ? parts[3]
              : '',
          'numero_quittance': quittance,
        });
      }

      // --- Exercice courant : dû ou à jour (statut calculé serveur) ---
      final aJour =
          kiosque.statutTaxeMensuelle == 'A_JOUR' ||
          kiosque.totalDetteAriary <= 0;
      final duCourant = aJour
          ? 0
          : (kiosque.totalDetteAriary > 0
                ? kiosque.totalDetteAriary
                : AppConfig.renouvellementAnnuelAriary);
      final dejaPayeCourant = kiosque.taxesAnnuel.any(
        (l) => l.startsWith('$anneeCourante|'),
      );
      if (!dejaPayeCourant) {
        lignes.add({
          'type': 'RENOUVELLEMENT',
          'code_dossier': d.codeDossier,
          'nom_commercial': d.nomCommercial,
          'montant': AppConfig.renouvellementAnnuelAriary,
          'montant_paye': aJour ? AppConfig.renouvellementAnnuelAriary : 0,
          'montant_du': duCourant,
          'statut': aJour ? 'A_JOUR' : 'EN_RETARD',
          'annee': anneeCourante,
          'echeance': '$anneeCourante-11-11',
          'date_paiement': '',
          'numero_quittance': '',
        });
      }

      // --- Encaissements liés au kiosque (quittances émises sur le terrain) ---
      final encaissements = await _encaissements.forKiosque(
        kiosque.codeKiosque,
      );
      for (final e in encaissements) {
        // Une quittance déjà reprise dans l'historique des taxes est ignorée
        // pour éviter les doublons d'affichage.
        if (e.numeroQuittance.isNotEmpty &&
            quittancesVues.contains(e.numeroQuittance)) {
          continue;
        }
        final nature = e.natureTaxe.toUpperCase();
        final droit =
            nature == 'INSTALLATION' || nature == 'DROIT_INSTALLATION';
        // Le droit d'installation a déjà sa ligne d'en-tête (soldée, avec la
        // quittance) : le lister en plus le ferait apparaître deux fois.
        if (droit &&
            diQuittance != null &&
            e.numeroQuittance == diQuittance.numeroQuittance) {
          continue;
        }
        lignes.add({
          'type': droit ? 'DROIT_INSTALLATION' : 'RENOUVELLEMENT',
          'code_dossier': d.codeDossier,
          'nom_commercial': kiosque.codeKiosque,
          'montant': e.montant,
          'montant_paye': e.montant,
          'montant_du': 0,
          'statut': 'PAYE',
          'annee': e.horodatage.year,
          'echeance': '',
          'date_paiement': Formatters.dateISO(e.horodatage),
          'numero_quittance': e.numeroQuittance,
        });
      }
    }

    // Tri chronologique décroissant (les plus récents d'abord).
    lignes.sort((a, b) {
      final da = _datePaiementTri(a);
      final db = _datePaiementTri(b);
      return db.compareTo(da);
    });
    return lignes;
  }

  DateTime _datePaiementTri(Map<String, dynamic> ligne) {
    final raw = ligne['date_paiement']?.toString() ?? '';
    final d = DateTime.tryParse(raw);
    if (d != null) return d;
    // À défaut de date de paiement (exercice en cours / dû), on trie sur
    // l'échéance pour faire remonter les lignes pertinentes.
    final echeance = ligne['echeance']?.toString() ?? '';
    final dEcheance = DateTime.tryParse(echeance);
    if (dEcheance != null) return dEcheance;
    return DateTime(1970, 1, 1);
  }

  /// Retrouve le kiosque lié au dossier d'un demandeur :
  ///  - par le numéro du dossier en cours (dossier_encours_numero),
  ///  - ou par le téléphone du propriétaire enregistré dans la fiche.
  Kiosque? _kiosqueLiantLeverage(
    List<Kiosque> tous,
    String codeDossier,
    String norm,
  ) {
    for (final k in tous) {
      if (k.dossierEncoursNumero.isNotEmpty &&
          k.dossierEncoursNumero.toUpperCase() == codeDossier.toUpperCase()) {
        return k;
      }
    }
    for (final k in tous) {
      if (k.proprietaireTelephone == norm) return k;
    }
    return null;
  }

  // --------------------------------------------------------------------------
  // get_zones_interdites() — écran cartographique, section 5.3.
  // --------------------------------------------------------------------------
  @override
  Future<List<Map<String, dynamic>>> getZonesInterdites() async {
    return [
      for (final z in _zonesInterdites)
        {
          'label': z['label'],
          'latitude': z['lat'],
          'longitude': z['lon'],
          'rayon_metres': z['rayon'],
        },
    ];
  }

  // --------------------------------------------------------------------------
  // Grille tarifaire (section 7.1)
  // --------------------------------------------------------------------------
  @override
  Future<List<Map<String, dynamic>>> getGrilleTarifaire() async {
    return [
      {
        'nom': 'Droit d\'installation Mobile Money',
        'montant': AppConfig.droitInstallationAriary,
        'modalite': 'Taxe initiale unique — paiement via agent communal',
      },
      {
        'nom': 'Renouvellement Mobile Money',
        'montant': AppConfig.renouvellementAnnuelAriary,
        'modalite': 'Taxe annuelle à la date anniversaire de l\'autorisation',
      },
    ];
  }

  // --------------------------------------------------------------------------
  // signaler_anomalie(payload)
  // --------------------------------------------------------------------------
  @override
  Future<ResultatAnomalie> signalerAnomalie(
    Map<String, dynamic> payload,
  ) async {
    // Idempotence : une anomalie déjà transmise (même référence) n'est pas
    // dupliquée lors du rejeu de la file sync_offline_queue (section 11).
    final reference = payload['reference']?.toString() ?? '';
    if (reference.isNotEmpty) {
      final existantes = await _anomalies.all();
      for (final a in existantes) {
        if (a.reference == reference) {
          return ResultatAnomalie(
            reference: a.reference,
            statut: a.statut,
            message: 'Anomalie déjà transmise (réception dupliquée ignorée).',
          );
        }
      }
    }

    final anomalie = Anomalie(
      typeAnomalie: payload['type_anomalie']?.toString() ?? 'NON_DECLARE',
      agentTelephone: payload['agent_telephone']?.toString() ?? '',
      agentSessionToken: payload['session_token']?.toString() ?? '',
    );
    anomalie.codeKiosque = payload['code_kiosque']?.toString() ?? '';
    anomalie.description = payload['description']?.toString() ?? '';
    anomalie.gpsLatitude = dblOf(payload, 'gps_lat');
    anomalie.gpsLongitude = dblOf(payload, 'gps_lon');
    anomalie.reference = reference.isNotEmpty
        ? reference
        : 'AN-${DateTime.now().millisecondsSinceEpoch % 100000}';
    await _anomalies.put(anomalie);

    debugPrint('[EmbeddedBackend] Anomalie signalée: ${anomalie.reference}');

    // Anomalie -> Notification durable du Demandeur concerné (section 6.5).
    // On ne notifie que lorsque le kiosque est connu : on peut alors relier le
    // signalement au propriétaire. Sinon (kiosque non déclaré), aucune boîte de
    // réception ne peut être retrouvée — pas de notification orpheline.
    await _notifierAnomalie(anomalie);

    return ResultatAnomalie(
      reference: anomalie.reference,
      statut: 'EN_ATTENTE',
      message: 'Anomalie transmise au service de la commune.',
    );
  }

  /// Crée la notification persistante du demandeur lorsqu'on peut identifier
  /// le propriétaire du kiosque en défaut. Idempotente : un même id_unique
  /// remplace la ligne existante (index unique + replace).
  Future<void> _notifierAnomalie(Anomalie anomalie) async {
    final code = anomalie.codeKiosque.trim().toUpperCase();
    if (code.isEmpty) return;
    final kiosque = await _kiosques.byCode(code);
    final telephone = kiosque?.proprietaireTelephone;
    if (kiosque == null ||
        telephone == null ||
        PhoneValidator.normalize(telephone) == null) {
      return;
    }
    final destinataire = PhoneValidator.normalize(telephone)!;
    await _notifications.put(
      NotificationItem(
        idUnique: 'anomalie-${anomalie.reference}',
        destinataire: destinataire,
        type: 'ANOMALIE_SIGNALLEE',
        codeKiosque: code,
        typeAnomalie: anomalie.typeAnomalie,
        messageAgent: anomalie.description,
        referenceAnomalie: anomalie.reference,
      ),
    );
    debugPrint(
      '[EmbeddedBackend] Notification d\'anomalie écrite pour $destinataire',
    );
  }

  // --------------------------------------------------------------------------
  // get_notifications(telephone) / mark_notification_lu(id_unique)
  // Sections 6.5 et 7 : boîte de réception persistante du Demandeur.
  // --------------------------------------------------------------------------
  @override
  Future<List<Map<String, dynamic>>> getNotifications(
    String telephone,
  ) async {
    final norm = PhoneValidator.normalize(telephone);
    if (norm == null) return [];
    final items = await _notifications.forTelephone(norm);
    return [
      for (final n in items)
        {
          'id_unique': n.idUnique,
          'type': n.type,
          'code_kiosque': n.codeKiosque,
          'type_anomalie': n.typeAnomalie,
          'message_agent': n.messageAgent,
          'reference_anomalie': n.referenceAnomalie,
          'date': _isoDate(n.date),
          'lu': n.lu,
          'important': n.important,
        },
    ];
  }

  @override
  Future<void> markNotificationLu(String idUnique) =>
      _notifications.markLu(idUnique);

  // --- Gestion directe des comptes (admin back-office) ---
  Future<AppUser?> _agentSeed() async {
    return await _users.findByTelephone('340000001');
  }

  /// Crée le compte agent de démonstration (créé côté back-office admin).
  Future<void> provisionAgentCompte() async {
    final ext = await _agentSeed();
    if (ext != null) return;
    final agent = AppUser(
      telephone: '340000001',
      pinCode: Crypto.sha256('1234'),
      nom: 'RAZAFIMANDIMBY Hery',
      role: 'agent_communal',
    );
    agent.isVerified = true;
    await _users.put(agent);
    debugPrint(
      '[EmbeddedBackend] Compte agent démo provisionné: 034 00 000 01 / 1234',
    );
  }

  /// Crée le compte citoyen de démonstration (034 00 000 02 / 1234) avec :
  ///  - un dossier approuvé et son kiosque lié (droit payé + historique de
  ///    renouvellements) → « Mes paiements » et « Suivi » pleinement démontrables ;
  ///  - un dossier en cours d'instruction en parallèle.
  Future<void> provisionCitoyenDemo() async {
    const tel = '340000002';
    if (await _users.findByTelephone(tel) != null) return;

    final citoyen = AppUser(
      telephone: tel,
      pinCode: Crypto.sha256('1234'),
      nom: 'RASOANANDRASANA',
      role: 'demandeur',
    );
    citoyen.prenom = 'Claire';
    citoyen.cin = '108 012 345 678';
    citoyen.fokontany = 'Ankidona';
    citoyen.isVerified = true;
    await _users.put(citoyen);

    // Dossier approuvé + kiosque lié (situation fiscale réelle : 2 ans payés,
    // exercice N en retard de 10 mois => 100 000 Ar dus).
    final approuve = Demande(telephone: tel, codeDossier: 'CUF2026-22145')
      ..nomPrenoms = 'RASOANANDRASANA Claire'
      ..nomCommercial = 'Kiosque Mirindra'
      ..fokontany = 'Ankidona'
      ..statut = 'APPROUVE'
      ..montantDroitInstallation = AppConfig.droitInstallationAriary
      ..statutDroitInstallation = 'PAYE'
      ..georestrictionResultat = 'OK'
      ..soumiseLocalement = true
      ..dateSoumission = DateTime(2025, 11, 11);
    await _demandes.put(approuve);

    final enCours = Demande(telephone: tel, codeDossier: 'CUF2026-22189')
      ..nomPrenoms = 'RASOANANDRASANA Claire'
      ..nomCommercial = 'Kiosque Radius Tsaralalana'
      ..fokontany = 'Andrainjato'
      ..statut = 'EN_COURS_INSTRUCTION'
      ..montantDroitInstallation = AppConfig.droitInstallationAriary
      ..statutDroitInstallation = 'EN_ATTENTE'
      ..georestrictionResultat = 'OK'
      ..soumiseLocalement = true
      ..dateSoumission = DateTime.now().subtract(const Duration(days: 3));
    await _demandes.put(enCours);

    final kiosque = Kiosque(codeKiosque: '2D001')
      ..statutFiche = 'Final'
      ..typeIdentification = AppConfig.typeIndividuel
      ..proprietaireNom = 'RASOANANDRASANA Claire'
      ..proprietaireTelephone = tel
      ..autorisationNumero = '221CUF2026'
      ..autorisationDate = '2025-11-11'
      ..dossierEncoursNumero = approuve.codeDossier
      ..dossierEncoursDate = '2025-11-11'
      ..avisPaiementNumero = '2394504D'
      ..avisPaiementDate = '2025-11-11'
      ..quittanceNumero = 'QUIT-20261111-700123'
      ..quittanceDate = '2025-11-11'
      ..kiosqueLongueur = 1.5
      ..kiosqueLargeur = 2.0
      ..emplacementRepere = 'Ankidona akaikin\'ny poissonerie'
      ..gpsLatitude = -21.4673152
      ..gpsLongitude = 47.0667377
      ..fokontany = 'Ankidona'
      ..materiauxConstruction = 'Tôles'
      ..operationsActives = ['MVola', 'Orange Money', 'Airtel Money']
      ..terrainOccupation = 'Terrain privé'
      ..statutDroitInstallation = 'PAYE'
      ..statutTaxeMensuelle = 'REDEVABLE'
      ..moisRetardCalcules = 10
      ..totalDetteAriary = 100000
      ..taxesAnnuel = [
        '2024|120000|PAYE|QUIT-20241205-100234',
        '2025|120000|PAYE|QUIT-20251205-100345',
      ]
      ..isSynchronised = true;
    await _kiosques.put(kiosque);

    // Deux encaissements de renouvellement tracés (section 6.4).
    final paiement1 = Encaissement(
      codeKiosque: kiosque.codeKiosque,
      nomKiosque: kiosque.codeKiosque,
      proprietaireNom: kiosque.proprietaireNom,
      montant: AppConfig.renouvellementAnnuelAriary,
      natureTaxe: 'RENOUVELLEMENT',
      agentTelephone: '340000001',
      agentSessionToken: 'seed-demo',
    );
    paiement1.numeroQuittance = 'QUIT-20241205-100234';
    paiement1.horodatage = DateTime(2024, 12, 5, 10, 30);
    paiement1.enAttenteSynchro = false;
    await _encaissements.put(paiement1);

    final paiement2 = Encaissement(
      codeKiosque: kiosque.codeKiosque,
      nomKiosque: kiosque.codeKiosque,
      proprietaireNom: kiosque.proprietaireNom,
      montant: AppConfig.renouvellementAnnuelAriary,
      natureTaxe: 'RENOUVELLEMENT',
      agentTelephone: '340000001',
      agentSessionToken: 'seed-demo',
    );
    paiement2.numeroQuittance = 'QUIT-20251205-100345';
    paiement2.horodatage = DateTime(2025, 12, 5, 9, 15);
    paiement2.enAttenteSynchro = false;
    await _encaissements.put(paiement2);

    debugPrint(
      '[EmbeddedBackend] Compte citoyen démo provisionné: 034 00 000 02 / 1234',
    );
  }
}
