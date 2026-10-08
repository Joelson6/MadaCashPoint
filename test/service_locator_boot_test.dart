import 'dart:ffi';
import 'dart:io';

import 'package:cuf_recouvrement_mobile/core/db/local_store_io.dart';
import 'package:cuf_recouvrement_mobile/core/di/service_locator.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:isar/isar.dart';
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';
import 'package:shared_preferences/shared_preferences.dart';

class _TempPathProvider extends PathProviderPlatform {
  _TempPathProvider(this.path);

  final String path;

  @override
  Future<String?> getApplicationDocumentsPath() async => path;
}

/// Démarrage complet de l'application (amorçage réel du ServiceLocator).
///
/// Régression : `IsarError: Instance has already been opened.`
/// Le rejeu de l'amorçage (bouton « Réessayer » / double appui) ne doit pas
/// rouvrir la base, et l'amorçage doit rester idempotent.
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late Directory tempDir;

  setUpAll(() async {
    if (Platform.isWindows) {
      final dll = File('packages/isar_flutter_libs/windows/isar.dll')
          .absolute
          .path;
      await Isar.initializeIsarCore(libraries: {Abi.windowsX64: dll});
    }
    tempDir = Directory.systemTemp.createTempSync('cuf_boot_test');
    PathProviderPlatform.instance = _TempPathProvider(tempDir.path);
    SharedPreferences.setMockInitialValues({});
  });

  tearDownAll(() async {
    final isar = Isar.getInstance(IsarLocalStore.instanceName);
    if (isar != null && isar.isOpen) {
      await isar.close(deleteFromDisk: true);
    }
    try {
      tempDir.deleteSync(recursive: true);
    } catch (_) {
      // sans conséquence
    }
  });

  test(
    'amorçage complet : base, stockage, dépôts et référentiel terrain',
    () async {
      await ServiceLocator.instance.init();

      final sl = ServiceLocator.instance;
      expect(sl.isInitialized, isTrue, reason: 'l\'amorçage doit aboutir');
      expect(sl.store, isA<IsarLocalStore>());
      expect(sl.userRepo, isNotNull);
      expect(sl.kiosqueRepo, isNotNull);
      expect(sl.demandeRepo, isNotNull);
      expect(sl.encaissementRepo, isNotNull);
      expect(sl.syncQueueRepo, isNotNull);
      expect(sl.anomalieRepo, isNotNull);
      expect(sl.backend, isNotNull);
      expect(sl.syncService, isNotNull);
      expect(sl.localeController, isNotNull);

      // Le référentiel terrain a été seedé.
      expect(await sl.kiosqueRepo.count(), greaterThan(0));
    },
  );

  test('appels concurrents à init() : une seule initialisation', () async {
    // Déjà initialisé par le test précédent : vérifie le court-circuit.
    final before = ServiceLocator.instance.kiosqueRepo;
    await Future.wait([
      ServiceLocator.instance.init(),
      ServiceLocator.instance.init(),
      ServiceLocator.instance.init(),
      ServiceLocator.instance.init(),
    ]);
    expect(ServiceLocator.instance.isInitialized, isTrue);
    expect(ServiceLocator.instance.kiosqueRepo, same(before));
  });

  test('une seule instance Isar enregistrée après tout le démarrage', () {
    final isar = Isar.getInstance(IsarLocalStore.instanceName);
    expect(isar, isNotNull);
    expect(isar!.isOpen, isTrue);
  });
}
