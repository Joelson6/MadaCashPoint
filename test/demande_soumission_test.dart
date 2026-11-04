import 'dart:convert';

import 'package:cuf_recouvrement_mobile/core/db/local_store.dart';
import 'package:cuf_recouvrement_mobile/core/db/local_store_web.dart';
import 'package:cuf_recouvrement_mobile/core/network/xml_rpc_codec.dart';
import 'package:cuf_recouvrement_mobile/core/security/secure_store.dart';
import 'package:cuf_recouvrement_mobile/core/service/sync_service.dart';
import 'package:cuf_recouvrement_mobile/data/local/repositories/demande_repo.dart';
import 'package:cuf_recouvrement_mobile/data/local/repositories/sync_queue_repo.dart';
import 'package:cuf_recouvrement_mobile/data/remote/cuf_backend.dart';
import 'package:cuf_recouvrement_mobile/data/remote/embedded_backend.dart';
import 'package:cuf_recouvrement_mobile/features/citoyen/bloc/demande_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Serveur simulé : le back-end embarqué sert de « vrai » serveur pour la
/// reprise de la file de synchronisation.
class _Serveur implements CufBackend {
  Object? submitError;
  int submitCalls = 0;

  /// Dossiers renvoyés par `get_mes_dossiers` (permet de simuler une base
  /// ayant conservé d'anciens doublons).
  List<Map<String, dynamic>>? dossiers;

  @override
  Future<List<Map<String, dynamic>>> getMesDossiers(String telephone) async =>
      dossiers ?? <Map<String, dynamic>>[];

  @override
  Future<LocationAllowance> checkLocationAllowance(
    double latitude,
    double longitude,
  ) async => LocationAllowance(allowed: true, message: 'Zone autorisée');

  @override
  Future<DemandeResult> submitDemande(Map<String, dynamic> payload) async {
    submitCalls++;
    final e = submitError;
    if (e != null) throw e;
    return DemandeResult(
      codeDossier: 'CUF-2026-000123',
      statut: 'EN_COURS_INSTRUCTION',
      montantDroitInstallation: 150000,
    );
  }

  @override
  dynamic noSuchMethod(Invocation i) =>
      throw UnimplementedError('${i.memberName} non utilisé');
}

