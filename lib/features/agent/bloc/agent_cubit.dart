import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/localization/app_localizations.dart';
import '../../../core/service/sync_service.dart';
import '../../../core/utils/formatters.dart';
import '../../../data/local/repositories/encaissement_repo.dart';
import '../../../data/local/repositories/kiosque_repo.dart';
import '../../../data/models/encaissement.dart';
import '../../../data/models/kiosque.dart';
import '../../../data/remote/cuf_backend.dart';
import '../../../data/remote/kiosque_mapper.dart';

class AgentState {
  final bool loading;
  final String? error;
  final Map<String, dynamic>? fiche;
  final List<Map<String, dynamic>> voisins;
  final Kiosque? kiosqueLocal;
  final int pendingSync;
  final bool? encaissementOk;
  final String? quittanceNumero;
  final bool kiosqueInconnu;
  final List<Kiosque> recents;
  final List<Kiosque> redevables;
  final bool loadingRedevables;
  final String? infoMessage;

  // --- Instruction des dossiers (§ 4.4) ---
  final List<Map<String, dynamic>> dossiers;
  final bool loadingDossiers;

  /// Message de succès de la dernière décision (approuver / rejeter /
  /// corrections), effacé par [AgentCubit.clearDecisionMessage].
  final String? decisionMessage;

  /// Échec de la dernière décision — canal séparé de [error] : le tableau de
  /// bord affiche déjà `error` en SnackBar, l'écran de détail afficherait la
  /// même erreur deux fois (et la effacerait aussitôt).
  final String? decisionError;

  const AgentState({
    this.loading = false,
    this.error,
    this.fiche,
    this.voisins = const [],
    this.kiosqueLocal,
    this.pendingSync = 0,
    this.encaissementOk,
    this.quittanceNumero,
    this.kiosqueInconnu = false,
    this.recents = const [],
    this.redevables = const [],
    this.loadingRedevables = false,
    this.infoMessage,
    this.dossiers = const [],
    this.loadingDossiers = false,
    this.decisionMessage,
    this.decisionError,
  });

  /// Nombre de dossiers en attente de décision (badge du tableau de bord).
  int get dossiersAInstruire =>
      dossiers.where((d) => d['statut'] == 'EN_COURS_INSTRUCTION').length;

  /// Copie de l'état.
  ///
  /// `quittanceNumero` et `infoMessage` sont **conservés** par défaut et
  /// effacés explicitement via `clear*`.
  ///
  /// Régression corrigée : les deux étaient recopiés tels quels
  /// (`quittanceNumero: quittanceNumero`), donc remis à `null` à chaque
  /// `copyWith`. Or le constructor abonne `pendingStream` et émet
  /// `copyWith(pendingSync: n)` à chaque variation du compteur de file — ce que
  /// fait précisément `SyncService.flush()` / `enqueue()` après un encaissement
  /// hors-ligne (`unawaited(_sync.flush())`). La emission de succès
  /// (`encaissementOk: true`, `quittanceNumero: …`) était donc effacée dans la
  /// foulée : `encaissement_screen` teste
  /// `encaissementOk == true && quittanceNumero != null` et la quittance
  /// différée ne s'affichait jamais, laissant un « encaissement réussi » sans
  /// numéro de quittance.
  ///
  /// `error` reste réinitialisé quand le paramètre est omis : un message
  /// d'erreur doit disparaître dès qu'une nouvelle opération démarre.
  AgentState copyWith({
    bool? loading,
    String? error,
    Map<String, dynamic>? fiche,
    bool clearFiche = false,
    List<Map<String, dynamic>>? voisins,
    Kiosque? kiosqueLocal,
    int? pendingSync,
    bool? encaissementOk,
    String? quittanceNumero,
    bool clearQuittanceNumero = false,
    bool? kiosqueInconnu,
    List<Kiosque>? recents,
    List<Kiosque>? redevables,
    bool? loadingRedevables,
    String? infoMessage,
    bool clearInfoMessage = false,
    List<Map<String, dynamic>>? dossiers,
    bool? loadingDossiers,
    String? decisionMessage,
    bool clearDecisionMessage = false,
    String? decisionError,
    bool clearDecisionError = false,
  }) {
    return AgentState(
      loading: loading ?? this.loading,
      error: error,
      fiche: clearFiche ? null : (fiche ?? this.fiche),
      voisins: clearFiche ? const [] : (voisins ?? this.voisins),
      kiosqueLocal: clearFiche ? null : (kiosqueLocal ?? this.kiosqueLocal),
      pendingSync: pendingSync ?? this.pendingSync,
      encaissementOk: encaissementOk ?? this.encaissementOk,
      quittanceNumero: clearQuittanceNumero
          ? null
          : (quittanceNumero ?? this.quittanceNumero),
      kiosqueInconnu: kiosqueInconnu ?? this.kiosqueInconnu,
      recents: recents ?? this.recents,
      redevables: redevables ?? this.redevables,
      loadingRedevables: loadingRedevables ?? this.loadingRedevables,
      infoMessage: clearInfoMessage ? null : (infoMessage ?? this.infoMessage),
      dossiers: dossiers ?? this.dossiers,
      loadingDossiers: loadingDossiers ?? this.loadingDossiers,
      decisionMessage: clearDecisionMessage
          ? null
          : (decisionMessage ?? this.decisionMessage),
      decisionError: clearDecisionError
          ? null
          : (decisionError ?? this.decisionError),
    );
  }
}

