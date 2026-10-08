/// Configuration globale de l'application.
/// Conforme au cahier des charges CUF Mobile Money (septembre 2026).
class AppConfig {
  AppConfig._();

  static const String appName = 'CUF Recouvrement Mobile Money';
  static const String appVersion = '1.0.0';

  /// URL du serveur XML-RPC du site web centralisé de la CUF.
  /// Remplacer par l'endpoint de production (ex: https://www.commune-fianar.mg/xmlrpc/2/common).
  static const String serverUrl = 'http://10.0.2.2:8069/xmlrpc/2/common';

  /// Si true, le mobile exécute un back-end embarqué local (base Isar)
  /// qui joue le rôle du serveur XML-RPC : application 100 % autonome sur
  /// le téléphone (utile pour la soutenance / zones sans réseau).
  /// Si false, l'application dialogue avec le site web réel via XML-RPC.
  static const bool useEmbeddedBackend = true;

  // --- Grille tarifaire officielle (section 7.1 du CDC) ---
  static const int droitInstallationAriary = 150000;
  static const int renouvellementAnnuelAriary = 120000;

  // --- Sécurité (section 4.3 / 10) ---
  static const Duration autoLockDelay = Duration(minutes: 5);

  // --- Restrictions ---
  static const int maxImageKo = 300;
  static const double neighbourRadiusMeters = 50;

  // --- Opérateurs Mobile Money supportés (annexe 17.2) ---
  static const List<String> operateurs = [
    'MVola',
    'Orange Money',
    'Airtel Money',
  ];

  // --- Fokontany officiels (annexe 17.1) ---
  static const List<String> fokontanyOfficiels = [
    'Andrainjato',
    'Ambatolahikosoa',
    'Ankofafa',
    'Ankazobe',
    'Ankidona',
  ];

  // --- Matériaux de construction ---
  static const List<String> materiauxConstructions = [
    'Planches',
    'Tôles',
    'Maison en dur',
  ];

  // --- Types d'identification (section 5.1 étape 2) ---
  static const String typeIndividuel =
      'Individuel (kioska an\'ny olona iray miasa irery)';
  static const String typeFranchise =
      'Franchise (kioska miasa amin\'ny anaran\'ny orinasa iray)';
}
