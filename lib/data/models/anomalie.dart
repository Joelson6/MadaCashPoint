import 'package:isar/isar.dart';

part 'anomalie.g.dart';

/// Signalement d'anomalie par l'agent communal (section 6.5 du CDC) :
/// kiosque non déclaré / non-conformité physique / déplacement GPS.
@collection
class Anomalie {
  Id id = Isar.autoIncrement;

  String reference = '';

  /// Code kiosque concerné, vide si kiosque non déclaré.
  String codeKiosque = '';

  /// type : NON_DECLARE | NON_CONFORMITE | DEPLACEMENT
  late String typeAnomalie;

  String description = '';

  double gpsLatitude = 0;
  double gpsLongitude = 0;

  // --- Traçabilité agent ---
  late String agentTelephone;
  late String agentSessionToken;

  DateTime dateSignalement = DateTime.now();
  String statut = 'EN_ATTENTE';
  bool enAttenteSynchro = true;

  Anomalie({
    required this.typeAnomalie,
    required this.agentTelephone,
    required this.agentSessionToken,
  });
}