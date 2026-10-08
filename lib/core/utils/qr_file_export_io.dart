import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

/// Canal natif `cuf_recouvrement/media` (MainActivity.kt) : écriture vers le
/// dossier public `Download/CUF` via MediaStore (API 29+) ou écriture
/// directe (API 26-28), avec anti-doublon côté natif.
const MethodChannel mediaChannel = MethodChannel('cuf_recouvrement/media');

/// Enregistre les octets PNG et retourne le chemin **utilisable par
/// l'utilisateur**.
///
/// Stratégie :
///  1. écriture locale dans `documents/CUF_QR` (source de vérité offline,
///     toujours effectuée) ;
///  2. sur Android, copie vers `Download/CUF` via [mediaChannel] — si le
///     canal échoue (émulateur sans plugin, autre plateforme), le chemin
///     local reste un export réel et ouvrable.
Future<String?> saveQrPng(Uint8List bytes, String fileName) =>
    saveQrPngImpl(bytes, fileName, isAndroid: Platform.isAndroid);

/// Variante injectable pour les tests (le canal Android est simulé par un
/// `TestDefaultBinaryMessenger`).
///
/// Section 18/prompt « QR téléchargement réel » : la fonction ne promet un
/// succès que si **un fichier existe réellement** à l'emplacement retourné —
/// la copie locale est vérifiée, et le chemin `Download/CUF` renvoyé par le
/// canal natif est contrôlé avant d'être présenté comme l'export.
@visibleForTesting
Future<String?> saveQrPngImpl(
  Uint8List bytes,
  String fileName, {
  required bool isAndroid,
}) async {
  final dir = await getApplicationDocumentsDirectory();
  final dossier = Directory('${dir.path}/CUF_QR');
  if (!dossier.existsSync()) dossier.createSync(recursive: true);
  final fichier = fichierSansDoublon(dossier, fileName);
  await fichier.writeAsBytes(bytes);
  if (!fichier.existsSync()) {
    debugPrint('[QR] échec d\'écriture local : ${fichier.path}');
    return null;
  }

  if (isAndroid) {
    try {
      final chemin = await mediaChannel.invokeMethod<String>(
        'saveToDownloads',
        <String, dynamic>{
          'path': fichier.path,
          'fileName': fileName,
          'mime': 'image/png',
        },
      );
      // Le chemin public n'est promis que s'il existe réellement : un chemin
      // fantôme (MediaStore incohérent, permission refusée, contenu
      // transitoire) n'est jamais présenté comme un export réussi.
      if (chemin != null && chemin.isNotEmpty) {
        final existant = ServicePath.of(chemin).existsSync();
        if (existant) return chemin;
        debugPrint('[QR] chemin Download/CUF inexistant -> repli local');
      }
    } on PlatformException {
      // Download inaccessible : on conserve l'export local.
    } on MissingPluginException {
      // Canal absent (tests, plateforme hôte) : export local.
    }
  }

  // Copie locale = export réel vérifié.
  return fichier.existsSync() ? fichier.path : null;
}

/// Abstraction légère `File`/path : `File(path).existsSync()` lève si le
/// chemin n'est pas un chemin de système de fichiers (ex. `content://`).
class ServicePath {
  static File of(String path) {
    if (path.startsWith('content://') || path.startsWith('file://')) {
      final uri = Uri.tryParse(path);
      if (uri != null && uri.scheme == 'file') {
        return File(uri.toFilePath());
      }
      // Détection de triomphe : un contenu MediaStore n'est pas vérifiable
      // comme un fichier ; on le considère inexistant pour forcer le repli.
      return File('');
    }
    return File(path);
  }
}

/// Évite d'écraser un export précédent dans le même dossier (suffixe ` (n)`).
@visibleForTesting
File fichierSansDoublon(Directory dossier, String fileName) {
  var cible = File('${dossier.path}/$fileName');
  if (!cible.existsSync()) return cible;
  final dot = fileName.lastIndexOf('.');
  final base = dot > 0 ? fileName.substring(0, dot) : fileName;
  final ext = dot > 0 ? fileName.substring(dot) : '';
  var n = 1;
  while (true) {
    cible = File('${dossier.path}/$base ($n)$ext');
    if (!cible.existsSync()) return cible;
    n++;
  }
}