class AgentCubit extends Cubit<AgentState> {
  final CufBackend _backend;
  final KiosqueRepo _kiosques;
  final EncaissementRepo _encaissements;
  final SyncService _sync;

  /// Abonnement au compteur d'éléments en attente de synchronisation.
  /// Conservé pour être annulé dans [close] : sans cela l'abonnement
  /// survivait à la fermeture du Cubit (déconnexion / changement de rôle) et
  /// le flux restait alimenté par un écran qui n'existe plus.
  StreamSubscription<int>? _pendingSub;

  /// Chargement initial déjà lancé (évite les rechargements inutiles).
  bool _loaded = false;

  AgentCubit(this._backend, this._kiosques, this._encaissements, this._sync)
    : super(const AgentState()) {
    _pendingSub = _sync.pendingStream.listen((n) {
      if (!isClosed) emit(state.copyWith(pendingSync: n));
    });
  }

  /// Chargements initiaux (badges du tableau de bord).
  ///
  /// Appelé explicitement par l'injecteur APRÈS la construction : le
  /// constructeur ne doit jamais déclencher d'E/S. Deux raisons :
  ///  1. une exception dans un constructeur est synchrone et casse le
  ///     `BlocProvider.create` (écran noir) ;
  ///  2. une lecture Isar lancée « à la volée » reste en vol si l'écran est
  ///     détruit aussitôt (déconnexion rapide) — la transaction async ne se
  ///     termine jamais et bloque ensuite `Isar.close()`.
  Future<void> load() async {
    if (_loaded) return;
    _loaded = true;
    await Future.wait([
      _refreshPending(),
      _loadRecents(),
      _loadRedevables(),
      _loadDossiersSilent(),
    ]);
  }

  @override
  Future<void> close() async {
    await _pendingSub?.cancel();
    _pendingSub = null;
    return super.close();
  }

  Future<void> _refreshPending() async {
    final n = await _sync.pendingCount();
    if (!isClosed) emit(state.copyWith(pendingSync: n));
  }

  Future<void> _loadRecents() async {
    try {
      final recents = await _kiosques.recent();
      if (!isClosed) emit(state.copyWith(recents: recents));
    } catch (e) {
      // Non bloquant : comme les autres chargements silencieux, une erreur
      // du cache local ne doit pas se transformer en échec de décision.
      debugPrint('[AgentCubit] liste Recent indisponible : $e');
    }
  }

