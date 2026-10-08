import 'dart:ffi';
import 'dart:io';

import 'package:cuf_recouvrement_mobile/core/db/local_store_io.dart';
import 'package:cuf_recouvrement_mobile/core/db/store_factory.dart';
import 'package:cuf_recouvrement_mobile/data/local/repositories/kiosque_repo.dart';
import 'package:cuf_recouvrement_mobile/data/local/repositories/user_repo.dart';
import 'package:cuf_recouvrement_mobile/data/models/kiosque.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:isar/isar.dart';
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';

/// Régression : `IsarError: Instance has already been opened.`
///
/// Chaîne d'origine observée sur l'appareil :
///   1. les schémas générés portaient des identifiants de collection
///      synthétiques (100001…100006) au lieu de hachages XXH3 64 bits ;
///   2. `Isar.open()` échouait donc à chaque lancement avec
///      `IsarError: IllegalArg: Collection id is invalid..` ;
///   3. mais l'instance avait DÉJÀ été enregistrée par le constructeur `Isar`
///      (avant l'attachement des collections) ;
///   4. le rejeu de l'amorçage (« Réessayer ») butait alors sur
///      `Isar._checkOpen` -> « Instance has already been opened. ».
///
/// Ces tests couvrent les deux volets : validité réelle des schémas, puis
/// caractère idempotent / concurrent de l'ouverture.
class _TempPathProvider extends PathProviderPlatform {
  _TempPathProvider(this.path);

  final String path;

  @override
  Future<String?> getApplicationDocumentsPath() async => path;
}

void main() {
  late Directory tempDir;
  late Isar isar;

  setUpAll(() async {
    // Bibliothèque native Isar 3.1.0+1 (fournie par isar_flutter_libs).
    if (Platform.isWindows) {
      final dll = File('packages/isar_flutter_libs/windows/isar.dll')
          .absolute
          .path;
      await Isar.initializeIsarCore(libraries: {Abi.windowsX64: dll});
    }

    tempDir = Directory.systemTemp.createTempSync('cuf_isar_test');
    PathProviderPlatform.instance = _TempPathProvider(tempDir.path);

    isar = await IsarLocalStore.openInstance();
  });

  tearDownAll(() async {
    if (isar.isOpen) {
      await isar.close(deleteFromDisk: true);
    }
    try {
      tempDir.deleteSync(recursive: true);
    } catch (_) {
      // le fichier peut rester verrouillé par le core natif : sans conséquence
    }
  });

  group('Schémas Isar (§ 11 — persistance locale)', () {
    test(
      'les 7 collections de l\'application sont déclarées une fois chacune',
      () {
        expect(IsarLocalStore.schemas, hasLength(7));
        expect(IsarLocalStore.schemas.map((s) => s.name).toSet(), {
          'Anomalie',
          'AppUser',
          'Kiosque',
          'Demande',
          'Encaissement',
          'SyncQueueItem',
          'NotificationItem',
        });
      },
    );

    test('les identifiants de collection sont distincts', () {
      final ids = IsarLocalStore.schemas.map((s) => s.id).toSet();
      expect(ids, hasLength(IsarLocalStore.schemas.length));
    });

    test(
      'la base s\'ouvre et fonctionne réellement (lecture/écriture)',
      () async {
        // Avant correction : IsarError: IllegalArg: Collection id is invalid..
        expect(isar.isOpen, isTrue);
        expect(isar.name, IsarLocalStore.instanceName);

        final store = await IsarLocalStore.open();
        await store.putKiosque(Kiosque(codeKiosque: 'TEST-001'));
        expect(await store.kiosqueByCode('TEST-001'), isNotNull);
        expect(await store.kiosqueCount(), 1);
        await store.removeKiosque('TEST-001');
        expect(await store.kiosqueCount(), 0);
      },
    );
  });

  group('Ouverture unique de l\'instance (IsarLocalStore.openInstance)', () {
    test(
      'deuxième appel : réutilise l\'instance, aucune double ouverture',
      () async {
        final a = await IsarLocalStore.openInstance();
        final b = await IsarLocalStore.openInstance();
        expect(a, same(b));
        expect(a, same(isar));
      },
    );

    test('appels simultanés (Future.wait) : une seule ouverture', () async {
      final results = await Future.wait([
        IsarLocalStore.openInstance(),
        IsarLocalStore.openInstance(),
        IsarLocalStore.openInstance(),
        IsarLocalStore.openInstance(),
        IsarLocalStore.openInstance(),
      ]);
      for (final r in results) {
        expect(r, same(isar));
      }
    });

    test(
      'LocalStoreFactory.create() répété : même base sous-jacente',
      () async {
        final s1 = await LocalStoreFactory.create();
        final s2 = await LocalStoreFactory.create();
        // Un repository écrit via s1 est visible via s2 : une seule base.
        final r1 = KiosqueRepo(s1);
        final r2 = KiosqueRepo(s2);
        await r1.put(Kiosque(codeKiosque: 'TEST-002'));
        expect(await r2.byCode('TEST-002'), isNotNull);
        await r2.remove('TEST-002');
      },
    );

    test('accès concurrent multi-repositories sur la base partagée', () async {
      final store = await IsarLocalStore.open();
      final kiosques = KiosqueRepo(store);
      final users = UserRepo(store);

      await Future.wait([
        for (var i = 0; i < 20; i++) kiosques.put(Kiosque(codeKiosque: 'C-$i')),
        for (var i = 0; i < 20; i++) kiosques.recent(limit: 5),
        for (var i = 0; i < 20; i++) users.all(),
      ]);

      expect(await kiosques.count(), 20);
      await Future.wait([
        for (final k in await kiosques.all()) kiosques.remove(k.codeKiosque),
      ]);
      expect(await kiosques.count(), 0);
    });
  });

  group('Réutilisation via le registre Isar', () {
    test(
      'Isar.getInstance retrouve l\'instance ouverte par l\'application',
      () {
        expect(Isar.getInstance(IsarLocalStore.instanceName), same(isar));
      },
    );
  });
}
