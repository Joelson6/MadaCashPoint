import 'package:isar/isar.dart';

part 'notification_item.g.dart';

/// Notification persistante destinée à un Demandeur (section 6.5 / 7 du
/// cahier des charges).
///
/// Contrairement aux notifications dérivées (recalculées à la lecture depuis
/// les dossiers/paiements), ces lignes sont **écrites** par le back-end au
/// moment où un Agent Communal signale une anomalie : elles survivent au
/// redémarrage et sont marquées lues de façon persistante.
@collection
class NotificationItem {
  Id id = Isar.autoIncrement;

  /// Identifiant métier unique (ex. « anomalie-AN-12345 ») : l'index
  /// unique/remplacement garantit l'absence de doublons au rejeu d'une
  /// anomalie déjà transmise.
  @Index(unique: true, replace: true)
  String idUnique = '';

  /// Téléphone normalisé du destinataire (cloisonnement par utilisateur).
  @Index()
  String destinataire = '';

  /// Type de la notification (ex. `ANOMALIE_SIGNALLEE`).
  String type = '';

  /// Contexte concerné : code du kiosque en défaut, vide si inconnu.
  String codeKiosque = '';

  /// Type de l'anomalie : NON_DECLARE | NON_CONFORMITE | DEPLACEMENT.
  String typeAnomalie = '';

  /// Message libre saisi par l'agent lors du signalement.
  String messageAgent = '';

  /// Référence de l'anomalie d'origine (pour relier notification ⇄ anomalie).
  String referenceAnomalie = '';

  DateTime date = DateTime.now();
  bool lu = false;
  bool important = true;

  NotificationItem({
    required this.idUnique,
    required this.destinataire,
    required this.type,
    required this.codeKiosque,
    required this.typeAnomalie,
    required this.messageAgent,
    required this.referenceAnomalie,
    this.lu = false,
    this.important = true,
  });
}