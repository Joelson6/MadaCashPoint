import '../localization/app_localizations.dart';
import '../security/secure_store.dart';

class CitizenNotification {
  final String id;
  final String type;
  final String title;
  final String message;
  final DateTime date;
  final bool important;

  const CitizenNotification({
    required this.id,
    required this.type,
    required this.title,
    required this.message,
    required this.date,
    this.important = false,
  });
}

/// Centre de notifications du citoyen (section 12 du CDC).
///
/// Adapté au fonctionnement embarqué/offline : les notifications sont
/// dérivées des données locales (dossiers + paiements) plutôt qu'envoyées
/// par push/SMS. Les identifiants déjà vus par l'utilisateur sont persistés
/// dans [SecureStore] afin d'alimenter le badge de non-lus.
class NotificationService {
  NotificationService._();
  static final NotificationService instance = NotificationService._();

  final SecureStore _store = SecureStore.instance;

  /// Construit les notifications actuelles du citoyen à partir de ses
  /// dossiers (loadDossiers) et de son historique de paiements
  /// (loadPaiements). `telephone` sert de clé de cloisonnement (4.2).
  List<CitizenNotification> build(
    String telephone,
    List<Map<String, dynamic>> dossiers,
    List<Map<String, dynamic>> paiements,
  ) {
    final list = <CitizenNotification>[];

    for (final d in dossiers) {
      final code = d['code_dossier']?.toString() ?? '';
      final nom = d['nom_commercial']?.toString() ?? code;
      final date =
          DateTime.tryParse(d['date_soumission']?.toString() ?? '') ??
          DateTime.now();
      final statut = d['statut']?.toString() ?? 'EN_COURS_INSTRUCTION';

      switch (statut) {
        case 'APPROUVE':
          list.add(
            CitizenNotification(
              id: 'dossier-APPROUVE-$code',
              type: 'DOSSIER_APPROUVE',
              title: 'Dossier approuvé',
              message:
                  'Votre dossier « $nom » a été approuvé. '
                  'Le kiosque peut être activé une fois le droit d\'installation réglé.',
              date: date,
              important: true,
            ),
          );
        case 'REJETE':
          final note = d['note_rejet']?.toString() ?? '';
          list.add(
            CitizenNotification(
              id: 'dossier-REJETE-$code',
              type: 'DOSSIER_REJETE',
              title: 'Dossier rejeté',
              message:
                  'Votre dossier « $nom » a été rejeté.'
                  '${note.isEmpty ? '' : ' Motif : $note'}',
              date: date,
              important: true,
            ),
          );
        default:
          list.add(
            CitizenNotification(
              id: 'dossier-EN_COURS-$code',
              type: 'DOSSIER_EN_COURS',
              title: 'Dossier en cours',
              message:
                  'Votre dossier « $nom » est en cours d\'instruction '
                  '(délai habituel de 5 jours ouvrés).',
              date: date,
            ),
          );
      }
    }

    for (final p in paiements) {
      final code = p['code_dossier']?.toString() ?? '';
      final nom = p['nom_commercial']?.toString() ?? code;
      final type = p['type']?.toString() ?? 'RENOUVELLEMENT';
      final statut = p['statut']?.toString() ?? '';
      final montantDu = (p['montant_du'] as num?)?.toInt() ?? 0;
      final annee = p['annee'];
      final dateDu =
          DateTime.tryParse(p['date_paiement']?.toString() ?? '') ??
          DateTime.now();

      if (type == 'DROIT_INSTALLATION' && statut == 'EN_ATTENTE') {
        list.add(
          CitizenNotification(
            id: 'droit-$code',
            type: 'DROIT_A_PAYER',
            title: 'Droit d\'installation à payer',
            message:
                'Le droit d\'installation de « $nom » '
                '(${(p['montant'] as num?)?.toInt() ?? 0} Ar) reste à régler '
                'auprès de l\'agent communal.',
            date: dateDu,
            important: true,
          ),
        );
      }

      if (type == 'RENOUVELLEMENT' && statut == 'EN_RETARD' && montantDu > 0) {
        list.add(
          CitizenNotification(
            id: 'taxe-$annee-$code',
            type: 'TAXE_EN_RETARD',
            title: 'Taxe de renouvellement en retard',
            message:
                'La taxe de renouvellement $annee de « $nom » '
                'est en retard : $montantDu Ar à régulariser.',
            date: dateDu,
            important: true,
          ),
        );
      }

      if (type == 'RENOUVELLEMENT' &&
          statut == 'A_JOUR' &&
          ((p['montant_paye'] as num?)?.toInt() ?? 0) > 0) {
        list.add(
          CitizenNotification(
            id: 'taxe-jour-$annee-$code',
            type: 'TAXE_A_JOUR',
            title: 'Renouvellement à jour',
            message:
                'La taxe de renouvellement $annee de « $nom » est réglée. '
                '${p['numero_quittance'] == null || (p['numero_quittance'] as String).isEmpty ? '' : "Quittance ${p['numero_quittance']}"}',
            date: dateDu,
          ),
        );
      }
    }

    // Identifiant unique : la source de paiements peut répéter un même
    // exercice (lignes d'historique fiscale identiques). Sans déduplication,
    // deux cartes partagent le même identifiant — le compteur de non-lus les
    // compterait toutes deux et le passage à « lu » les basculerait en bloc.
    final vus = <String>{};
    list.retainWhere((n) => vus.add(n.id));

    list.sort((a, b) => b.date.compareTo(a.date));
    return list;
  }

