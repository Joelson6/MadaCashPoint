import '../../core/config/app_config.dart';
import '../../core/utils/validators.dart';
import '../models/demande.dart';
import 'kiosque_mapper.dart';

/// Préfixe des numéros de dossier attribués **localement** pendant une panne.
/// Le serveur le remplace par un numéro officiel `CUF{année}-{5 chiffres}`
/// lors de la reprise de la file de synchronisation.
const String codeDossierOfflinePrefix = 'OFFLINE-';

/// Vrai si [code] est un numéro provisoire encore jamais confirmé.
bool estCodeOffline(String code) => code.startsWith(codeDossierOfflinePrefix);

/// Conversion payload ➜ [Demande] — **source unique de vérité**.
///
/// Utilisée par le back-end embarqué (soumission serveur) **et** par
/// `DemandeCubit` en mode hors-ligne. Auparavant, le Citoyen écrivait un
/// dossier local quasi vide (nom, CIN, fokontany, nom commercial) alors que
/// le back-end en écrivait un complet : un dossier créé pendant une panne
/// apparaissait dans le suivi sans dimensions, sans GPS, sans repères ni
/// pièces jointes.
///
/// Le mapping est donc dupliqué volontairement **nulle part** : tout appelant
/// passe par cette fonction.
Demande demandeDepuisPayload(
  Map<String, dynamic> payload, {
  required String telephone,
  required String codeDossier,
}) {
  // Format canonique (9 chiffres sans 0 initial) : la lecture cloisonnée
  // interroge la base avec un numéro normalisé — un dossier stocké « brut »
  // (avec espaces ou 0 initial) serait invisible dans le suivi.
  final tel = PhoneValidator.normalize(telephone) ?? telephone;
  final d = Demande(telephone: tel, codeDossier: codeDossier);

  // --- Étape 1 : identité ---
  d.nomPrenoms = str(payload, 'nom_prenoms');
  d.cin = str(payload, 'cin');
  d.cinDate = str(payload, 'cin_date');
  d.cinLieu = str(payload, 'cin_lieu');
  d.quartier = str(payload, 'quartier');
  d.fokontany = str(payload, 'fokontany');

  // --- Étape 2 : spécificités commerciales ---
  d.nomCommercial = str(payload, 'nom_commercial');
  d.operateurs = _stringList(payload['operateurs']);
  d.typeIdentification = str(payload, 'type_identification');
  d.kiosqueLongueur = dblOf(payload, 'kiosque_longueur');
  d.kiosqueLargeur = dblOf(payload, 'kiosque_largeur');
  d.materiauxConstruction = str(payload, 'materiaux_construction');

  // --- Étape 3 : implantation ---
  d.emplacementRepere = str(payload, 'emplacement_repere');
  d.gpsLatitude = dblOf(payload, 'gps_latitude');
  d.gpsLongitude = dblOf(payload, 'gps_longitude');
  d.georestrictionResultat = str(payload, 'georestriction_resultat').isEmpty
      ? 'OK'
      : str(payload, 'georestriction_resultat');

  // --- Pièces jointes (chemins locaux compressés) ---
  d.photoCinRectoPath = str(payload, 'photo_cin_recto');
  d.photoCinVersoPath = str(payload, 'photo_cin_verso');
  d.photoEmplacementPath = str(payload, 'photo_emplacement');

  // --- Grille tarifaire ---
  final montant = intOf(payload, 'montant_droit_installation');
  d.montantDroitInstallation = montant > 0
      ? montant
      : AppConfig.droitInstallationAriary;

  d.soumiseLocalement = true;
  d.dateSoumission = DateTime.now();
  return d;
}

List<String> _stringList(Object? v) {
  if (v is List) return v.map((e) => '$e').toList();
  if (v is String) {
    return v
        .split(RegExp(r'[,;]'))
        .map((e) => e.trim())
        .where((e) => e.isNotEmpty)
        .toList();
  }
  return [];
}
