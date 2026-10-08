import 'dart:typed_data';

/// Stub web : la sauvegarde fichier n'est pas disponible sur le navigateur.
/// Retourne `null` pour signaler que l'export n'a pas eu lieu.
Future<String?> saveQrPng(Uint8List bytes, String fileName) async => null;
