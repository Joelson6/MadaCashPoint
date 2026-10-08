import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

import '../localization/app_localizations.dart';

/// L'image n'a pas pu être ramenée sous la limite de 300 Ko imposée par le
/// cahier des charges (section 5.2).
///
/// Lever une exception — plutôt que renvoyer `null` — permet à l'appelant de
/// distinguer un abandon volontaire de l'utilisateur (valeur `null`) d'un
/// échec technique : le champ doit rester vide dans les deux cas, mais
/// l'utilisateur doit être informé dans le second.
class DocumentTooLargeException implements Exception {
  const DocumentTooLargeException();

  @override
  String toString() =>
      'Document trop volumineux : impossible de passer sous 300 Ko';
}

/// Service de capture de documents avec compression < 300 Ko (section 5.2).
/// Sur web (navigateur), la compression locale n'est pas disponible :
/// l'image est transmise sous forme d'URL blob du picker.
class DocumentCaptureService {
  DocumentCaptureService._();

  static final instance = DocumentCaptureService._();
  static final _picker = ImagePicker();

  /// Plafond de taille d'une pièce jointe (section 5.2) : 300 Ko.
  static const int limiteOctets = 300 * 1024;

  /// Capture via caméra, prévisualisation avec gabarit, compressée < 300 Ko.
  /// Retourne le chemin local (natif) ou l'URL blob (web).
  ///
  /// [source] permet d'importer un document déjà saisi (galerie) : mêmes
  /// règles de prévisualisation et de compression qu'une photo prise.
  ///
  /// Renvoie `null` si l'utilisateur abandonne. Lève
  /// [DocumentTooLargeException] si l'image ne peut pas être ramenée sous
  /// [limiteOctets] : dans ce cas AUCUN chemin n'est renvoyé, pour qu'un
  /// fichier inexistant ou trop lourd ne puisse jamais être joint au dossier.
  static Future<String?> capture(
    BuildContext context, {
    required String title,
    required String overlayLabel,
    String? overlayHint,
    ImageSource source = ImageSource.camera,
  }) async {
    final photo = await _picker.pickImage(
      source: source,
      preferredCameraDevice: CameraDevice.rear,
      imageQuality: 92,
      maxWidth: 1920,
      maxHeight: 1920,
    );
    if (photo == null) return null;

    // Mode navigateur : pas de systèmes de fichiers ni de compression locale.
    if (kIsWeb) {
      return photo.path;
    }

    // La caméra et la prévisualisation sont asynchrones : l'écran a pu être
    // quitté entre-temps. Pousser une route sur un `BuildContext` démonté
    // lève une exception.
    if (!context.mounted) return null;

    // Prévisualisation avec validation de l'utilisateur.
    final ok = await Navigator.of(context).push<bool>(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (_) => _DocumentPreview(
          filePath: photo.path,
          title: title,
          overlayLabel: overlayLabel,
          overlayHint: overlayHint,
        ),
      ),
    );
    if (ok != true) return null;

    // Compression < 300 Ko.
    return _compressUnder300Ko(photo.path);
  }

  /// Ramène l'image sous [limiteOctets] en descendant la qualité par paliers.
  ///
  /// Chaque tentative écrit son propre fichier : un résultat trop lourd est
  /// supprimé avant de réessayer, pour ne pas laisser d'images orphelines.
  ///
  /// Lève [DocumentTooLargeException] si aucun palier ne convient. Ne renvoie
  /// JAMAIS un chemin non vérifié : une version antérieure retournait
  /// `outPath` en cas d'échec — un chemin qui pouvait ne correspondre à aucun
  /// fichier, ou à une image encore supérieure à la limite. La pièce jointe
  /// aurait alors été déclarée valide alors qu'elle était inexistante ou hors
  /// gabarit.
  static Future<String> _compressUnder300Ko(String inputPath) async {
    final dir = await getApplicationDocumentsDirectory();
    for (var quality = 85; quality >= 10; quality -= 10) {
      final outPath =
          '${dir.path}/doc_${DateTime.now().microsecondsSinceEpoch}'
          '_q$quality.jpg';
      final result = await FlutterImageCompress.compressAndGetFile(
        inputPath,
        outPath,
        quality: quality,
        format: CompressFormat.jpeg,
        minWidth: 1600,
        minHeight: 1600,
      );
      if (result == null) continue;
      final size = await result.length();
      if (size <= limiteOctets) return result.path;
      _supprimer(result.path);
    }
    throw const DocumentTooLargeException();
  }

  /// Suppression d'un fichier intermédiaire, sans masquer un échec.
  static void _supprimer(String path) {
    try {
      final f = File(path);
      if (f.existsSync()) f.deleteSync();
    } catch (e) {
      debugPrint('[DocumentCapture] fichier intermédiaire non supprimé : $e');
    }
  }
}

class _DocumentPreview extends StatelessWidget {
  final String filePath;
  final String title;
  final String overlayLabel;
  final String? overlayHint;

  const _DocumentPreview({
    required this.filePath,
    required this.title,
    required this.overlayLabel,
    this.overlayHint,
  });

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        title: Text(title),
        actions: [
          TextButton.icon(
            onPressed: () => Navigator.pop(context, false),
            icon: const Icon(Icons.close),
            label: Text(l.t('retake'), style: const TextStyle(color: Colors.white)),
          ),
          TextButton.icon(
            onPressed: () => Navigator.pop(context, true),
            icon: const Icon(Icons.check),
            label: Text(
              l.t('validate'),
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          kIsWeb
              ? Image.network(filePath, fit: BoxFit.contain)
              : Image.file(File(filePath), fit: BoxFit.contain),
          // Gabarit en surimpression ciblant la zone du document.
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black54,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    overlayLabel,
                    style: const TextStyle(color: Colors.white70, fontSize: 13),
                  ),
                ),
                const SizedBox(height: 8),
                // Zones cibles du gabarit (recto : zone photo ; verso : zone signatures).
                CustomPaint(size: Size(260, 170), painter: _GabaritPainter()),
                if (overlayHint != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(color: Colors.black54),
                      child: Text(
                        overlayHint!,
                        style: const TextStyle(
                          color: Colors.white54,
                          fontSize: 11,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _GabaritPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..color = Colors.amber
      ..strokeWidth = 2;
    canvas.drawRect(
      Rect.fromLTWH(10, 10, size.width - 20, size.height - 20),
      paint,
    );
    canvas.drawLine(
      Offset(size.width / 2, 10),
      Offset(size.width / 2, size.height - 10),
      paint,
    );
    canvas.drawLine(
      Offset(10, size.height / 2),
      Offset(size.width - 10, size.height / 2),
      paint,
    );
  }

  @override
  bool shouldRepaint(_GabaritPainter oldDelegate) => false;
}
