import 'package:flutter/material.dart';

import '../../data/local/repositories/anomalie_repo.dart';
import '../../data/local/repositories/demande_repo.dart';
import '../../data/local/repositories/encaissement_repo.dart';
import '../../data/local/repositories/kiosque_repo.dart';
import '../../data/local/repositories/sync_queue_repo.dart';
import '../../data/local/repositories/user_repo.dart';
import '../../data/remote/cuf_backend.dart';
import '../../data/remote/embedded_backend.dart';
import '../../data/remote/remote_backend.dart';
import '../../data/remote/seed_data.dart';
import '../config/app_config.dart';
import '../db/store_factory.dart';
import '../security/secure_store.dart';
import '../service/sync_service.dart';

/// Injecteur de dépendances (accès global aux services de l'application).
/// Pattern simple conforme à l'architecture feature-first du CDC.
class ServiceLocator {
  ServiceLocator._();

  static final ServiceLocator instance = ServiceLocator._();
  static bool _initialized = false;

  /// Amorçage en cours. Un appel concurrent (double appui sur « Réessayer »,
  /// reconstruction de l'arbre de widgets) rejoint ce Future au lieu de
  /// rejouer la chaîne — donc au lieu de rouvrir la base.
  static Future<void>? _initializing;

  /// Substitution du magasin local, **réservée aux tests**.
  ///
  /// Isar n'est pas utilisable sous `testWidgets` : `Isar.close()` attend les
  /// transactions asynchrones en cours (`await Future.wait(_activeAsyncTxns)`),
  /// or celles lancées depuis un test de widget restent suspendues dans la
  /// zone `FakeAsync` qui est détruite à la fin du test. La fermeture bloque
  /// alors définitivement et le teardown expire après 12 minutes.
  ///
  /// Les tests de navigation/routage n'ont pas besoin d'une vraie base : leur
  /// intérêt est le routage, pas la persistance. Ils injectent donc un magasin
  /// en mémoire via ce point d'extension. La persistance Isar reste couverte
  /// par `isar_local_store_test.dart` / `isar_open_recovery_test.dart`, qui,
  /// eux, n'utilisent que des `test()` (donc aucune zone `FakeAsync`).
  ///
  /// `null` en production : le magasin est alors créé par [LocalStoreFactory].
  static Future<LocalStore> Function()? storeOverride;

  late final LocalStore store;
  late final SecureStore secureStore;
  late final UserRepo userRepo;
  late final KiosqueRepo kiosqueRepo;
  late final DemandeRepo demandeRepo;
  late final EncaissementRepo encaissementRepo;
  late final SyncQueueRepo syncQueueRepo;
  late final AnomalieRepo anomalieRepo;
  late final CufBackend backend;
  late final SyncService syncService;
  late final ValueNotifier<Locale> localeController;

  bool get isInitialized => _initialized;

  /// Initialisation globale : base Isar, stockage sécurisé, back-end,
  /// données de terrain et service de synchronisation.
  ///
  /// Idempotente et sûre en concurrence :
  ///  - si l'amorçage a réussi, c'est un no-op ;
  ///  - si l'amorçage est en cours, l'appelant attend le même Future ;
  ///  - en cas d'échec, le verrou est libéré pour permettre un rejeu, tandis
  ///    que la base Isar, elle, reste ouverte et sera réutilisée.
  Future<void> init() {
    if (_initialized) return Future<void>.value();
    return _initializing ??= _bootstrap().whenComplete(() {
      _initializing = null;
    });
  }

  Future<void> _bootstrap() async {
    debugPrint('[BOOT] ServiceLocator : amorçage');
    try {
      store = await (storeOverride?.call() ?? LocalStoreFactory.create());
      debugPrint('[DB] store local prêt (${store.runtimeType})');
      await store.init();

      secureStore = SecureStore.instance;
      await secureStore.init();

      localeController = ValueNotifier<Locale>(
        Locale(secureStore.getLanguage() ?? 'fr'),
      );

      userRepo = UserRepo(store);
      kiosqueRepo = KiosqueRepo(store);
      demandeRepo = DemandeRepo(store);
      encaissementRepo = EncaissementRepo(store);
      syncQueueRepo = SyncQueueRepo(store);
      anomalieRepo = AnomalieRepo(store);

      // Choix du back-end : embarqué (autonome) ou XML-RPC distant (site web CUF).
      if (AppConfig.useEmbeddedBackend) {
        final embedded = EmbeddedBackend(store, secureStore);
        await embedded.provisionAgentCompte();
        await embedded.provisionCitoyenDemo();
        backend = embedded;
      } else {
        backend = RemoteXmlRpcBackend();
      }

      syncService = SyncService(syncQueueRepo, backend);

      await _seedKiosques();

      _initialized = true;
      debugPrint('[BOOT] ServiceLocator : amorçage terminé');
    } catch (e, s) {
      // L'amorçage reste rejouable : la base Isar reste ouverte et sera
      // réutilisée par IsarLocalStore.openInstance().
      debugPrint('[BOOT] ServiceLocator : ÉCHEC de l\'amorçage -> $e\n$s');
      rethrow;
    }
  }

  Future<void> _seedKiosques() async {
    // Remplit le cache local uniquement s'il est vide (référentiel terrain).
    final count = await kiosqueRepo.count();
    if (count == 0) {
      await kiosqueRepo.putAll(SeedData.kiosques());
    }
  }
}
