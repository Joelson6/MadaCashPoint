import '../localization/app_localizations.dart';
import 'validators.dart';

/// Règles de validation centralisées pour tous les formulaires.
class FormRules {
  FormRules._();

  // Préfixes valides des opérateurs mobiles à Madagascar
  static const List<String> validPhonePrefixes = [
    '032', '033', '034', '035', '036', '037', '038', '039'
  ];

  static String? required(String? value, AppLocalizations l) {
    if (value == null || value.trim().isEmpty) {
      return l.t('field_required');
    }
    return null;
  }

  static String? requiredMinLength(String? value, int min, AppLocalizations l) {
    if (value == null || value.trim().length < min) {
      return l.t('field_required');
    }
    return null;
  }

  static String? phone(String? value, AppLocalizations l) {
    if (value == null || value.isEmpty) return l.t('field_required');
    // Doit avoir exactement 10 chiffres
    if (value.length != 10) {
      return l.t('phone_format_error');
    }
    // Vérifier préfixe opérateur valide à Madagascar
    final prefix = value.substring(0, 3);
    if (!validPhonePrefixes.contains(prefix)) {
      return l.t('phone_format_error');
    }
    if (!PhoneValidator.isValid(value)) {
      return l.t('phone_format_error');
    }
    return null;
  }

  static String? pin(String? value, AppLocalizations l) {
    if (value == null || value.isEmpty) return l.t('field_required');
    if (!PinValidator.isValid(value)) {
      return l.t('mandatory');
    }
    return null;
  }

  static String? cin(String? value, AppLocalizations l) {
    if (value == null || value.trim().isEmpty) return l.t('field_required');
    final cleaned = value.trim();
    // CIN malgache doit avoir exactement 12 chiffres
    if (cleaned.length != 12) {
      return l.t('cin_invalid');
    }
    if (!RegExp(r'^[0-9]{12}$').hasMatch(cleaned)) {
      return l.t('cin_invalid');
    }
    return null;
  }

  static String? nom(String? value, AppLocalizations l) {
    if (value == null || value.trim().isEmpty) return l.t('field_required');
    // Uniquement lettres, espaces, apostrophes, traits d'union
    if (!RegExp(r"^[A-Za-zÀ-ÖØ-öø-ÿ'\s-]+$").hasMatch(value.trim())) {
      return l.t('field_required');
    }
    return null;
  }

  static String? prenom(String? value, AppLocalizations l) {
    if (value == null || value.trim().isEmpty) return l.t('field_required');
    if (!RegExp(r"^[A-Za-zÀ-ÖØ-öø-ÿ'\s-]+$").hasMatch(value.trim())) {
      return l.t('field_required');
    }
    return null;
  }

  static String? positiveNumber(String? value, AppLocalizations l) {
    if (value == null || value.trim().isEmpty) return l.t('field_required');
    final v = double.tryParse(value.trim().replaceAll(',', '.'));
    if (v == null) return l.t('invalid_number');
    if (v <= 0) return l.t('must_be_positive');
    return null;
  }

  static String? nonNegativeNumber(String? value, AppLocalizations l) {
    if (value == null || value.trim().isEmpty) return l.t('field_required');
    final v = double.tryParse(value.trim().replaceAll(',', '.'));
    if (v == null) return l.t('invalid_number');
    if (v < 0) return l.t('invalid_number');
    return null;
  }

  static String? montantPositif(String? value, AppLocalizations l) {
    if (value == null || value.trim().isEmpty) return l.t('field_required');
    final n = int.tryParse(value.trim());
    if (n == null || n <= 0) return l.t('enc_amount_invalid');
    return null;
  }

  static String? dateIso(String? value, AppLocalizations l) {
    if (value == null || value.trim().isEmpty) return l.t('field_required');
    final d = DateTime.tryParse(value.trim());
    if (d == null) return l.t('cin_invalid');
    return null;
  }

  static String? operateurs(List<dynamic>? list, AppLocalizations l) {
    if (list == null || list.isEmpty) return l.t('select_one_operator');
    return null;
  }

  static String? typeIdentification(String? value, AppLocalizations l) {
    if (value == null || value.isEmpty) {
      return l.t('select_type_identification');
    }
    return null;
  }

  static String? fokontany(String? value, AppLocalizations l) {
    if (value == null || value.isEmpty) return l.t('select_fokontany');
    return null;
  }

  static String? materiaux(String? value, AppLocalizations l) {
    if (value == null || value.isEmpty) return l.t('select_materials');
    return null;
  }
}
