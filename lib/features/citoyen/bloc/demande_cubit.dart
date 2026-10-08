import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/network/xml_rpc_codec.dart' show XmlRpcFault;
import '../../../core/security/secure_store.dart';
import '../../../core/service/sync_service.dart';
import '../../../core/utils/validators.dart';
import '../../../data/local/repositories/demande_repo.dart';
import '../../../data/remote/cuf_backend.dart';
import '../../../data/remote/demande_payload.dart';

/// Formulaire séquentiel en 3 étapes (section 5.1) + suivi du dossier (5.4),
/// historique des paiements (5.4 / 4.2) et zones d'exclusion (5.3).
class DemandeState {
  final int step;
  final Map<String, dynamic> fields;
  final bool gpsCaptured;
  final double? gpsLat;
  final double? gpsLon;
  final bool submitting;
  final String? error;
  final String? geoMessage;
  final bool? geoAllowed;
  final bool success;
  final String? codeDossier;

  /// Nombre d'éléments en attente d'envoi dans la file de synchronisation.
  ///
  /// Alimente l'avertissement « enregistré localement, en attente d'envoi »
  /// : sans lui, l'écran de confirmation afficherait un succès total alors que
  /// le dossier n'est encore que local.
  final int pendingSync;

  final List<Map<String, dynamic>> dossiers;
  final bool loadingDossiers;
  final List<Map<String, dynamic>> paiements;
  final bool loadingPaiements;
  final List<Map<String, dynamic>> zonesInterdites;
  final bool loadingZones;

  /// Notifications persistantes du demandeur (section 6.5 : anomalies
  /// signalées par l'agent). Lignes : {id_unique, type, code_kiosque,
  /// type_anomalie, message_agent, reference_anomalie, date, lu, important}.
  /// Complètent les notifications dérivées (dossiers + paiements).
  final List<Map<String, dynamic>> notifications;
  final bool loadingNotifications;

  /// Échec de la dernière lecture (suivi des dossiers / historique des
  /// paiements) — distinct de [error] qui porte les erreurs de soumission et
  /// déclenche déjà le SnackBar du formulaire. Sans ce champ, une liste vide
  /// pour cause de panne réseau s'affichait comme « aucun dossier ».
  final String? erreurLecture;

  const DemandeState({
    this.step = 0,
    this.fields = const {},
    this.gpsCaptured = false,
    this.gpsLat,
    this.gpsLon,
    this.submitting = false,
    this.error,
    this.geoMessage,
    this.geoAllowed,
    this.success = false,
    this.codeDossier,
    this.pendingSync = 0,
    this.dossiers = const [],
    this.loadingDossiers = false,
    this.paiements = const [],
    this.loadingPaiements = false,
    this.zonesInterdites = const [],
    this.loadingZones = false,
    this.notifications = const [],
    this.loadingNotifications = false,
    this.erreurLecture,
  });

