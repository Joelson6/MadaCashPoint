import 'dart:ffi';
import 'dart:io';

import 'package:cuf_recouvrement_mobile/core/db/local_store_io.dart';
import 'package:cuf_recouvrement_mobile/data/models/kiosque.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:isar/isar.dart';
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';

class _TempPathProvider extends PathProviderPlatform {
  _TempPathProvider(this.path);

  final String path;

  @override
  Future<String?> getApplicationDocumentsPath() async => path;
}

/// Reproduit le scénario exact du téléphone : une ouverture qui échoue APRÈS
/// l'enregistrement de l'instance par le constructeur `Isar`.
///
/// Dans `isar-3.1.0+1/lib/src/native/open.dart`, `IsarImpl(...)` (qui
/// s'enregistre dans `Isar._instances`) est construit AVANT
/// `_initializeInstance(...)`. Un identifiant de collection invalide fait donc
/// échouer l'ouverture tout en laissant l'instance fantôme enregistrée : le
/// rejeu butait sur `IsarError: Instance has already been opened.`.
///
/// `IsarLocalStore.openInstance()` doit détecter cette instance inexploitable,
/// la libérer, puis rouvrir proprement.
void main() {
  late Directory tempDir;
  late CollectionSchema<Kiosque> badSchema;

  setUpAll(() async {
    if (Platform.isWindows) {
      final dll = File('packages/isar_flutter_libs/windows/isar.dll')
          .absolute
          .path;
      await Isar.initializeIsarCore(libraries: {Abi.windowsX64: dll});
    }

    tempDir = Directory.systemTemp.createTempSync('cuf_isar_ghost');

    // Copie du schéma Kiosque avec un identifiant de collection invalide :
    // c'est ce qui faisait échouer l'ouverture sur l'appareil.
    badSchema = CollectionSchema(
      name: KiosqueSchema.name,
      id: 100002,
      // ignore: invalid_use_of_protected_member
      estimateSize: KiosqueSchema.estimateSize,
      // ignore: invalid_use_of_protected_member
      serialize: KiosqueSchema.serialize,
      // ignore: invalid_use_of_protected_member
      deserialize: KiosqueSchema.deserialize,
      // ignore: invalid_use_of_protected_member
      deserializeProp: KiosqueSchema.deserializeProp,
      idName: KiosqueSchema.idName,
      getId: KiosqueSchema.getId,
      getLinks: KiosqueSchema.getLinks,
      links: KiosqueSchema.links,
      embeddedSchemas: KiosqueSchema.embeddedSchemas,
      indexes: KiosqueSchema.indexes,
      attach: KiosqueSchema.attach,
      version: Isar.version,
      properties: KiosqueSchema.properties,
    );
  });

  tearDownAll(() {
    try {
      tempDir.deleteSync(recursive: true);
    } catch (_) {
      // sans conséquence
    }
  });

  test(
    'récupère une instance fantôme laissée par une ouverture échouée',
    () async {
      PathProviderPlatform.instance = _TempPathProvider(tempDir.path);

      expect(Isar.getInstance(IsarLocalStore.instanceName), isNull);

      // 1. Ouverture volontairement cassée -> l'instance reste enregistrée.
      await expectLater(
        Isar.open(
          [badSchema],
          directory: tempDir.path,
          name: IsarLocalStore.instanceName,
        ),
        throwsA(
          predicate(
            (e) =>
                e is IsarError &&
                e.message.contains('Collection id is invalid'),
            'erreur d\'ouverture attendue : Collection id is invalid',
          ),
        ),
      );
      expect(
        Isar.getInstance(IsarLocalStore.instanceName),
        isNotNull,
        reason: 'l\'instance fantôme doit être présente (cause de l\'erreur observée)',
      );

      // 2. Rejeu de l'amorçage : ne doit PAS lever
      //    « Instance has already been opened. » mais s'auto-réparer.
      final reopened = await IsarLocalStore.openInstance();
      expect(reopened.isOpen, isTrue);
      expect(Isar.getInstance(IsarLocalStore.instanceName), same(reopened));

      // 3. La base est réellement fonctionnelle.
      expect(reopened.collection<Kiosque>(), isNotNull);
      await reopened.writeTxn(
        () => reopened.kiosques.put(Kiosque(codeKiosque: 'OK')),
      );
      expect(await reopened.kiosques.count(), 1);

      await reopened.close(deleteFromDisk: true);
    },
  );

  test('échec d\'ouverture rejouable : le verrou en vol est libéré', () async {
    PathProviderPlatform.instance = _TempPathProvider(tempDir.path);

    // Simule un répertoire inutilisable : l'ouverture échoue.
    final blocker = File('${tempDir.path}${Platform.pathSeparator}bloc')
      ..writeAsStringSync('x');
    PathProviderPlatform.instance = _TempPathProvider(blocker.path);

    await expectLater(IsarLocalStore.openInstance(), throwsA(isA<IsarError>()));

    // Directory corrigée : le rejeu doit fonctionner.
    PathProviderPlatform.instance = _TempPathProvider(tempDir.path);
    final isar = await IsarLocalStore.openInstance();
    expect(isar.isOpen, isTrue);
    await isar.close(deleteFromDisk: true);
    blocker.deleteSync();
  });
}
