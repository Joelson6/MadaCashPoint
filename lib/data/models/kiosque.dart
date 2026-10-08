import 'package:isar/isar.dart';

part 'kiosque.g.dart';

/// Fiche d'identité technique et financière d'un kiosque Mobile Money.
/// Représente la structure JSON de l'exemple en section 8.2 du CDC
/// (kiosque_principal + situation_fiscale + voisins).
@collection
class Kiosque {
  Id id = Isar.autoIncrement;

  /// Code de référence du kiosque scanné via QR Code (ex. "1S008").
  @Index(unique: true, replace: true)
  late String codeKiosque;

  String campagneRecensement = 'Mobile Money CUF2026';
  String statutFiche = 'Final';
  String codeReponseServeur = '';
  String dateSoumission = '';

  String typeIdentification = '';
  String proprietaireNom = '';
  String proprietaireTelephone = '';

  String autorisationNumero = '';
  String autorisationDate = '';
  String dossierEncoursNumero = '';
  String dossierEncoursDate = '';
  String avisPaiementNumero = '';
  String avisPaiementDate = '';
  String quittanceNumero = '';
  String quittanceDate = '';

  double kiosqueLongueur = 0;
  double kiosqueLargeur = 0;

  String emplacementRepere = '';
  double gpsLatitude = 0;
  double gpsLongitude = 0;

  String fokontany = '';

  /// Matériaux : Planches | Tôles | Maison en dur.
  String materiauxConstruction = '';
  String etatGeneral = '';

  /// Opérateurs exploités : MVola, Airtel Money, Orange Money, Vente crédit...
  List<String> operationsActives = [];

  /// Nature de l'occupation (partie du trottoir, terrain privé, marché).
  String terrainOccupation = '';

  String photoUrl = '';
  String observationTerrain = '';

  // --- Situation fiscale (source de vérité = serveur) ---
  String statutDroitInstallation = 'EN_ATTENTE'; // PAYE | EN_ATTENTE
  String statutTaxeMensuelle = 'REDEVABLE'; // A_JOUR | REDEVABLE
  int moisRetardCalcules = 0;
  int totalDetteAriary = 0;

  DateTime? lastSeenAt;
  bool isSynchronised = false;

  /// Historique des taxes annuelles : lignes "2025|120000|PAYE".
  List<String> taxesAnnuel = [];

  /// Voisins connus du cache (JSON encodés ligne par ligne).
  List<String> voisins = [];

  String? photoLocalPath;

  Kiosque({required this.codeKiosque});
}