  /// Copie de l'état.
  ///
  /// Les champs **nullables** (`gpsLat`, `gpsLon`, `error`, `geoAllowed`,
  /// `geoMessage`, `codeDossier`) ne peuvent pas être remis à `null` avec un
  /// simple `copyWith(valeur: null)` : pour un paramètre nullable, `null`
  /// signifie « ne pas modifier ». Ils sont donc conservés par défaut et
  /// effacés **explicitement** via les drapeaux `clear*`.
  ///
  /// Régression corrigée : `gpsLat`/`gpsLon`/`geoAllowed`/`error`/`codeDossier`
  /// étaient recopiés tels quels (`gpsLat: gpsLat`), donc remis à `null` à
  /// CHAQUE `copyWith`. Conséquences réelles :
  ///  - `checkLocationAllowance()` effaçait les coordonnées qu'elle lisait juste
  ///    après → `Null check operator used on a null value` (ligne 206) ; la
  ///    capture GPS échouait toujours, `geoAllowed` restait `null` et le bouton
  ///    « Soumettre » restait désactivé — le demandeur ne pouvait rien soumettre ;
  ///  - `submit()` lisait `state.geoAllowed` après l'avoir effacé et transmettait
  ///    donc `georestriction_resultat: 'BLOQUE'` en permanence ;
  ///  - `setGps(geoMessage: null)` ne vidait jamais l'ancien message, qui
  ///    restait affiché après un nouveau relevé.
  DemandeState copyWith({
    int? step,
    Map<String, dynamic>? fields,
    bool? gpsCaptured,
    double? gpsLat,
    double? gpsLon,
    bool? submitting,
    String? error,
    bool clearError = false,
    String? geoMessage,
    bool clearGeoMessage = false,
    bool? geoAllowed,
    bool clearGeoAllowed = false,
    bool? success,
    String? codeDossier,
    bool clearCodeDossier = false,
    int? pendingSync,
    List<Map<String, dynamic>>? dossiers,
    bool? loadingDossiers,
    List<Map<String, dynamic>>? paiements,
    bool? loadingPaiements,
    List<Map<String, dynamic>>? zonesInterdites,
    bool? loadingZones,
    List<Map<String, dynamic>>? notifications,
    bool? loadingNotifications,
    String? erreurLecture,
    bool clearErreurLecture = false,
  }) {
    return DemandeState(
      step: step ?? this.step,
      fields: fields ?? this.fields,
      gpsCaptured: gpsCaptured ?? this.gpsCaptured,
      gpsLat: gpsLat ?? this.gpsLat,
      gpsLon: gpsLon ?? this.gpsLon,
      submitting: submitting ?? this.submitting,
      error: clearError ? null : (error ?? this.error),
      geoMessage: clearGeoMessage ? null : (geoMessage ?? this.geoMessage),
      geoAllowed: clearGeoAllowed ? null : (geoAllowed ?? this.geoAllowed),
      success: success ?? this.success,
      codeDossier: clearCodeDossier ? null : (codeDossier ?? this.codeDossier),
      pendingSync: pendingSync ?? this.pendingSync,
      dossiers: dossiers ?? this.dossiers,
      loadingDossiers: loadingDossiers ?? this.loadingDossiers,
      paiements: paiements ?? this.paiements,
      loadingPaiements: loadingPaiements ?? this.loadingPaiements,
      zonesInterdites: zonesInterdites ?? this.zonesInterdites,
      loadingZones: loadingZones ?? this.loadingZones,
      notifications: notifications ?? this.notifications,
      loadingNotifications: loadingNotifications ?? this.loadingNotifications,
      erreurLecture: clearErreurLecture
          ? null
          : (erreurLecture ?? this.erreurLecture),
    );
  }
}

class DemandeCubit extends Cubit<DemandeState> {
  final CufBackend _backend;
  final DemandeRepo _repo;
  final SyncService _sync;

  DemandeCubit(this._backend, this._repo, this._sync)
    : super(const DemandeState());

  void setField(String key, dynamic value) {
    final fields = Map<String, dynamic>.from(state.fields);
    fields[key] = value;
    emit(state.copyWith(fields: fields, clearError: true));
    _persistDraft(fields: fields);
  }

  void nextStep() {
    if (state.step < 2) {
      final next = state.step + 1;
      emit(state.copyWith(step: next));
      _persistDraft(step: next);
    }
  }

  void prevStep() {
    if (state.step > 0) {
      final prev = state.step - 1;
      emit(state.copyWith(step: prev));
      _persistDraft(step: prev);
    }
  }

  void setGps(double lat, double lon) {
    final fields = Map<String, dynamic>.from(state.fields);
    fields['gps_latitude'] = lat;
    fields['gps_longitude'] = lon;
    // Un nouveau relevé GPS invalide l'ancien résultat de restriction.
    emit(
      state.copyWith(
        fields: fields,
        gpsCaptured: true,
        gpsLat: lat,
        gpsLon: lon,
        clearGeoAllowed: true,
        clearGeoMessage: true,
      ),
    );
    _persistDraft(fields: fields);
  }

  void setGeoResult(bool allowed, String message) {
    emit(state.copyWith(geoAllowed: allowed, geoMessage: message));
    _persistDraft(geoAllowed: allowed, geoMessage: message);
  }

  void resetError() => emit(state.copyWith(clearError: true));

  void reset() {
    emit(const DemandeState());
    SecureStore.instance.clearDraftDemande();
  }

