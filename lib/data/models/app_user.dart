import 'package:isar/isar.dart';

part 'app_user.g.dart';

/// Compte utilisateur (Citoyen = demandeur | Agent Communal).
/// RBAC : le rôle détermine l'interface métier affichée (section 4 du CDC).
@collection
class AppUser {
  Id id = Isar.autoIncrement;

  /// Identifiant universel : numéro de téléphone local 9 chiffres (ex 034XXXXXXX).
  @Index(unique: true, replace: true)
  late String telephone;

  /// Code PIN numérique 4 ou 6 chiffres (clé d'accès).
  late String pinCode;

  late String nom;
  String prenom = '';
  String cin = '';
  String cinDate = '';
  String cinLieu = '';
  String quartier = '';
  String fokontany = '';

  /// role : 'demandeur' | 'agent_communal'
  late String role;

  /// Jeton de session XML-RPC renvoyé par user_login.
  String sessionToken = '';

  /// Compte vérifié par OTP (demandeur) ou créé par l'admin (agent).
  bool isVerified = false;

  bool isActive = true;

  DateTime createdAt = DateTime.now();
  DateTime? lastLoginAt;

  AppUser({
    required this.telephone,
    required this.pinCode,
    required this.nom,
    required this.role,
  });
}