import 'package:flutter/material.dart';

/// Thème officiel — bleu marine & blanc.
/// Palette :
///   - primaryNavy : bleu marine profond (AppBar, boutons principaux)
///   - accentNavy  : bleu vif (accent, gradients, filled buttons)
///   - statutVert  : kiosque en règle / approuvé
///   - statutOrange: kiosque en attente (droit d'installation)
///   - statutRouge : kiosque redevable / anomalie
class AppTheme {
  AppTheme._();

  // --- Générique (bleu marine) ---
  static const Color primaryNavy = Color(0xFF0D3251);
  static const Color accentNavy = Color(0xFF1565C0);
  static const Color surfaceLight = Color(0xFFF5F8FC);
  static const Color backgroundLight = Color(0xFFEDF1F7);

  // --- Statuts fiscaux kiosque (section 6.2) ---
  static const Color statutVert = Color(0xFF1B8A3E);
  static const Color statutOrange = Color(0xFFE57C00);
  static const Color statutRouge = Color(0xFFD32F2F);

  static Color statusColor(String status) {
    switch (status) {
      case 'VERT':
        return statutVert;
      case 'ORANGE':
        return statutOrange;
      case 'ROUGE':
        return statutRouge;
      default:
        return Colors.grey;
    }
  }

  static ThemeData get light => ThemeData(
    useMaterial3: true,
    colorSchemeSeed: primaryNavy,
    brightness: Brightness.light,
    scaffoldBackgroundColor: backgroundLight,
    appBarTheme: const AppBarTheme(
      backgroundColor: primaryNavy,
      foregroundColor: Colors.white,
      elevation: 2,
      centerTitle: true,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryNavy,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        backgroundColor: accentNavy,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        side: const BorderSide(color: primaryNavy, width: 1.5),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        textStyle: const TextStyle(fontSize: 15, color: primaryNavy),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: surfaceLight,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.grey),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: primaryNavy, width: 2),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    ),
    cardTheme: CardThemeData(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    ),
  );
}