  // --------------------------------------------------------------------------
  // Persistance du brouillon (offline-first, section 11).
  // --------------------------------------------------------------------------
  void loadDraft() {
    final draft = SecureStore.instance.loadDraftDemande();
    if (draft == null) return;
    final fields = Map<String, dynamic>.from(
      draft['fields'] as Map? ?? const <String, dynamic>{},
    );
    final lat = double.tryParse('${fields['gps_latitude'] ?? ''}');
    final lon = double.tryParse('${fields['gps_longitude'] ?? ''}');
    emit(
      DemandeState(
        step: (draft['step'] as num?)?.toInt() ?? 0,
        fields: fields,
        gpsCaptured: lat != null && lon != null,
        gpsLat: lat,
        gpsLon: lon,
        geoAllowed: draft['geoAllowed'] as bool?,
        geoMessage: draft['geoMessage'] as String?,
      ),
    );
  }

  void _persistDraft({
    Map<String, dynamic>? fields,
    int? step,
    bool? geoAllowed,
    String? geoMessage,
  }) {
    SecureStore.instance.saveDraftDemande(
      fields: fields ?? state.fields,
      step: step ?? state.step,
      geoAllowed: geoAllowed ?? state.geoAllowed,
      geoMessage: geoMessage ?? state.geoMessage,
    );
  }

  /// check_location_allowance(latitude, longitude) — section 5.3.
  Future<void> checkLocationAllowance() async {
    final lat = state.gpsLat;
    final lon = state.gpsLon;
    if (!state.gpsCaptured || lat == null || lon == null) {
      emit(state.copyWith(error: 'Position GPS non capturée'));
      return;
    }
    emit(state.copyWith(clearGeoAllowed: true, clearGeoMessage: true));
    final allowance = await _backend.checkLocationAllowance(lat, lon);
    emit(
      state.copyWith(
        geoAllowed: allowance.allowed,
        geoMessage: allowance.message,
      ),
    );
  }

  /// submit_demande_autorisation(payload) — section 5.
  ///
  /// Offline-first (§ 11) : la demande est d'abord tentée auprès du back-end,
  /// et **uniquement en cas de panne de transport** écrite localement puis
  /// mise en file.
  ///
  /// Distinction indispensable entre deux familles d'échecs :
  ///  - **transport** (pas de réseau, timeout, HTTP non 200) : la demande est
  ///    mise en file, un numéro de dossier local est attribué, l'écran affiche
  ///    explicitement « enregistrée localement, en attente d'envoi » ;
  ///  - **refus métier** (dossier rejeté, champ invalide, droits insuffisants)
  ///    ou **réponse serveur illisible** : l'écran affiche l'erreur telle
  ///    quelle et rien n'est conservé.
  ///
  /// Régression corrigée : le succès serveur déclenchait **à la fois**
  ///  1. une écriture locale du dossier déjà écrit par le back-end, et
  ///  2. une mise en file du payload **sans `code_dossier`**.
  /// La purge régénérait alors un numéro différent : une seule soumission
  /// produisait jusqu'à trois dossiers distincts dans le suivi.
  Future<void> submit(String telephone) async {
    // Deux appels superposés (double appui, replay de test) créeraient deux
    // dossiers : la soumission est déjà en cours.
    if (state.submitting) return;

    emit(
      state.copyWith(
        submitting: true,
        clearError: true,
        success: false,
        clearCodeDossier: true,
      ),
    );

    // § 13 : la restriction géographique est une contrainte MÉTIER, pas une
    // simple aide à l'écran. Le bouton « Soumettre » désactivé n'en est qu'un
    // reflet : sans ce garde-fou dans le Cubit, l'appel direct à `submit()`
    // enverrait un dossier implanté en zone interdite.
    if (state.geoAllowed != true) {
      emit(
        state.copyWith(
          submitting: false,
          success: false,
          error: state.gpsCaptured
              ? 'Implantation interdite dans la zone choisie : la demande ne peut pas être soumise.'
              : 'Position GPS non capturée : la demande ne peut pas être soumise.',
        ),
      );
      return;
    }

    // Format canonique (9 chiffres sans 0 initial) : c'est celui stocké en
    // base et réintroduit comme argument de `get_mes_dossiers` /
    // `get_mes_paiements` — un numéro non normalisé rendait le dossier
    // invisible dans le suivi.
    final tel = PhoneValidator.normalize(telephone) ?? telephone;

    final payload = Map<String, dynamic>.from(state.fields);
    payload['telephone'] = tel;
    payload['georestriction_resultat'] = (state.geoAllowed ?? false)
        ? 'OK'
        : 'BLOQUE';
    payload['photo_cin_recto'] = state.fields['photo_cin_recto'] ?? '';
    payload['photo_cin_verso'] = state.fields['photo_cin_verso'] ?? '';
    payload['photo_emplacement'] = state.fields['photo_emplacement'] ?? '';

    DemandeResult? resultat;
    Object? erreur;

    try {
      resultat = await _backend.submitDemande(payload);
    } catch (e) {
      erreur = e;
    }

    if (resultat != null) {
      // Le back-end a DÉJÀ persisté le dossier : ni seconde écriture locale,
      // ni mise en file — le replay aurait régénéré un doublon. Seul le
      // brouillon est consumé.
      SecureStore.instance.clearDraftDemande();
      unawaited(_sync.flush());
      emit(
        state.copyWith(
          submitting: false,
          success: true,
          codeDossier: resultat.codeDossier,
          // Dossier confirmé : aucun élément de CE dossier en attente.
          pendingSync: 0,
        ),
      );
      return;
    }

    if (!_estPanneReseau(erreur!)) {
      // Refus métier ou réponse illisible : rien n'est enregistré, le
      // demandeur doit corriger sa demande.
      emit(state.copyWith(submitting: false, error: _message(erreur)));
      return;
    }

    // Panne réseau : la demande est conservée localement et mise en file.
    final codeLocal = await _enregistrerLocalement(tel, payload);
    if (codeLocal == null) {
      emit(
        state.copyWith(
          submitting: false,
          error:
              'Dossier enregistré sur l\'appareil mais mise en file impossible : $erreur',
        ),
      );
      return;
    }
    unawaited(_sync.flush());
    emit(
      state.copyWith(
        submitting: false,
        success: true,
        codeDossier: codeLocal,
        // `pendingSync` pilote l'avertissement « en attente d'envoi » de l'écran.
        pendingSync: await _sync.pendingCount(),
      ),
    );
  }

