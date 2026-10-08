import 'package:mobile_scanner/mobile_scanner.dart';

/// Statut de la lecture d'un QR code à partir d'une image de galerie.
enum QrImportStatut {
  /// Exactement un QR code lisible : la valeur peut être traitée.
  ok,

  /// L'image a été analysée mais ne contient aucun QR code.
  aucunQr,

  /// L'image contient plusieurs QR distincts : impossible de trancher.
  plusieursQr,

  /// L'analyse a échoué (image illisible, erreur du détecteur).
  erreurLecture,
}

/// Résultat déterministe d'une analyse d'image, isolée du widget scanner
/// pour pouvoir être testée sans caméra (§ 10 : tests unitaires de la logique).
class QrImportResult {
  const QrImportResult(this.statut, {this.valeur = ''});

  final QrImportStatut statut;

  /// Valeur du QR unique lu (uniquement lorsque [statut] vaut
  /// [QrImportStatut.ok]).
  final String valeur;

  bool get estTraitable => statut == QrImportStatut.ok;
}

/// Interprète le résultat de `MobileScannerController.analyzeImage`.
///
/// Règles :
///  * aucun QR → [QrImportStatut.aucunQr] (message explicite, jamais de
///    blocage silencieux) ;
///  * plusieurs QR **identiques** → traité comme un succès unique (un
///    imprimé dédoublonné reste exploitable) ;
///  * plusieurs QR **distincts** → [QrImportStatut.plusieursQr] : on ne
///    devine pas lequel décrit le kiosque ;
///  * capture nulle / vide / erreur → [QrImportStatut.erreurLecture].
QrImportResult interpreterCapture(BarcodeCapture? capture) {
  if (capture == null) return const QrImportResult(QrImportStatut.erreurLecture);

  final valeurs = <String>{};
  for (final barcode in capture.barcodes) {
    final v = barcode.rawValue?.trim() ?? '';
    if (v.isNotEmpty) valeurs.add(v);
  }

  if (valeurs.isEmpty) return const QrImportResult(QrImportStatut.aucunQr);
  if (valeurs.length > 1) return const QrImportResult(QrImportStatut.plusieursQr);
  return QrImportResult(QrImportStatut.ok, valeur: valeurs.first);
}
