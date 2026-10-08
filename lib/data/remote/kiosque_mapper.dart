import 'dart:math';

import '../../data/models/kiosque.dart';

/// Couleurs du statut fiscal utilisées lors du mapping (section 8.3 du CDC).
enum StatutFiscalCouleur { vert, orange, rouge }

StatutFiscalCouleur couleurFiscaleKiosque(Kiosque k) {
  // VERT: en règle | ORANGE: approuvé, droit d'installation en attente
  // ROUGE: redevable / en retard
  if (k.statutDroitInstallation == 'EN_ATTENTE') {
    return StatutFiscalCouleur.orange;
  }
  if (k.statutTaxeMensuelle == 'REDEVABLE') {
    return StatutFiscalCouleur.rouge;
  }
  return StatutFiscalCouleur.vert;
}

/// Distance Haversine en mètres entre deux coordonnées GPS.
double distanceMetres(double lat1, double lon1, double lat2, double lon2) {
  const r = 6371000.0;
  final dLat = _rad(lat2 - lat1);
  final dLon = _rad(lon2 - lon1);
  final a =
      sin(dLat / 2) * sin(dLat / 2) +
      cos(_rad(lat1)) * cos(_rad(lat2)) * sin(dLon / 2) * sin(dLon / 2);
  final c = 2 * atan2(sqrt(a), sqrt(1 - a));
  return r * c;
}

double _rad(double deg) => deg * pi / 180;

/// Mapping Kiosque (base locale) vers la fiche JSON d'échange
/// (section 8.2 du CDC) : kiosque_principal + kiosques_voisins.
Map<String, dynamic> kiosqueVersFiche(Kiosque k, {List<Kiosque>? voisins}) {
  return {
    'kiosque_principal': {
      'campagne_recensement': k.campagneRecensement,
      'statut_fiche': k.statutFiche,
      'code_reponse_serveur': k.codeReponseServeur,
      'date_soumission': k.dateSoumission,
      'code_kiosque': k.codeKiosque,
      'type_identification': k.typeIdentification,
      'proprietaire_nom': k.proprietaireNom,
      'proprietaire_telephone': k.proprietaireTelephone,
      'autorisation_numero': k.autorisationNumero,
      'autorisation_date': k.autorisationDate,
      'dossier_encours_numero': k.dossierEncoursNumero,
      'dossier_encours_date': k.dossierEncoursDate,
      'avis_paiement_numero': k.avisPaiementNumero,
      'avis_paiement_date': k.avisPaiementDate,
      'quittance_numero': k.quittanceNumero,
      'quittance_date': k.quittanceDate,
      'kiosque_longueur': k.kiosqueLongueur,
      'kiosque_largeur': k.kiosqueLargeur,
      'emplacement_repere': k.emplacementRepere,
      'gps_latitude': k.gpsLatitude,
      'gps_longitude': k.gpsLongitude,
      'fokontany': k.fokontany,
      'materiaux_construction': k.materiauxConstruction,
      'etat_general': k.etatGeneral,
      'operations_actives': k.operationsActives,
      'terrain_occupation': k.terrainOccupation,
      'photo_url': k.photoUrl,
      'observation_terrain': k.observationTerrain,
      'photo_local_path': k.photoLocalPath ?? '',
      'situation_fiscale': {
        'statut_droit_installation': k.statutDroitInstallation,
        'statut_taxe_mensuelle': k.statutTaxeMensuelle,
        'mois_retard_calcules': k.moisRetardCalcules,
        'total_dette_ariary': k.totalDetteAriary,
      },
      'historique_taxes': k.taxesAnnuel,
    },
    'kiosques_voisins': (voisins ?? [])
        .map(
          (v) => {
            'code_kiosque': v.codeKiosque,
            'proprietaire_nom': v.proprietaireNom,
            'emplacement_repere': v.emplacementRepere,
            'nom_kiosque': v.codeKiosque,
            'distance_estimee_metres': v.codeKiosque == k.codeKiosque
                ? 0.0
                : distanceMetres(
                    k.gpsLatitude,
                    k.gpsLongitude,
                    v.gpsLatitude,
                    v.gpsLongitude,
                  ),
            'couleur_statut_fiscal': couleurFiscaleKiosque(v).name,
            'montant_dette_ariary': v.totalDetteAriary,
          },
        )
        .toList(),
  };
}

/// Extraction simple d'un sous-champ de la fiche JSON.
String str(Map<String, dynamic> map, String key) {
  final v = map[key];
  return v == null ? '' : '$v';
}

int intOf(Map<String, dynamic> map, String key) {
  final v = map[key];
  if (v is num) return v.toInt();
  return int.tryParse('$v') ?? 0;
}

double dblOf(Map<String, dynamic> map, String key) {
  final v = map[key];
  if (v is num) return v.toDouble();
  return double.tryParse('$v') ?? 0;
}