  /// Écrit le dossier en local (numéro provisoire) et le met en file.
  ///
  /// Le payload rejoué porte le `code_dossier` provisoire : c'est la
  /// clé d'idempotence qui permet au back-end, au moment de la reprise, de
  /// **remplacer** ce dossier par un dossier à numéro officiel au lieu d'en
  /// créer un second.
  ///
  /// Renvoie le numéro attribué, ou `null` si l'écriture locale a échoué.
  Future<String?> _enregistrerLocalement(
    String telephone,
    Map<String, dynamic> payload,
  ) async {
    try {
      final code =
          '$codeDossierOfflinePrefix${DateTime.now().millisecondsSinceEpoch % 99999}';
      // Même mapping que la voie serveur : le dossier hors-ligne contient
      // tous les champs (GPS, dimensions, repères, pièces jointes).
      final d = demandeDepuisPayload(
        payload,
        telephone: telephone,
        codeDossier: code,
      );
      await _repo.put(d);

      final aRejouer = Map<String, dynamic>.from(payload)
        ..['code_dossier'] = code;
      await _sync.enqueue('submit_demande_autorisation', aRejouer);
      SecureStore.instance.clearDraftDemande();
      return code;
    } catch (e) {
      debugPrint('[DemandeCubit] enregistrement local impossible : $e');
      return null;
    }
  }

  /// L'erreur autorise-t-elle un repli hors-ligne ?
  ///
  /// Seul un incident de transport HTTP/XML-RPC le permet. Un refus métier
  /// (`ArgumentError` renvoyé par le back-end) ou une réponse serveur
  /// inexploitable ne doit jamais devenir un succès local.
  bool _estPanneReseau(Object erreur) {
    if (erreur is ArgumentError) return false;
    if (erreur is XmlRpcFault) return erreur.isTransport;
    return false;
  }

  /// Message affichable au demandeur (jamais de trace technique brute).
  String _message(Object erreur) {
    if (erreur is ArgumentError) {
      return erreur.message?.toString().replaceFirst(
            'Invalid argument(s): ',
            '',
          ) ??
          'Demande refusée par le serveur.';
    }
    if (erreur is XmlRpcFault) {
      return 'Le serveur a refusé la demande (code ${erreur.code}). '
          'Aucune donnée n\'a été enregistrée : vérifiez votre dossier.';
    }
    return 'La demande n\'a pas pu être transmise et n\'a pas été enregistrée.';
  }

