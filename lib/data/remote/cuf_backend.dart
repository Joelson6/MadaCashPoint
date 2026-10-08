/// Contrat de service du back-end CUF.
/// Deux implémentations : [EmbeddedBackend] (sur le téléphone, base Isar)
/// et [RemoteXmlRpcBackend] (site web CUF via XML-RPC, section 8 du CDC).
abstract class CufBackend {
  /// Connexion universelle : user_login(phone_number, pin_code).
  Future<SessionInfo> userLogin(String telephone, String pin);

  /// Émission du code OTP SMS (création de compte citoyen).
  /// Retourne le code affiché en mode démo (back-end embarqué).
  Future<String> requestOtp(String telephone);

  /// Vérification OTP + création du compte demandeur.
  Future<SessionInfo> verifyOtpAndRegister(Map<String, dynamic> payload);

  /// check_location_allowance(latitude, longitude) : moteur de restriction géo.
  Future<LocationAllowance> checkLocationAllowance(
    double latitude,
    double longitude,
  );

  /// submit_demande_autorisation(payload) : soumission dossier citoyen.
  Future<DemandeResult> submitDemande(Map<String, dynamic> payload);

  /// get_kiosque_by_qrcode(code) : fiche kiosque + voisinage (scan).
  Future<Map<String, dynamic>?> getKiosqueByQrcode(String code);

  /// get_kiosque_by_id(code) : navigation par rebond dans le voisinage.
  Future<Map<String, dynamic>?> getKiosqueById(String code);

  /// register_encaissement(payload) : paiement terrain + quittance.
  Future<EncaissementResult> registerEncaissement(Map<String, dynamic> payload);

  /// sync_offline_queue(payload_list) : synchronisation différée.
  Future<SyncResult> syncOfflineQueue(List<Map<String, dynamic>> payloadList);

  /// Historique des dossiers d'un demandeur (accès cloisonné).
  Future<List<Map<String, dynamic>>> getMesDossiers(String telephone);

  /// Historique des paiements propres au demandeur (section 4.2 : cloisonnement
  /// strict — le citoyen ne voit QUE ses paiements).
  /// Retourne des lignes {type, code_dossier, nom_commercial, montant,
  /// montant_paye, montant_du, statut, annee, echeance, date_paiement,
  /// numero_quittance}.
  Future<List<Map<String, dynamic>>> getMesPaiements(String telephone);

  /// Liste des zones interdites à l'implantation (section 5.3), pour affichage
  /// cartographique : {label, latitude, longitude, rayon_metres}.
  Future<List<Map<String, dynamic>>> getZonesInterdites();

  /// Grille tarifaire officielle (section 7.1).
  Future<List<Map<String, dynamic>>> getGrilleTarifaire();

  /// signaler_anomalie(payload) : kiosque non déclaré / non conformité / déplacement.
  Future<ResultatAnomalie> signalerAnomalie(Map<String, dynamic> payload);

  /// Notifications persistantes destinées au demandeur concerné (section 6.5 :
  /// une anomalie signalée sur son kiosque devient une notification durable,
  /// pas un simple message volatil). Lignes : {id_unique, type, code_kiosque,
  /// type_anomalie, message_agent, reference_anomalie, date, lu, important}.
  /// Triées de la plus récente à la plus ancienne.
  Future<List<Map<String, dynamic>>> getNotifications(String telephone);

  /// Marque une notification lue (état conservé après redémarrage).
  Future<void> markNotificationLu(String idUnique);

  /// Récupération des voisins d'un kiosque (rayon 50 m / même côté de rue).
  Future<List<Map<String, dynamic>>> getKiosquesVoisins(String code);

  /// Liste de travail de l'agent : kiosques en retard de paiement ou au droit
  /// d'installation impayé, triés par dette décroissante (section 6 — outil de
  /// recouvrement terrain). Lignes : {code_kiosque, proprietaire_nom,
  /// proprietaire_telephone, emplacement_repere, fokontany,
  /// statut_droit_installation, statut_taxe_mensuelle, mois_retard_calcules,
  /// total_dette_ariary, gps_latitude, gps_longitude}.
  Future<List<Map<String, dynamic>>> getKiosquesRedevables();

  /// get_demandes_agent() : liste d'instruction de l'agent communal
  /// (section 4.4 — l'agent consulte et statue sur TOUT dossier, contrairement
  /// au demandeur cloisonné à son propre numéro, section 4.2).
  /// Lignes : {code_dossier, statut, note_rejet, telephone, nom_prenoms, cin,
  /// quartier, fokontany, nom_commercial, type_identification, operateurs,
  /// materiaux_construction, kiosque_longueur, kiosque_largeur,
  /// emplacement_repere, gps_latitude, gps_longitude, georestriction_resultat,
  /// pieces_jointes, date_soumission, montant_droit_installation,
  /// statut_droit_installation, code_kiosque, autorisation_numero}.
  Future<List<Map<String, dynamic>>> getDemandesAgent();

