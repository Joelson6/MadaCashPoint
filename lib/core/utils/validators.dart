/// Validation des numéros de téléphone malgaches (9 chiffres, ex. 034XXXXXXX).
class PhoneValidator {
  static final RegExp _phone9 = RegExp(r'^0?3[1234][0-9]{7}$');

  /// Retourne le numéro normalisé à 9 chiffres (sans le 0 initial).
  ///
  /// **Idempotent** : `normalize(normalize(x)) == normalize(x)`. C'est
  /// indispensable car le format normalisé (`34XXXXXXXX`) est stocké en base
  /// (session, comptes, dossiers) puis **réintroduit** comme argument des
  /// requêtes (`get_mes_dossiers`, `get_mes_paiements`). Une version qui
  /// retirait systématiquement le premier caractère retournait
  /// `400000002` au lieu de `340000002` lors du second passage : le suivi des
  /// dossiers et l'historique des paiements du demandeur revenaient vides.
  static String? normalize(String raw) {
    var s = raw.trim().replaceAll(RegExp(r'[\s\-.]'), '');
    if (s.startsWith('+261')) {
      s = '0${s.substring(4)}';
    } else if (s.startsWith('261')) {
      s = '0${s.substring(3)}';
    }
    if (!_phone9.hasMatch(s)) return null;
    // 034XXXXXXXX -> 34XXXXXXXX ; 34XXXXXXXX -> identique.
    return s.startsWith('0') ? s.substring(1) : s;
  }

  static bool isValid(String raw) => normalize(raw) != null;
}

/// Validation du code PIN numérique 4 ou 6 chiffres (section 4.1).
class PinValidator {
  static final RegExp _pin = RegExp(r'^[0-9]{4}$|^[0-9]{6}$');
  static bool isValid(String v) => _pin.hasMatch(v);
  static bool is4or6(String v) => _pin.hasMatch(v);
}

/// Validation du numéro de CIN (alphanumérique, ex. 101 012 345 678).
class CinValidator {
  static bool isValid(String v) =>
      RegExp(r'^[A-Za-z0-9\s-]{6,}$').hasMatch(v.trim());
}