  /// Chargement silencieux au démarrage (pré-remplit le badge du tableau de
  /// bord sans afficher d'indicateur de progression).
  /// Une erreur ici n'est pas bloquante : l'écran dédié relancera l'opération
  /// et l'agent n'est pas Buryé dans un écran vide au démarrage.
  Future<void> _loadRedevables() async {
    try {
      final lignes = await _backend.getKiosquesRedevables();
      final kiosques = lignes.map(_kiosqueRedevable).toList()
        ..sort((a, b) => b.totalDetteAriary.compareTo(a.totalDetteAriary));
      if (!isClosed) emit(state.copyWith(redevables: kiosques));
    } catch (e) {
      debugPrint(
        '[AgentCubit] liste de travail indisponible au démarrage : $e',
      );
    }
  }

  /// get_kiosques_redevables() — liste de travail recouvrement (section 6) :
  /// kiosques en retard, triés par dette décroissante.
  Future<void> loadRedevables() async {
    emit(state.copyWith(loadingRedevables: true, error: null));
    try {
      final lignes = await _backend.getKiosquesRedevables();
      final kiosques = lignes.map(_kiosqueRedevable).toList()
        ..sort((a, b) => b.totalDetteAriary.compareTo(a.totalDetteAriary));
      if (!isClosed) {
        emit(state.copyWith(loadingRedevables: false, redevables: kiosques));
      }
    } catch (e) {
      debugPrint('[AgentCubit] liste de travail indisponible : $e');
      if (!isClosed) {
        emit(
          state.copyWith(
            loadingRedevables: false,
            error: AppLocalizations.traduire('load_failed'),
          ),
        );
      }
    }
  }

  /// Reconstruit un [Kiosque] léger depuis une ligne du back-end (source de
  /// vérité = serveur) : suffisant pour l'affichage et l'ouverture de la fiche.
  Kiosque _kiosqueRedevable(Map<String, dynamic> m) {
    final code = m['code_kiosque']?.toString() ?? '';
    final k = Kiosque(codeKiosque: code);
    k.proprietaireNom = m['proprietaire_nom']?.toString() ?? '';
    k.proprietaireTelephone = m['proprietaire_telephone']?.toString() ?? '';
    k.fokontany = m['fokontany']?.toString() ?? '';
    k.emplacementRepere = m['emplacement_repere']?.toString() ?? '';
    k.statutDroitInstallation =
        m['statut_droit_installation']?.toString() ?? k.statutDroitInstallation;
    k.statutTaxeMensuelle =
        m['statut_taxe_mensuelle']?.toString() ?? k.statutTaxeMensuelle;
    k.moisRetardCalcules = intOf(m, 'mois_retard_calcules');
    k.totalDetteAriary = intOf(m, 'total_dette_ariary');
    k.gpsLatitude = dblOf(m, 'gps_latitude');
    k.gpsLongitude = dblOf(m, 'gps_longitude');
    return k;
  }

  // --------------------------------------------------------------------------
  // Instruction des dossiers (§ 4.4) : liste + décision de l'agent communal.
  // --------------------------------------------------------------------------

  /// Chargement silencieux au démarrage (pré-remplit le badge
  /// « dossiers à instruire » sans afficher d'indicateur).
  Future<void> _loadDossiersSilent() async {
    try {
      final lignes = await _backend.getDemandesAgent();
      if (!isClosed) emit(state.copyWith(dossiers: lignes));
    } catch (e) {
      debugPrint('[AgentCubit] liste des dossiers indisponible : $e');
    }
  }

  /// get_demandes_agent() — liste d'instruction (tous les dossiers).
  Future<void> loadDossiers() async {
    emit(state.copyWith(loadingDossiers: true, error: null));
    try {
      final lignes = await _backend.getDemandesAgent();
      if (!isClosed) {
        emit(state.copyWith(loadingDossiers: false, dossiers: lignes));
      }
    } catch (e) {
      debugPrint('[AgentCubit] liste des dossiers indisponible : $e');
      if (!isClosed) {
        emit(
          state.copyWith(
            loadingDossiers: false,
            error: AppLocalizations.traduire('load_failed'),
          ),
        );
      }
    }
  }

