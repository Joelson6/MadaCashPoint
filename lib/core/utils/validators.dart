/// Validation des numéros de téléphone (10 chiffres exactement).
class PhoneValidator {
  static final RegExp _phone10 = RegExp(r'^[0-9]{10}$');

  /// Retourne le numéro normalisé à 10 chiffres.
  static String? normalize(String raw) {
    var s = raw.trim().replaceAll(RegExp(r'[\s\-.+()]'), '');
    // Indicatif Madagascar : 261XXXXXXXXX -> 0XXXXXXXXX.
    if (s.startsWith('261')) {
      s = s.substring(3);
    }
    // Numéro national saisi sans le 0 initial : 34XXXXXXX -> 034XXXXXXX.
    if (s.length == 9 && !s.startsWith('0')) {
      s = '0$s';
    }
    if (!_phone10.hasMatch(s)) return null;
    return s;
  }

  static bool isValid(String raw) => normalize(raw) != null;
}

/// Validation du code PIN numérique 4 ou 6 chiffres (section 4.1).
class PinValidator {
  static final RegExp _pin = RegExp(r'^[0-9]{4}$|^[0-9]{6}$');
  static bool isValid(String v) => _pin.hasMatch(v);
  static bool is4or6(String v) => _pin.hasMatch(v);
}

/// Validation du numéro de CIN (exactement 12 chiffres).
class CinValidator {
  static final RegExp _cin12 = RegExp(r'^[0-9]{12}$');

  static bool isValid(String v) => _cin12.hasMatch(v.trim());
}
