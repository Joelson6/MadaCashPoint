import 'package:flutter/services.dart';

/// Formatters automatiques réutilisables pour les formulaires CUF.
class AutoInputFormatters {
  AutoInputFormatters._();

  /// Chiffres uniquement
  static final TextInputFormatter digitsOnly =
      FilteringTextInputFormatter.digitsOnly;

  /// Téléphone malgache : exactement 10 chiffres, préfixes opérateurs valides
  static List<TextInputFormatter> phoneMg({int maxLength = 10}) => [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(maxLength),
      ];

  /// Code PIN : 4 ou 6 chiffres
  static List<TextInputFormatter> pin({int maxLength = 6}) => [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(maxLength),
      ];

  /// CIN : 12 chiffres uniquement
  static List<TextInputFormatter> cin() => [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(12),
      ];

  /// Nom : lettres uniquement, espaces, apostrophes - converti en MAJUSCULES
  static List<TextInputFormatter> nomMajuscules() => [
        FilteringTextInputFormatter.allow(RegExp(r"[A-Za-zÀ-ÖØ-öø-ÿ'\s-]")),
        UpperCaseTextFormatter(),
        LengthLimitingTextInputFormatter(60),
      ];

  /// Prénom : lettres uniquement avec capitalisation intelligente
  static List<TextInputFormatter> prenom() => [
        FilteringTextInputFormatter.allow(RegExp(r"[A-Za-zÀ-ÖØ-öø-ÿ'\s-]")),
        CapitalizeWordsTextFormatter(),
        LengthLimitingTextInputFormatter(60),
      ];

  /// Montant Ariary : chiffres uniquement
  static List<TextInputFormatter> amount() => [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(12),
      ];

  /// Nombres décimaux (longueur/largeur kiosque)
  static List<TextInputFormatter> decimal() => [
        FilteringTextInputFormatter.allow(RegExp(r'[0-9.,]')),
      ];
}

/// Convertit automatiquement en majuscules
class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    return newValue.copyWith(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}

/// Met en majuscule la première lettre de chaque mot, reste en minuscules
class CapitalizeWordsTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final text = newValue.text;
    if (text.isEmpty) {
      return newValue;
    }
    final words = text.split(RegExp(r'\s+'));
    final capitalized = words.map((word) {
      if (word.isEmpty) return word;
      final lower = word.toLowerCase();
      if (lower.contains("'") || lower.contains('-')) {
        // Gérer apostrophes et traits d'union
        final parts = lower.split(RegExp(r"['-]"));
        final sep = lower.contains("'") && lower.contains('-')
            ? lower.contains("'") && lower.indexOf("'") < lower.indexOf('-')
                ? "'"
                : '-'
            : lower.contains("'")
                ? "'"
                : '-';
        final cappedParts = parts.map((p) {
          if (p.isEmpty) return p;
          return p[0].toUpperCase() + p.substring(1);
        }).toList();
        // Reconstruire avec séparateur d'origine
        String result = cappedParts[0];
        for (int i = 1; i < cappedParts.length; i++) {
          final idx = lower.indexOf(sep == "'" ? "'" : '-', 
            i == 1 ? lower.indexOf(parts[0]) + parts[0].length : 
            lower.indexOf(sep == "'" ? "'" : '-', lower.indexOf(parts[i-1]) + parts[i-1].length + 1));
          result += (idx >= 0 && lower[idx] == "'") ? "'" : "-";
          result += cappedParts[i];
        }
        return result;
      }
      return lower[0].toUpperCase() + lower.substring(1);
    }).toList();
    final result = capitalized.join(' ');
    return newValue.copyWith(
      text: result,
      selection: TextSelection.collapsed(offset: result.length),
    );
  }
}

/// Nettoie les espaces multiples
class TrimTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final cleaned = newValue.text.replaceAll(RegExp(r'\s+'), ' ');
    return newValue.copyWith(
      text: cleaned,
      selection: newValue.selection,
    );
  }
}
