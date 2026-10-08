import 'dart:io';
import 'dart:typed_data';

import 'package:cuf_recouvrement_mobile/core/utils/qr_file_export_io.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';

/// Fake du provider de dossier applicatif (aucun plugin natif en test).
class _FakePathProvider extends PathProviderPlatform {
  final String root;
  _FakePathProvider(this.root);

  @override
  Future<String> getApplicationDocumentsPath() async =>
      '$root/documents';

  @override
  Future<String> getTemporaryPath() async => '$root/tmp';
}

/// Section « QR téléchargement réel » : l'export n'est validé que si un
/// fichier **existe réellement** au chemin retourné. Un chemin public
/// fantôme (Download mediaStore incohérent) retombe sur la copie locale
/// vérifiée plutôt que d'afficher un faux succès.
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late Directory racine;

  final bytes = Uint8List.fromList(List<int>.filled(8, 42));

  setUp(() async {
    racine = await Directory.systemTemp.createTemp('qr_export_test_');
    PathProviderPlatform.instance = _FakePathProvider(racine.path);
  });

  tearDown(() async {
    if (await racine.exists()) await racine.delete(recursive: true);
  });

  test('sans Android : export local réel (le fichier existe)', () async {
    final chemin = await saveQrPngImpl(bytes, 'QR_KIOSQUE_1S008.png',
        isAndroid: false);

    expect(chemin, isNotNull);
    expect(File(chemin!).existsSync(), isTrue,
        reason: 'le chemin promis doit pointer vers un vrai fichier');
    expect(chemin, endsWith('QR_KIOSQUE_1S008.png'));
  });

  test('Android renvoyant un chemin fantôme : repli sur la copie locale',
      () async {
    const fantome = '/storage/emulated/0/Download/CUF/QR_INEIXISTANT.png';
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(
      mediaChannel,
      (call) async => fantome,
    );

    final chemin = await saveQrPngImpl(bytes, 'QR_KIOSQUE_2D001.png',
        isAndroid: true);

    expect(chemin, isNotNull);
    expect(chemin, isNot(fantome));
    expect(File(chemin!).existsSync(), isTrue,
        reason: 'le repli doit être un vrai fichier existant');
  });

  test('Android renvoyant un chemin existant : celui-ci est présenté', () async {
    final ok = File('${racine.path}/Download/QR_OK.png')
      ..createSync(recursive: true);
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(
      mediaChannel,
      (call) async => ok.path,
    );

    final chemin =
        await saveQrPngImpl(bytes, 'QR_KIOSQUE_2D001.png', isAndroid: true);

    expect(chemin, ok.path);
    expect(File(chemin!).existsSync(), isTrue);
  });

  test('fichierSansDoublon ne réécrase jamais un export existant', () {
    final dossier = Directory('${racine.path}/CUF_QR')..createSync();
    final a = fichierSansDoublon(dossier, 'QR.png');
    a.writeAsBytesSync(bytes);

    final b = fichierSansDoublon(dossier, 'QR.png');
    expect(b.path, isNot(a.path));
    expect(b.path, endsWith('QR (1).png'));
    expect(b.existsSync(), isFalse);
  });
}