/// Régression de la partie demandeur — trois pannes observées :
///  1. une soumission réussie créait jusqu'à trois dossiers ;
///  2. le dossier hors-ligne était quasi vide et rejoué sans `code_dossier`,
///     ce qui régénérait un numéro différent à chaque purge ;
///  3. un numéro déjà normalisé était renvoyé « à l'envers » et le dossier
///     devenait invisible dans le suivi et dans « Mes paiements ».
void main() {
  late LocalStore store;
  late _Serveur serveur;
  late EmbeddedBackend embarque;
  late SyncService sync;
  late DemandeCubit cubit;

  /// Prépare un cubit autorisé à soumettre (GPS + verdict de zone).
  Future<void> pretASoumettre() async {
    cubit.setGps(-21.1, 47.1);
    await cubit.checkLocationAllowance();
    expect(cubit.state.geoAllowed, isTrue);
  }

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    await SecureStore.instance.init();
    store = MemoryLocalStore();
    serveur = _Serveur();
    embarque = EmbeddedBackend(store, SecureStore.instance);
    sync = SyncService(SyncQueueRepo(store), serveur);
    cubit = DemandeCubit(serveur, DemandeRepo(store), sync);
  });

  tearDown(() => sync.dispose());

  Future<void> simulerPanne() async {
    serveur.submitError = XmlRpcFault(
      XmlRpcFault.codeTransport,
      'réseau injoignable',
    );
  }

  group('succès serveur — un seul dossier, rien en file', () {
    test('ne réécrit pas localement un dossier déjà persisté', () async {
      await pretASoumettre();
      await cubit.submit('0341234567');

      expect(cubit.state.success, isTrue);
      expect(cubit.state.codeDossier, 'CUF-2026-000123');
      expect(
        await DemandeRepo(store).all(),
        isEmpty,
        reason: 'le back-end est autoritaire : pas de seconde écriture',
      );
      expect(
        await sync.pendingCount(),
        0,
        reason: 'un dossier confirmé ne doit jamais être rejoué',
      );
      expect(
        SecureStore.instance.loadDraftDemande(),
        isNull,
        reason: 'le brouillon est consumé par une soumission réussie',
      );
    });

    test('double appel superposé → une seule soumission', () async {
      await pretASoumettre();
      await Future.wait([
        cubit.submit('0341234567'),
        cubit.submit('0341234567'),
      ]);

      expect(
        serveur.submitCalls,
        1,
        reason: 'un double appui ne doit pas créer deux dossiers',
      );
      expect(cubit.state.success, isTrue);
    });
  });

  group('panne réseau puis reprise de la file', () {
    test('le payload mis en file porte son code_dossier provisoire', () async {
      await simulerPanne();
      await pretASoumettre();
      await cubit.submit('0341234567');

      expect(cubit.state.codeDossier, startsWith('OFFLINE-'));
      final items = await sync.pendingItems();
      expect(items, hasLength(1));
      expect(
        items.single.payloadJson,
        contains('code_dossier'),
        reason: 'sans cette clé, la purge régénère un second dossier',
      );
    });

    test('le dossier hors-ligne contient TOUS les champs saisis', () async {
      await simulerPanne();
      await pretASoumettre();
      cubit
        ..setField('nom_prenoms', 'RAKOTO Jean')
        ..setField('emplacement_repere', 'Akaikin\'ny tetezana Antanifotsy')
        ..setField('kiosque_longueur', 1.5);
      await cubit.submit('0341234567');

      final enregistre = await DemandeRepo(store).all();
      expect(enregistre, hasLength(1));
      final d = enregistre.single;
      expect(d.nomPrenoms, 'RAKOTO Jean');
      expect(d.emplacementRepere, 'Akaikin\'ny tetezana Antanifotsy');
      expect(d.kiosqueLongueur, 1.5);
      expect(d.gpsLatitude, closeTo(-21.1, 0.001));
      expect(d.montantDroitInstallation, greaterThan(0));
    });

    test('reprise → UN seul dossier, promu au statut officiel', () async {
      await simulerPanne();
      await pretASoumettre();
      await cubit.submit('0341234567');

      serveur.submitError = null; // réseau revenu
      final purge = SyncService(SyncQueueRepo(store), embarque);
      final transmis = await purge.flush();
      purge.dispose();

      expect(transmis, 1);
      final dossiers = await DemandeRepo(store).all();
      expect(
        dossiers,
        hasLength(1),
        reason: 'le replay doit PROMOUVOIR le dossier, pas en créer un autre',
      );
      final d = dossiers.single;
      expect(
        d.codeDossier,
        startsWith('CUF'),
        reason: 'le numéro provisoire OFFLINE- est remplacé',
      );
      expect(d.synchronise, isTrue);
    });

    test('rejouer la même ligne après promotion ne duplique pas', () async {
      await simulerPanne();
      await pretASoumettre();
      await cubit.submit('0341234567');

      final items = await sync.pendingItems();
      final payload = Map<String, dynamic>.from(
        jsonDecode(items.single.payloadJson),
      );

      // 1re purge : promotion du dossier.
      await embarque.submitDemande(payload);
      // 2e purge (appareil tué avant le marquage « fait ») : rien à refaire.
      await embarque.submitDemande(payload);

      final dossiers = await DemandeRepo(store).all();
      expect(dossiers, hasLength(1));
    });

    test('rejouer un dossier à numéro officiel est neutre', () async {
      await embarque.submitDemande({
        'telephone': '340000002',
        'nom_prenoms': 'RASOLO Jean',
      });
      final numero = (await DemandeRepo(store).all()).single.codeDossier;

      await embarque.submitDemande({
        'telephone': '340000002',
        'nom_prenoms': 'RASOLO Jean',
        'code_dossier': numero,
      });

      final dossiers = await DemandeRepo(store).all();
      expect(dossiers, hasLength(1));
      expect(dossiers.single.codeDossier, numero);
    });
  });

  group('lecture cloisonnée — le dossier est retrouvé', () {
    test(
      'numéro saisi « brut » (034…) → visible sous forme normalisée',
      () async {
        await embarque.submitDemande({
          'telephone': '034 00 000 02',
          'nom_prenoms': 'RASOANANDRASANA Claire',
          'cin': '108 012 345 678',
        });

        final enregistre = await DemandeRepo(store).all();
        expect(
          enregistre.single.telephone,
          '0340000002',
          reason: 'le téléphone est normalisé à l\'écriture',
        );

        final dossiers = await embarque.getMesDossiers('0340000002');
        expect(
          dossiers,
          hasLength(1),
          reason:
              'normalize() doit être idempotente sur un numéro déjà canonique',
        );
        expect(dossiers.single['code_dossier'], enregistre.single.codeDossier);
      },
    );

    test('le suivi affiche le dossier hors-ligne une seule fois', () async {
      await simulerPanne();
      await pretASoumettre();
      await cubit.submit('0341234567');
      final numero = cubit.state.codeDossier!;

      final cubitEmb = DemandeCubit(embarque, DemandeRepo(store), sync);
      await cubitEmb.loadDossiers('341234567');

      expect(cubitEmb.state.dossiers.map((d) => d['code_dossier']).toList(), [
        numero,
      ]);
      await cubitEmb.close();
    });

    test(
      'le suivi reste lisible quand la source renvoie d\'anciens doublons',
      () async {
        // Une base antérieure au correctif peut renvoyer deux lignes de même
        // numéro : elles ne doivent apparaître qu'une fois.
        serveur.dossiers = [
          {'code_dossier': 'CUF2026-22222', 'statut': 'EN_COURS_INSTRUCTION'},
          {'code_dossier': 'CUF2026-22222', 'statut': 'EN_COURS_INSTRUCTION'},
          {'code_dossier': 'CUF2026-22189', 'statut': 'APPROUVE'},
        ];

        await cubit.loadDossiers('0341234567');

        expect(
          cubit.state.dossiers,
          hasLength(2),
          reason: 'la lecture déduplique par numéro de dossier',
        );
      },
    );
  });
}
