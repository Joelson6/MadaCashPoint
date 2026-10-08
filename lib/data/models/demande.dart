import 'package:isar/isar.dart';

part 'demande.g.dart';

/// Dossier citoyen de demande d'autorisation d'implantation.
/// Formulaire séquentiel en 3 étapes (section 5 du CDC).
@collection
class Demande {
  Id id = Isar.autoIncrement;

  /// Lien vers le téléphone du demandeur.
  late String telephone;

  /// Numéro de dossier renvoyé par le serveur (ex. "221cuf2025").
  late String codeDossier;

  // --- Étape 1 : Identité ---
  String nomPrenoms = '';
  String cin = '';
  String cinDate = '';
  String cinLieu = '';
  String quartier = '';
  String fokontany = '';

  // --- Étape 2 : Spécificités commerciales ---
  String nomCommercial = '';
  List<String> operateurs = [];
  String typeIdentification = ''; // Individuel | Franchise
  double kiosqueLongueur = 0;
  double kiosqueLargeur = 0;
  String materiauxConstruction = '';

  // --- Étape 3 : Implantation géographique ---
  String emplacementRepere = '';
  double gpsLatitude = 0;
  double gpsLongitude = 0;
  String georestrictionResultat = ''; // OK | BLOQUE

  // --- Pièces jointes (chemins locaux compressés < 300 Ko) ---
  String photoCinRectoPath = '';
  String photoCinVersoPath = '';
  String photoEmplacementPath = '';

  // --- Suivi ---
  String statut = 'EN_COURS_INSTRUCTION'; // EN_COURS_INSTRUCTION | APPROUVE | REJETE
  String noteRejet = '';

  /// Montant du Droit d'Installation (150 000 Ar) — grille officielle.
  int montantDroitInstallation = 150000;
  String statutDroitInstallation = 'EN_ATTENTE';

  bool soumiseLocalement = false; // stockée offline en attendant la synchro
  bool synchronise = false;

  DateTime dateCreation = DateTime.now();
  DateTime? dateSoumission;

  Demande({required this.telephone, required this.codeDossier});
}