  /// Nombre de notifications non lues pour le citoyen (pour le badge d'accueil).
  int unreadCount(String telephone, List<CitizenNotification> all) {
    final seen = _store.getSeenNotifications(telephone).toSet();
    return all.where((n) => !seen.contains(n.id)).length;
  }

  Set<String> seenIds(String telephone) =>
      _store.getSeenNotifications(telephone).toSet();

  /// Marque les identifiants donnés comme lus (persistant).
  ///
  /// L'union avec les identifiants **déjà vus** est conservée : le stockage
  /// remplace la liste entière, donc une notification absente de `all` au
  /// moment du clic (liste encore partiellement chargée) ne doit pas
  /// redevenir non lue au retour.
  Future<void> markSeen(String telephone, List<CitizenNotification> all) async {
    if (telephone.isEmpty) return;
    final ids = _store.getSeenNotifications(telephone).toSet();
    ids.addAll(all.map((n) => n.id));
    await _store.setSeenNotifications(telephone, ids.toList());
  }

  /// Marque une notification précise comme lue (ouverture depuis la liste).
  Future<void> markSeenId(String telephone, String id) async {
    if (telephone.isEmpty || id.isEmpty) return;
    final ids = _store.getSeenNotifications(telephone);
    if (ids.contains(id)) return;
    await _store.setSeenNotifications(telephone, [...ids, id]);
  }

  // --------------------------------------------------------------------------
  // Notifications persistantes d'anomalie (section 6.5)
  // --------------------------------------------------------------------------

  String _typeAnomalieLabel(String type) => switch (type) {
    'NON_DECLARE' => AppLocalizations.traduire('anom_undeclared'),
    'NON_CONFORMITE' => AppLocalizations.traduire('anom_nonconform'),
    'DEPLACEMENT' => AppLocalizations.traduire('anom_moved'),
    _ => type,
  };

  /// Traduit une ligne du back-end `getNotifications` en notification
  /// affichable. Le message est composé **au moment de la lecture**, dans la
  /// langue active du Demandeur — pas dans celle de l'agent qui a saisi
  /// l'anomalie (la matière première vécue est stockée en base).
  CitizenNotification anomalieVersNotification(Map<String, dynamic> m) {
    final date =
        DateTime.tryParse(m['date']?.toString() ?? '') ?? DateTime.now();
    final dateHeure =
        '${date.day}/${date.month}/${date.year} à '
        '${date.hour}h${date.minute.toString().padLeft(2, '0')}';
    final id = m['id_unique']?.toString() ?? '';
    return CitizenNotification(
      id: id.isEmpty
          ? 'anomalie-${m['reference_anomalie']?.toString() ?? date.millisecondsSinceEpoch}'
          : id,
      type: m['type']?.toString() ?? 'ANOMALIE_SIGNALLEE',
      title: AppLocalizations.traduire('notif_anomaly_title'),
      message: AppLocalizations.traduire(
        'notif_anomaly_message',
        args: [
          _typeAnomalieLabel(m['type_anomalie']?.toString() ?? ''),
          m['code_kiosque']?.toString() ?? '',
          dateHeure,
          m['message_agent']?.toString() ?? '',
        ],
      ),
      date: date,
      important: m['important'] == true,
    );
  }

  /// Liste complète : notifications dérivées (dossiers + paiements) **et**
  /// anomalies persistantes, triées de la plus récente à la plus ancienne.
  List<CitizenNotification> buildComplet(
    String telephone,
    List<Map<String, dynamic>> dossiers,
    List<Map<String, dynamic>> paiements,
    List<Map<String, dynamic>> persistantes,
  ) {
    final liste = build(telephone, dossiers, paiements);
    liste.addAll(persistantes.map(anomalieVersNotification));
    // La source distante peut renvoyer plusieurs fois la même ligne
    // persistante : on déduplique la liste fusionnée par identifiant métier
    // avant l'affichage et le comptage des non-lus.
    final vus = <String>{};
    liste.retainWhere((n) => vus.add(n.id));
    liste.sort((a, b) => b.date.compareTo(a.date));
    return liste;
  }

  /// Une notification est-elle LUE ?
  ///  - dérivées : id déjà vu (persisté dans [SecureStore]) ;
  ///  - anomalies persistantes : état `lu` du back-end (persisté en base Isar).
  bool estLue(
    String telephone,
    CitizenNotification n,
    List<Map<String, dynamic>> persistantes,
  ) {
    if (n.id.startsWith('anomalie-')) {
      for (final m in persistantes) {
        if (m['id_unique'] == n.id) return m['lu'] == true;
      }
      // Ligne supprimée depuis le chargement : la considérer comme lue plutôt
      // que de compter un non-lu fantôme.
      return true;
    }
    return _store.getSeenNotifications(telephone).contains(n.id);
  }

  /// Compteur de non-lus fusionné (dérivées + persistantes).
  int unreadCountComplet(
    String telephone,
    List<CitizenNotification> all,
    List<Map<String, dynamic>> persistantes,
  ) => all.where((n) => !estLue(telephone, n, persistantes)).length;
}