  /// decider_demande(payload) — approbation / rejet / corrections.
  ///
  /// La décision n'est **pas** mise en file : elle est émise depuis l'espace
  /// agent, où une erreur réseau doit être vue immédiatement (le rejet ou
  /// l'approbation d'un dossier ne se « reporte » pas au retour du réseau).
  /// Rejouer une décision déjà appliquée reste sans effet côté back-end
  /// (idempotence).
  ///
  /// Retourne `true` si la décision a été portée ; la liste est rechargée
  /// pour que l'écran de détail affiche le nouveau statut.
  ///
  /// La liste **Recent** du tableau de bord est également rechargée : un
  /// APPROUVE fait naître la fiche kiosque en base (`decider_demande`), et
  /// [load] ne relit les recents qu'une seule fois à la connexion — sans ce
  /// rechargement, le nouveau kiosque n'apparaîtrait qu'après reconnexion.
  Future<bool> deciderDossier({
    required String codeDossier,
    required String decision,
    required String note,
    required String agentTelephone,
    required String sessionToken,
  }) async {
    emit(
      state.copyWith(
        loading: true,
        clearDecisionMessage: true,
        clearDecisionError: true,
      ),
    );
    try {
      final resultat = await _backend.deciderDemande({
        'code_dossier': codeDossier,
        'decision': decision,
        'note': note,
        'agent_telephone': agentTelephone,
        'session_token': sessionToken,
      });
      await loadDossiers();
      await _loadRecents();
      if (isClosed) return true;
      emit(state.copyWith(loading: false, decisionMessage: resultat.message));
      return true;
    } on ArgumentError catch (e) {
      if (!isClosed) {
        emit(state.copyWith(loading: false, decisionError: e.message));
      }
      return false;
    } catch (e) {
      if (!isClosed) {
        emit(
          state.copyWith(
            loading: false,
            decisionError: 'Décision impossible pour le moment : $e',
          ),
        );
      }
      return false;
    }
  }

  void clearDecisionMessage() => emit(
    state.copyWith(clearDecisionMessage: true, clearDecisionError: true),
  );

  /// get_kiosque_by_qrcode(code) — scan QR (section 6.1/6.2).
  ///
  /// `clearFiche` au chargement : en cas d'échec, l'écran affiche l'état vide +
  /// « Réessayer » au lieu de montrer la fiche du kiosque précédent (staleness).
  Future<void> loadKiosqueByQr(String code) async {
    emit(
      state.copyWith(
        loading: true,
        error: null,
        clearFiche: true,
        kiosqueInconnu: false,
      ),
    );
    try {
      final fiche = await _backend.getKiosqueByQrcode(code);
      if (fiche == null) {
        emit(state.copyWith(loading: false, kiosqueInconnu: true, error: null));
        return;
      }
      final local = await _ficheToLocal(fiche);
      _emitFiche(fiche, local);
    } catch (e) {
      emit(state.copyWith(loading: false, error: '$e'));
    }
  }

  /// get_kiosque_by_id(code) — navigation par rebond (section 6.3).
  Future<void> loadKiosqueById(String code) async {
    emit(
      state.copyWith(
        loading: true,
        error: null,
        clearFiche: true,
        kiosqueInconnu: false,
      ),
    );
    try {
      final fiche = await _backend.getKiosqueById(code);
      if (fiche == null) {
        emit(state.copyWith(loading: false, kiosqueInconnu: true));
        return;
      }
      final local = await _ficheToLocal(fiche);
      _emitFiche(fiche, local);
    } catch (e) {
      emit(state.copyWith(loading: false, error: '$e'));
    }
  }

  Future<void> _emitFiche(Map<String, dynamic> fiche, Kiosque? local) async {
    final voisins = (fiche['kiosques_voisins'] ?? const []) as List;
    emit(
      state.copyWith(
        loading: false,
        fiche: fiche,
        kiosqueLocal: local,
        voisins: voisins.cast<Map<String, dynamic>>(),
        encaissementOk: null,
        clearQuittanceNumero: true,
      ),
    );
    // Le backend vient de rafraîchir `lastSeenAt` du kiosque ouvert : la
    // section « Kiosques récents » du tableau de bord doit en tenir compte
    // immédiatement, sans reconnexion ni retour à l'accueil.
    await _loadRecents();
  }