  /// Historique des dossiers du demandeur (accès cloisonné, section 4.2).
  ///
  /// Le numéro est normalisé **et** la fusion est dédupliquée par
  /// `code_dossier` : les bases contenant encore d'anciens doublons ne
  /// doivent pas les afficher plusieurs fois dans le suivi.
  Future<void> loadDossiers(String telephone) async {
    emit(state.copyWith(loadingDossiers: true, clearErreurLecture: true));
    try {
      final tel = PhoneValidator.normalize(telephone) ?? telephone;
      final list = await _backend.getMesDossiers(tel);
      final local = await _repo.byTelephone(tel);

      final vus = <String>{};
      final merged = <Map<String, dynamic>>[];
      for (final e in list) {
        final code = e['code_dossier']?.toString() ?? '';
        if (code.isNotEmpty && vus.add(code)) merged.add(e);
      }
      // Un dossier connu du back-end n'est pas repris depuis le dépôt local ;
      // l'ordre des entrées (plus récente d'abord) départage les doublons.
      for (final d in local) {
        if (vus.add(d.codeDossier)) {
          merged.add({
            'code_dossier': d.codeDossier,
            'statut': d.statut,
            'montant_droit_installation': d.montantDroitInstallation,
            'statut_droit_installation': d.statutDroitInstallation,
            'nom_commercial': d.nomCommercial,
          });
        }
      }
      emit(state.copyWith(dossiers: merged, loadingDossiers: false));
    } catch (e) {
      emit(state.copyWith(loadingDossiers: false, erreurLecture: '$e'));
    }
  }

  /// Historique des paiements du demandeur (accès cloisonné, section 4.2).
  Future<void> loadPaiements(String telephone) async {
    emit(state.copyWith(loadingPaiements: true, clearErreurLecture: true));
    try {
      final tel = PhoneValidator.normalize(telephone) ?? telephone;
      final list = await _backend.getMesPaiements(tel);
      emit(state.copyWith(paiements: list, loadingPaiements: false));
    } catch (e) {
      emit(state.copyWith(loadingPaiements: false, erreurLecture: '$e'));
    }
  }

  /// Zones interdites pour l'écran cartographique (section 5.3).
  Future<void> loadZonesInterdites() async {
    if (state.zonesInterdites.isNotEmpty) return;
    emit(state.copyWith(loadingZones: true));
    try {
      final zones = await _backend.getZonesInterdites();
      emit(state.copyWith(zonesInterdites: zones, loadingZones: false));
    } catch (e) {
      emit(state.copyWith(loadingZones: false));
    }
  }

  /// Boîte de réception persistante du demandeur (section 6.5 / 7).
  ///
  /// Les notifications d'anomalie sont stockées en base par le back-end lors du
  /// signalement de l'agent : elles ne dépendent pas du réseau et leur état
  /// « lu » survit au redémarrage.
  Future<void> loadNotifications(String telephone) async {
    emit(state.copyWith(loadingNotifications: true));
    try {
      final tel = PhoneValidator.normalize(telephone) ?? telephone;
      final list = await _backend.getNotifications(tel);
      emit(state.copyWith(notifications: list, loadingNotifications: false));
    } catch (e) {
      emit(state.copyWith(loadingNotifications: false, erreurLecture: '$e'));
    }
  }

  /// Marque LUE une notification d'anomalie (persistant côté back-end local).
  Future<void> markNotificationRead(String idUnique) async {
    if (idUnique.isEmpty) return;
    await _backend.markNotificationLu(idUnique);
    emit(
      state.copyWith(
        notifications: [
          for (final m in state.notifications)
            if (m['id_unique'] == idUnique) {...m, 'lu': true} else m,
        ],
      ),
    );
  }

  /// « Tout marquer comme lu » : bascule les notifications persistantes non
  /// lues en LUE (une par une, comme le fait l'écran pour les dérivées).
  Future<void> markAllNotificationsRead() async {
    final nonLues =
        state.notifications
            .where((m) => m['lu'] != true)
            .map((m) => m['id_unique']?.toString() ?? '')
            .where((s) => s.isNotEmpty);
    for (final id in nonLues) {
      await _backend.markNotificationLu(id);
    }
    emit(
      state.copyWith(
        notifications: [
          for (final m in state.notifications) {...m, 'lu': true},
        ],
      ),
    );
  }
}
