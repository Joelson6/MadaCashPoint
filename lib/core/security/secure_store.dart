import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Stockage sécurisé des paramètres légers (session, OTP, langue).
/// Aucune donnée sensible (CIN, photos) n'y est conservée de façon permanente.
class SecureStore {
  SecureStore._();

  static final SecureStore instance = SecureStore._();
  SharedPreferences? _prefs;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  SharedPreferences get prefs {
    if (_prefs == null) {
      throw StateError('SecureStore non initialisé');
    }
    return _prefs!;
  }

  // --- Session ---
  Future<void> saveSession({
    required String telephone,
    required String nom,
    required String role,
    required String sessionToken,
  }) async {
    final p = prefs;
    await p.setString('session.telephone', telephone);
    await p.setString('session.nom', nom);
    await p.setString('session.role', role);
    await p.setString('session.token', sessionToken);
  }

  Map<String, String>? loadSession() {
    final t = prefs.getString('session.telephone');
    final token = prefs.getString('session.token');
    if (t == null || token == null) return null;
    return {
      'telephone': t,
      'nom': prefs.getString('session.nom') ?? '',
      'role': prefs.getString('session.role') ?? 'demandeur',
      'sessionToken': token,
    };
  }

  Future<void> clearSession() async {
    final p = prefs;
    await p.remove('session.telephone');
    await p.remove('session.nom');
    await p.remove('session.role');
    await p.remove('session.token');
  }

  bool isLoggedIn() => prefs.getString('session.token') != null;
  String? getRole() => prefs.getString('session.role');
  String? getTelephone() => prefs.getString('session.telephone');
  String? getSessionToken() => prefs.getString('session.token');

  // --- OTP SMS (simulé en mode embarqué) ---
  Future<void> saveOtp(
    String telephone,
    String otp, {
    int ttlSeconds = 300,
  }) async {
    final p = prefs;
    await p.setString('otp.$telephone', otp);
    await p.setInt(
      'otp.expiry.$telephone',
      DateTime.now().add(Duration(seconds: ttlSeconds)).millisecondsSinceEpoch,
    );
  }

  String? verifOtp(String telephone, String code) {
    final p = prefs;
    final stored = p.getString('otp.$telephone');
    final expiry = p.getInt('otp.expiry.$telephone') ?? 0;
    if (stored == null || stored != code) return 'Code OTP incorrect';
    if (DateTime.now().millisecondsSinceEpoch > expiry)
      return 'Code OTP expiré';
    p.remove('otp.$telephone');
    p.remove('otp.expiry.$telephone');
    return null;
  }

  String? getDemoOtp(String telephone) => prefs.getString('otp.$telephone');

  // --- Préférences UI ---
  Future<void> setLanguage(String lang) => prefs.setString('lang', lang);
  String? getLanguage() => prefs.getString('lang');

  /// Horodatage de la dernière interaction (verrouillage auto agent).
  Future<void> setLastInteraction(DateTime t) =>
      prefs.setInt('lastInteraction', t.millisecondsSinceEpoch);

  DateTime getLastInteraction() {
    final ms = prefs.getInt('lastInteraction');
    return ms == null
        ? DateTime.now()
        : DateTime.fromMillisecondsSinceEpoch(ms);
  }

  // --- Brouillon de demande d'autorisation (offline-first, section 5/11) ---
  /// Seules les valeurs non sensibles sont conservées ; les photos restent
  /// des chemins locaux à recapturer si nécessaires.
  Future<void> saveDraftDemande({
    required Map<String, dynamic> fields,
    required int step,
    bool? geoAllowed,
    String? geoMessage,
  }) async {
    await prefs.setString(
      'citoyen.draft',
      jsonEncode({
        'step': step,
        'geoAllowed': geoAllowed,
        'geoMessage': geoMessage,
        'fields': fields,
      }),
    );
  }

  Map<String, dynamic>? loadDraftDemande() {
    final raw = prefs.getString('citoyen.draft');
    if (raw == null || raw.isEmpty) return null;
    try {
      final decoded = jsonDecode(raw);
      return decoded is Map<String, dynamic> ? decoded : null;
    } catch (e) {
      debugPrint('[SecureStore] draft illisible : $e');
      return null;
    }
  }

  Future<void> clearDraftDemande() async {
    await prefs.remove('citoyen.draft');
  }

  // --- Notifications lues par le citoyen (section 12) ---
  Future<void> setSeenNotifications(String telephone, List<String> ids) async {
    await prefs.setStringList('notifications.seen.$telephone', ids);
  }

  List<String> getSeenNotifications(String telephone) =>
      prefs.getStringList('notifications.seen.$telephone') ?? const [];
}