  /// decider_demande(payload) : décision de l'agent sur un dossier.
  /// payload : {code_dossier, decision, note, agent_telephone, session_token}
  ///  - `decision` = APPROUVE | REJETE | EN_COURS_INSTRUCTION (corrections) ;
  ///  - `note` (motif/consigne) obligatoire pour REJETE et
  ///    EN_COURS_INSTRUCTION, interdite (ignorée) pour APPROUVE ;
  ///  - l'approbation crée la fiche kiosque liée au dossier : elle rend le
  ///    kiosque scannable et permet l'encaissement du droit d'installation
  ///    (section 7.2) — sans elle, aucune suite n'est possible.
  /// Idempotence : rejouer la même décision (file de synchro) ne réécrit rien.
  Future<DemandeDecision> deciderDemande(Map<String, dynamic> payload);
}

/// Rôles normalisés de l'application (section 4.1 du CDC).
///
/// Le site web CUF et le back-end embarqué n'utilisent pas forcément la même
/// écriture pour le rôle (`agent`, `agent_communal`, `AGENT_COMMUNAL`,
/// `Agent Communal`…). Comparer la chaîne renvoyée telle quelle provoca un
/// **routage RBAC silencieux** : l'agent était connecté mais l'application
/// basculait sur l'espace citoyen (symptôme « l'app reste bloquée »).
abstract final class Roles {
  static const agent = 'agent_communal';
  static const demandeur = 'demandeur';

  /// Ramène une valeur serveur à l'un des deux rôles canoniques.
  static String normalize(String? role) {
    final r = (role ?? '').trim().toLowerCase().replaceAll(
      RegExp(r'[\s_\-]+'),
      '',
    );
    if (r.isEmpty) return demandeur;
    // Toute écriture contenant « agent » (ou « controleur » / « enqueteur »,
    // synonymes du cahier des charges §4.3) vaut rôle agent communal.
    if (r.contains('agent') ||
        r.contains('controleur') ||
        r.contains('enqueteur')) {
      return agent;
    }
    return demandeur;
  }
}

/// Résultat de user_login renvoyé par le serveur (RFC section 4.1).
class SessionInfo {
  final String telephone;
  final String nom;

  /// Rôle **canonique** (`demandeur` | `agent_communal`) : la valeur brute du
  /// serveur est normalisée pour que le RBAC ne dépende pas de son formatage.
  final String role;
  final String sessionToken;

  /// Rôle tel que renvoyé par le serveur (traçabilité / journalisation).
  final String roleBrut;

  final bool estAgent;

  SessionInfo({
    required this.telephone,
    required this.nom,
    required String role,
    required this.sessionToken,
  }) : role = Roles.normalize(role),
       roleBrut = role,
       estAgent = Roles.normalize(role) == Roles.agent;
}

/// Résultat de check_location_allowance (section 5.3).
class LocationAllowance {
  final bool allowed;
  final String message;
  final String zoneDescription;
  LocationAllowance({
    required this.allowed,
    required this.message,
    this.zoneDescription = '',
  });
}

/// Résultat de submit_demande_autorisation.
class DemandeResult {
  final String codeDossier;
  final String statut;
  final int montantDroitInstallation;
  DemandeResult({
    required this.codeDossier,
    required this.statut,
    required this.montantDroitInstallation,
  });
}

/// Résultat de register_encaissement : quittance générée.
class EncaissementResult {
  final String numeroQuittance;
  final String numeroAvisPaiement;
  final DateTime horodatage;
  final String message;
  EncaissementResult({
    required this.numeroQuittance,
    required this.numeroAvisPaiement,
    required this.horodatage,
    required this.message,
  });
}

/// Résultat de sync_offline_queue.
class SyncResult {
  final int total;
  final int success;
  final int erreurs;
  final List<String> messages;

  /// Identifiants (clé `id` de la file, section 11) des éléments rejetés par
  /// le serveur. Ces éléments restent en attente pour un nouvel essai.
  final List<int> echecIds;

  SyncResult({
    required this.total,
    required this.success,
    required this.erreurs,
    this.messages = const [],
    this.echecIds = const [],
  });
}

/// Résultat de signalerAnomalie.
class ResultatAnomalie {
  final String reference;
  final String statut;
  final String message;
  ResultatAnomalie({
    required this.reference,
    required this.statut,
    required this.message,
  });
}

/// Résultat de decider_demande : décision portée sur le dossier.
class DemandeDecision {
  final String codeDossier;

  /// Statut résultant : APPROUVE | REJETE | EN_COURS_INSTRUCTION.
  final String statut;

  /// Note conservée (motif de rejet / consigne de correction) ; vide si
  /// approuvé.
  final String note;

  /// Code du kiosque créé — ou déjà lié — à l'approbation ; vide sinon.
  final String codeKiosque;

  /// Numéro d'autorisation délivré à l'approbation ; vide sinon.
  final String autorisationNumero;

  final String message;

  DemandeDecision({
    required this.codeDossier,
    required this.statut,
    required this.note,
    this.codeKiosque = '',
    this.autorisationNumero = '',
    this.message = '',
  });
}
