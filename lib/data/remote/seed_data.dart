import '../../core/config/app_config.dart';
import '../models/kiosque.dart';

/// Données réelles de terrain (référentiel officiel CUF, septembre 2026).
/// Sert de jeu de démonstration et de recette lors de la soutenance :
/// reflète l'exemple JSON de la section 8.2 du cahier des charges.
class SeedData {
  SeedData._();

  static List<Kiosque> kiosques() {
    late Kiosque k1S008;
    late Kiosque k1S009;
    late Kiosque k1S006;
    late Kiosque k1S010;
    late Kiosque k1S002;
    late Kiosque k1S003;
    late Kiosque k1S011;

    k1S008 = Kiosque(codeKiosque: '1S008')
      ..campagneRecensement = 'Mobile Money CUF2026'
      ..statutFiche = 'Final'
      ..codeReponseServeur = 'lanto90-E34A3U'
      ..dateSoumission = '2026-04-17'
      ..typeIdentification = AppConfig.typeIndividuel
      ..proprietaireNom = 'RAMANANTENASOA MANAMPINIAINA clandreasy'
      ..proprietaireTelephone = '0344670181'
      ..autorisationNumero = '221CUF2025'
      ..autorisationDate = '2025-11-11'
      ..dossierEncoursNumero = '221cuf2025'
      ..dossierEncoursDate = '2025-11-11'
      ..avisPaiementNumero = '2394504D'
      ..avisPaiementDate = '2025-11-11'
      ..kiosqueLongueur = 1.0
      ..kiosqueLargeur = 2.0
      ..emplacementRepere = 'Ankidona akaikiny poissonerie'
      ..gpsLatitude = -21.4673152
      ..gpsLongitude = 47.0667377
      ..fokontany = 'Ankidona'
      ..materiauxConstruction = 'Tôles'
      ..etatGeneral = 'Moyen'
      ..operationsActives = ['MVola', 'Airtel Money', 'Vente crédit']
      ..terrainOccupation = 'Partie du trottoir'
      ..photoUrl = 'https://mwater.co'
      ..observationTerrain =
          'Autorisation 2025 no misy fa @sary ao anaty telephone efa mikarakara ny autorisation 2026'
      ..statutDroitInstallation = 'PAYE'
      ..statutTaxeMensuelle = 'REDEVABLE'
      ..moisRetardCalcules = 4
      ..totalDetteAriary = 80000
      ..taxesAnnuel = ['2025|120000|PAYE|QUIT-20251111120101']
      ..isSynchronised = true;

    k1S009 = Kiosque(codeKiosque: '1S009')
      ..proprietaireNom = 'HANITRINIAINA'
      ..emplacementRepere = 'Akaikiny magasin zandrikely ankidona'
      ..gpsLatitude = -21.4673152 + 0.00005
      ..gpsLongitude = 47.0667377 + 0.00002
      ..fokontany = 'Ankidona'
      ..materiauxConstruction = 'Planches'
      ..operationsActives = ['MVola', 'Orange Money']
      ..terrainOccupation = 'Terrain privé'
      ..statutDroitInstallation = 'PAYE'
      ..statutTaxeMensuelle = 'REDEVABLE'
      ..moisRetardCalcules = 2
      ..totalDetteAriary = 20000
      ..isSynchronised = true;

    k1S006 = Kiosque(codeKiosque: '1S006')
      ..proprietaireNom = 'RAKOTOSOLOFONIAINA Valimbavaka fiononana'
      ..emplacementRepere = 'Ankidona croisement hiakatra ankazobe'
      ..gpsLatitude = -21.4673152 - 0.0001
      ..gpsLongitude = 47.0667377 + 0.00005
      ..fokontany = 'Ankidona'
      ..materiauxConstruction = 'Tôles'
      ..operationsActives = ['MVola']
      ..terrainOccupation = 'Partie du trottoir'
      ..statutDroitInstallation = 'PAYE'
      ..statutTaxeMensuelle = 'A_JOUR'
      ..totalDetteAriary = 0
      ..isSynchronised = true;

    k1S010 = Kiosque(codeKiosque: '1S010')
      ..proprietaireNom = 'RASOLOFOARISON Njaka'
      ..emplacementRepere = 'Ankidona akaikin\'ny fivarotam-bary'
      ..gpsLatitude = -21.4673152 + 0.00012
      ..gpsLongitude = 47.0667377 - 0.00004
      ..fokontany = 'Ankidona'
      ..materiauxConstruction = 'Maison en dur'
      ..operationsActives = ['Airtel Money', 'MVola']
      ..terrainOccupation = 'Terrain privé'
      ..statutDroitInstallation = 'EN_ATTENTE'
      ..statutTaxeMensuelle = 'REDEVABLE'
      ..moisRetardCalcules = 1
      ..totalDetteAriary = 10000
      ..isSynchronised = true;

    k1S002 = Kiosque(codeKiosque: '1S002')
      ..proprietaireNom = 'ANDRIANJATOVO Fara'
      ..emplacementRepere = 'Andrainjato akaikin\'ny tetezana'
      ..gpsLatitude = -21.4542
      ..gpsLongitude = 47.0912
      ..fokontany = 'Andrainjato'
      ..materiauxConstruction = 'Tôles'
      ..operationsActives = ['MVola', 'Orange Money', 'Airtel Money']
      ..terrainOccupation = 'Terrain privé'
      ..statutDroitInstallation = 'PAYE'
      ..statutTaxeMensuelle = 'A_JOUR'
      ..totalDetteAriary = 0
      ..isSynchronised = true;

    k1S003 = Kiosque(codeKiosque: '1S003')
      ..proprietaireNom = 'RATSIMBAZAFY Tovo'
      ..emplacementRepere = 'Ankofafa marché hebdomadaire'
      ..gpsLatitude = -21.4512
      ..gpsLongitude = 47.0824
      ..fokontany = 'Ankofafa'
      ..materiauxConstruction = 'Planches'
      ..operationsActives = ['MVola']
      ..terrainOccupation = 'Partie du trottoir'
      ..statutDroitInstallation = 'PAYE'
      ..statutTaxeMensuelle = 'REDEVABLE'
      ..moisRetardCalcules = 6
      ..totalDetteAriary = 60000
      ..isSynchronised = true;

    k1S011 = Kiosque(codeKiosque: '1S011')
      ..proprietaireNom = 'RAHARISON Solofo'
      ..emplacementRepere = 'Ankazobe sakafo hariva'
      ..gpsLatitude = -21.4605
      ..gpsLongitude = 47.0748
      ..fokontany = 'Ankazobe'
      ..materiauxConstruction = 'Tôles'
      ..operationsActives = ['Airtel Money']
      ..terrainOccupation = 'Partie du trottoir'
      ..statutDroitInstallation = 'EN_ATTENTE'
      ..statutTaxeMensuelle = 'REDEVABLE'
      ..moisRetardCalcules = 3
      ..totalDetteAriary = 30000
      ..isSynchronised = true;

    return [k1S008, k1S009, k1S006, k1S010, k1S002, k1S003, k1S011];
  }

  /// QR Code de référence : la valeur encodée dans le QR est le code kiosque.
  static String qrValue() => '1S008';
}