  Future<Kiosque?> _ficheToLocal(Map<String, dynamic> fiche) async {
    final principal = (fiche['kiosque_principal'] ?? {}) as Map;
    final code = principal['code_kiosque']?.toString() ?? '';
    if (code.isEmpty) return null;
    try {
      var local = await _kiosques.byCode(code.toUpperCase());
      if (local == null) {
        local = Kiosque(codeKiosque: code.toUpperCase());
      }
      local.autorisationNumero =
          principal['autorisation_numero']?.toString() ??
          local.autorisationNumero;
      local.proprietaireNom =
          principal['proprietaire_nom']?.toString() ?? local.proprietaireNom;
      local.proprietaireTelephone =
          principal['proprietaire_telephone']?.toString() ??
          local.proprietaireTelephone;
      local.fokontany = principal['fokontany']?.toString() ?? local.fokontany;
      final sf = Map<String, dynamic>.from(
        (principal['situation_fiscale'] ?? {}) as Map,
      );
      if (sf['statut_droit_installation'] != null) {
        local.statutDroitInstallation = sf['statut_droit_installation']
            .toString();
      }
      if (sf['statut_taxe_mensuelle'] != null) {
        local.statutTaxeMensuelle = sf['statut_taxe_mensuelle'].toString();
      }
      local.moisRetardCalcules = intOf(sf, 'mois_retard_calcules');
      local.totalDetteAriary = intOf(sf, 'total_dette_ariary');
      local.lastSeenAt = DateTime.now();
      local.isSynchronised = true;
      await _kiosques.put(local);
      return local;
    } catch (e, s) {
      // Le cache local n'est qu'un confort : la fiche affichée vient du
      // serveur. On poursuit l'affichage, mais la cause doit rester
      // exploitable pour le diagnostic (§ 18) au lieu d'être avalée en silence.
      debugPrint(
        '[AgentCubit] cache local du kiosque $code indisponible : $e\n$s',
      );
      return null;
    }
  }

  /// register_encaissement(payload) — section 6.4.
  ///
  /// Flux offline-first cohérent (§11) :
  ///  1. transmission immédiate au serveur (détecte les erreurs métier telles
  ///     que « kiosque inconnu » — affichées, jamais différées) ;
  ///  2. hors-ligne → quittance émise LOCALEMENT et opération mise en file
  ///     `sync_offline_queue`, rejouée au retour du réseau (ce flux garantit
  ///     qu'aucun encaissement n'est perdu : critère §13.2) ;
  ///  3. à l'envoi différé, purge de la file déclenchée immédiatement
  ///     (ne pas attendre un changement de connectivité).
  Future<void> encaisser({
    required String codeKiosque,
    required String nomKiosque,
    required String proprietaireNom,
    required int montant,
    required String natureTaxe,
    required String agentTelephone,
    required String sessionToken,
    double gpsLat = 0,
    double gpsLon = 0,
  }) async {
    emit(
      state.copyWith(
        loading: true,
        error: null,
        encaissementOk: null,
        clearQuittanceNumero: true,
        clearInfoMessage: true,
      ),
    );

    final now = DateTime.now();
    final encaissement = Encaissement(
      codeKiosque: codeKiosque,
      nomKiosque: nomKiosque,
      proprietaireNom: proprietaireNom,
      montant: montant,
      natureTaxe: natureTaxe,
      agentTelephone: agentTelephone,
      agentSessionToken: sessionToken,
    );
    encaissement.gpsLatitude = gpsLat;
    encaissement.gpsLongitude = gpsLon;
    encaissement.horodatage = now;

    final payload = {
      'code_kiosque': codeKiosque,
      'montant': montant,
      'nature_taxe': natureTaxe,
      'agent_telephone': agentTelephone,
      'session_token': sessionToken,
      'gps_lat': gpsLat,
      'gps_lon': gpsLon,
      'horodatage': now.toIso8601String(),
    };

    // 1. Transmission immédiate (best effort).
    String numeroQuittance;
    var differe = false;
    try {
      final result = await _backend.registerEncaissement(payload);
      numeroQuittance = result.numeroQuittance;
    } on ArgumentError catch (e) {
      // Erreur métier (kiosque inconnu, montant invalide) : non différée.
      emit(state.copyWith(loading: false, error: e.message));
      return;
    } catch (_) {
      // Serveur injoignable : quittance locale + envoi différé.
      numeroQuittance = Formatters.quittanceLocale(encaissement.id);
      differe = true;
    }

    // 2. Persistance locale : la quittance (serveur ou locale) est conservée.
    encaissement.numeroQuittance = numeroQuittance;
    encaissement.enAttenteSynchro = differe;
    await _encaissements.put(encaissement);

    // 3. Hors-ligne : mise en file + purge immédiate (idempotente — le serveur
    //    déduplique par numéro de quittance, section 11).
    if (differe) {
      final syncPayload = Map<String, dynamic>.from(payload)
        ..['numero_quittance'] = numeroQuittance;
      await _sync.enqueue('register_encaissement', syncPayload);
      unawaited(_sync.flush());
    }

    emit(
      state.copyWith(
        loading: false,
        encaissementOk: true,
        quittanceNumero: numeroQuittance,
        infoMessage: differe
            ? AppLocalizations.traduire('encaissement_offline')
            : null,
      ),
    );
  }

