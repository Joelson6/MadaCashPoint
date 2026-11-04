import 'package:cuf_recouvrement_mobile/core/db/local_store.dart';
import 'package:cuf_recouvrement_mobile/core/db/local_store_web.dart';
import 'package:cuf_recouvrement_mobile/core/network/xml_rpc_codec.dart';
import 'package:cuf_recouvrement_mobile/core/security/secure_store.dart';
import 'package:cuf_recouvrement_mobile/core/service/sync_service.dart';
import 'package:cuf_recouvrement_mobile/data/local/repositories/demande_repo.dart';
import 'package:cuf_recouvrement_mobile/data/local/repositories/sync_queue_repo.dart';
import 'package:cuf_recouvrement_mobile/data/remote/cuf_backend.dart';
import 'package:cuf_recouvrement_mobile/features/citoyen/bloc/demande_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Back-end piloté : chaque test choisit la réponse du serveur.
class _FakeBackend implements CufBackend {
  _FakeBackend({this.allowed = true});

  bool allowed;
  Object? submitError;
  LocationAllowance? allowance;
  Map<String, dynamic>? lastPayload;
  int submitCalls = 0;
  int allowanceCalls = 0;

  @override
  Future<LocationAllowance> checkLocationAllowance(
    double latitude,
    double longitude,
  ) async {
    allowanceCalls++;
    return allowance ??
        LocationAllowance(
          allowed: allowed,
          message: allowed ? 'Zone autorisée' : 'Zone interdite',
        );
  }

  @override
  Future<DemandeResult> submitDemande(Map<String, dynamic> payload) async {
    submitCalls++;
    lastPayload = Map<String, dynamic>.from(payload);
    final e = submitError;
    if (e != null) throw e;
    return DemandeResult(
      codeDossier: 'CUF-2026-000123',
      statut: 'EN_COURS_INSTRUCTION',
      montantDroitInstallation: 250000,
    );
  }

  @override
  dynamic noSuchMethod(Invocation i) =>
      throw UnimplementedError('${i.memberName} non utilisé');
}

