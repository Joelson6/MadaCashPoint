import 'package:isar/isar.dart';

part 'encaissement.g.dart';

/// Encaissement d'une taxe sur le terrain par l'agent communal.
/// Traçabilité : montant + horodatage + session_token + GPS (section 6.4).
@collection
class Encaissement {
  Id id = Isar.autoIncrement;

  late String codeKiosque;
  late String nomKiosque;
  late String proprietaireNom;

  /// Montant perçu en Ariary (peut être partiel).
  late int montant;

  /// Nature : 'INSTALLATION' | 'RENOUVELLEMENT'
  late String natureTaxe;

  // --- Traçabilité ---
  late String agentTelephone;
  late String agentSessionToken;
  double gpsLatitude = 0;
  double gpsLongitude = 0;
  DateTime horodatage = DateTime.now();

  /// Numéro de quittance généré (ex. "QUIT-2026-000123").
  String numeroQuittance = '';

  // --- Synchronisation ---
  bool enAttenteSynchro = true;
  DateTime? synchroniseAt;

  Encaissement({
    required this.codeKiosque,
    required this.nomKiosque,
    required this.proprietaireNom,
    required this.montant,
    required this.natureTaxe,
    required this.agentTelephone,
    required this.agentSessionToken,
  });
}