  /// signaler_anomalie(payload) — section 6.5.
  ///
  /// Une référence locale unique est attachée à chaque signalement : au rejeu
  /// de la file `sync_offline_queue`, le serveur la reconnaît et ignore la
  /// réception dupliquée (idempotence, section 11).
  ///
  /// Renvoie `true` si le signalement a été émis (ou mis en file),
  /// `false` en cas d'erreur métier (kiosque inconnu, session invalide) —
  /// l'écran appelant décide alors de rester ouvert pour permettre une
  /// correction au lieu d'effectuer un retour prématuré.
  Future<bool> signalerAnomalie({
    String? codeKiosque,
    required String type,
    required String description,
    required String agentTelephone,
    required String sessionToken,
    double gpsLat = 0,
    double gpsLon = 0,
  }) async {
    emit(state.copyWith(loading: true, error: null));

    final reference = Formatters.referenceLocale('AN');
    final payload = {
      'reference': reference,
      'code_kiosque': codeKiosque ?? '',
      'type_anomalie': type,
      'description': description,
      'agent_telephone': agentTelephone,
      'session_token': sessionToken,
      'gps_lat': gpsLat,
      'gps_lon': gpsLon,
    };

    var differe = false;
    try {
      await _backend.signalerAnomalie(payload);
    } on ArgumentError catch (e) {
      emit(state.copyWith(loading: false, error: e.message));
      return false;
    } catch (_) {
      // Hors-ligne : mise en file + purge immédiate au retour du réseau.
      differe = true;
    }

    if (differe) {
      await _sync.enqueue('signaler_anomalie', payload);
      unawaited(_sync.flush());
    }

    emit(
      state.copyWith(
        loading: false,
        infoMessage: differe
            ? AppLocalizations.traduire('anomaly_reported_offline')
            : AppLocalizations.traduire('anomaly_reported'),
      ),
    );
    return true;
  }

  /// Vide la file de synchronisation puis **recharge les données du
  /// tableau de bord** (file d'attente, kiosques récents, dossiers,
  /// redevables).
  ///
  /// Sans ce rechargement, « Synchroniser » ne faisait qu'envoyer la file :
  /// les badges et la section « Recent » restaient figés sur leurs valeurs
  /// du démarrage.
  Future<void> synchroniser() async {
    final done = await _sync.flush();
    if (done > 0 && !isClosed) {
      emit(
        state.copyWith(
          infoMessage: AppLocalizations.traduire('sync_done', args: [done]),
        ),
      );
    }
    await Future.wait([
      _refreshPending(),
      _loadRecents(),
      _loadDossiersSilent(),
      _loadRedevables(),
    ]);
  }

  void clearTransient() {
    emit(state.copyWith(clearInfoMessage: true, error: null));
  }
}