void main() {
  late LocalStore store;
  late _FakeBackend backend;
  late DemandeCubit cubit;
  late SyncService sync;

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    await SecureStore.instance.init();
    store = MemoryLocalStore();
    backend = _FakeBackend();
    sync = SyncService(SyncQueueRepo(store), backend);
    cubit = DemandeCubit(backend, DemandeRepo(store), sync);
  });

  tearDown(() => sync.dispose());

  group('DemandeState.copyWith — conservation de l\'état', () {
    test(
      'conserve les coordonnées GPS lors d\'une mise à jour sans rapport',
      () {
        cubit.setGps(-21.1, 47.1);
        expect(cubit.state.gpsLat, -21.1);
        expect(cubit.state.gpsLon, 47.1);

        cubit.setField('nom_prenoms', 'RAKOTO');

        expect(
          cubit.state.gpsLat,
          -21.1,
          reason: 'un champ de formulaire ne doit pas effacer le GPS',
        );
        expect(cubit.state.gpsLon, 47.1);
      },
    );

    test('conserve le résultat de restriction géographique', () {
      cubit.setGps(-21.1, 47.1);
      cubit.setGeoResult(true, 'Zone autorisée');
      expect(cubit.state.geoAllowed, isTrue);

      cubit.setField('fokontany', 'Ambohimanga');

      expect(
        cubit.state.geoAllowed,
        isTrue,
        reason: 'la validation de soumission dépend de cet indicateur',
      );
    });

    test(
      'conserve le numéro de dossier après une soumission réussie',
      () async {
        cubit.setGps(-21.1, 47.1);
        await cubit.checkLocationAllowance();
        await cubit.submit('0341234567');
        expect(cubit.state.codeDossier, 'CUF-2026-000123');

        cubit.setField('fokontany', 'Ambohimanga');
        expect(cubit.state.codeDossier, 'CUF-2026-000123');
      },
    );
  });

  group('§ 12/13 — GPS et restriction géographique', () {
    test('la capture GPS renseigne les coordonnées et le verdict', () async {
      cubit.setGps(-21.1, 47.1);
      await cubit.checkLocationAllowance();

      expect(backend.allowanceCalls, 1);
      expect(cubit.state.gpsCaptured, isTrue);
      expect(cubit.state.geoAllowed, isTrue);
      expect(
        cubit.state.error,
        isNull,
        reason: 'aucune erreur : les coordonnées ne doivent pas être perdues',
      );
    });

    test('refuse de contrôler une position non capturée', () async {
      await cubit.checkLocationAllowance();
      expect(backend.allowanceCalls, 0);
      expect(cubit.state.geoAllowed, isNull);
      expect(cubit.state.error, isNotNull);
    });

    test('un nouveau relevé GPS invalide l\'ancien verdict', () async {
      cubit.setGps(-21.1, 47.1);
      await cubit.checkLocationAllowance();
      expect(cubit.state.geoAllowed, isTrue);

      cubit.setGps(-22.5, 46.0);
      expect(
        cubit.state.geoAllowed,
        isNull,
        reason:
            'un verdict calculé sur d\'autres coordonnées ne vaut plus rien',
      );
    });

    test('signale une zone interdite sans empêcher le diagnostic', () async {
      backend = _FakeBackend(allowed: false);
      cubit = DemandeCubit(backend, DemandeRepo(store), sync);
      cubit.setGps(-21.1, 47.1);
      await cubit.checkLocationAllowance();

      expect(cubit.state.geoAllowed, isFalse);
      expect(cubit.state.geoMessage, 'Zone interdite');
    });
  });

  group('§ 14 — soumission : payload réel', () {
    test('transmet les données réellement saisies', () async {
      cubit.setGps(-21.1, 47.1);
      cubit.setField('nom_prenoms', 'RAKOTO Jean');
      cubit.setField('cin', '123456789');
      cubit.setField('fokontany', 'Ambohimanga');
      cubit.setField('photo_emplacement', 'doc_1.jpg');
      await cubit.checkLocationAllowance();
      await cubit.submit('0341234567');

      expect(backend.submitCalls, 1);
      final p = backend.lastPayload!;
      // Numéro canonique (9 chiffres sans 0 initial) : c'est le format stocké
      // en base, celui que réutilisent get_mes_dossiers / get_mes_paiements.
      expect(p['telephone'], '0341234567');
      expect(p['nom_prenoms'], 'RAKOTO Jean');
      expect(p['cin'], '123456789');
      expect(p['fokontany'], 'Ambohimanga');
      expect(p['photo_emplacement'], 'doc_1.jpg');
      expect(p['gps_latitude'], -21.1);
      expect(p['gps_longitude'], 47.1);
    });

    test('déclare le verdict réel de la restriction géographique', () async {
      cubit.setGps(-21.1, 47.1);
      await cubit.checkLocationAllowance();
      await cubit.submit('0341234567');

      expect(
        backend.lastPayload!['georestriction_resultat'],
        'OK',
        reason: 'le verdict obtenu doit être transmis au serveur',
      );
    });

    test('§ 13 : une zone interdite bloque la soumission (contrainte métier)', () async {
      backend = _FakeBackend(allowed: false);
      cubit = DemandeCubit(backend, DemandeRepo(store), sync);
      cubit.setGps(-21.1, 47.1);
      await cubit.checkLocationAllowance();
      expect(cubit.state.geoAllowed, isFalse);

      await cubit.submit('0341234567');

      expect(
        backend.submitCalls,
        0,
        reason:
            'aucun appel réseau : la contrainte ne doit pas être contournable',
      );
      expect(cubit.state.success, isFalse);
      expect(cubit.state.codeDossier, isNull);
      expect(cubit.state.error, contains('interdite'));
      expect(await DemandeRepo(store).all(), isEmpty);
    });

    test('§ 12 : une soumission sans GPS est refusée', () async {
      await cubit.submit('0341234567');

      expect(backend.submitCalls, 0);
      expect(cubit.state.error, contains('GPS'));
      expect(await DemandeRepo(store).all(), isEmpty);
    });
  });

  group('§ 14/11 — aucune fausse réussite', () {
    test(
      'succès serveur : numéro de dossier réel, aucune mise en file',
      () async {
        cubit.setGps(-21.1, 47.1);
        await cubit.checkLocationAllowance();
        await cubit.submit('0341234567');

        expect(cubit.state.success, isTrue);
        expect(cubit.state.error, isNull);
        expect(cubit.state.codeDossier, 'CUF-2026-000123');
      },
    );

    test('refus métier : erreur affichée, AUCUN dossier local créé', () async {
      backend = _FakeBackend()
        ..submitError = ArgumentError('Dossier incomplet');
      cubit = DemandeCubit(backend, DemandeRepo(store), sync);
      cubit.setGps(-21.1, 47.1);
      await cubit.checkLocationAllowance();
      await cubit.submit('0341234567');

      expect(cubit.state.success, isFalse);
      expect(cubit.state.error, contains('Dossier incomplet'));
      expect(cubit.state.codeDossier, isNull);
      expect(
        await DemandeRepo(store).all(),
        isEmpty,
        reason: 'un refus serveur ne doit jamais devenir un dossier local',
      );
      expect(
        await sync.pendingCount(),
        0,
        reason: 'un refus serveur ne doit pas être rejoué plus tard',
      );
    });

    test(
      'panne réseau : mise en file + mention « en attente d\'envoi »',
      () async {
        backend = _FakeBackend()
          ..submitError = XmlRpcFault(
            XmlRpcFault.codeTransport,
            'réseau injoignable',
          );
        cubit = DemandeCubit(backend, DemandeRepo(store), sync);
        cubit.setGps(-21.1, 47.1);
        await cubit.checkLocationAllowance();
        await cubit.submit('0341234567');

        expect(
          cubit.state.success,
          isTrue,
          reason: 'dossier conservé localement',
        );
        expect(cubit.state.codeDossier, startsWith('OFFLINE-'));
        expect(
          cubit.state.pendingSync,
          greaterThan(0),
          reason: 'l\'écran doit annoncer que l\'envoi est en attente',
        );
        expect(await DemandeRepo(store).all(), hasLength(1));
      },
    );

    test('panne réseau : le brouillon est vidé après mise en file', () async {
      backend = _FakeBackend()
        ..submitError = XmlRpcFault(
          XmlRpcFault.codeTransport,
          'réseau injoignable',
        );
      cubit = DemandeCubit(backend, DemandeRepo(store), sync);
      cubit.setField('nom_prenoms', 'RAKOTO Jean');
      cubit.setGps(-21.1, 47.1);
      await cubit.checkLocationAllowance();
      await cubit.submit('0341234567');

      expect(SecureStore.instance.loadDraftDemande(), isNull);
    });
  });

  group('§ 11 — file de synchronisation', () {
    test('un élément confirmé est purgé, un rejeté reste en attente', () async {
      await sync.enqueue('submit_demande_autorisation', {'a': 1});
      await sync.enqueue('register_encaissement', {'b': 2});
      expect(await sync.pendingCount(), 2);

      // Le serveur confirme le premier et rejette le second.
      final items = await sync.pendingItems();
      final fileBackend = _QueueBackend(rejets: {items[1].id});
      final fileSync = SyncService(SyncQueueRepo(store), fileBackend);
      final purged = await fileSync.flush();
      fileSync.dispose();

      expect(purged, 1);
      expect(
        await sync.pendingCount(),
        1,
        reason: 'le rejeté doit rester en attente pour un nouvel essai',
      );
    });
  });
}

/// Back-end ne servant qu'à la purge de la file : confirme tout sauf [rejets].
class _QueueBackend extends _FakeBackend {
  _QueueBackend({required this.rejets});

  final Set<int> rejets;

  @override
  Future<SyncResult> syncOfflineQueue(List<Map<String, dynamic>> l) async {
    return SyncResult(
      total: l.length,
      success: l.length - rejets.length,
      erreurs: rejets.length,
      echecIds: rejets.toList(),
    );
  }
}
