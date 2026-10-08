import 'dart:convert';

import 'package:crypto/crypto.dart' as crypto;

/// Formateurs : montants Ariary, dates, distances.
class Formatters {
  Formatters._();

  static String ariary(dynamic v) {
    final n = (v is num) ? v : double.tryParse('$v') ?? 0;
    final parts = n.toStringAsFixed(0);
    final buf = StringBuffer();
    for (var i = 0; i < parts.length; i++) {
      final idx = parts.length - 1 - i;
      buf.write(parts[idx]);
      if (i > 0 && (i + 1) % 3 == 0 && idx != 0) {
        buf.write(' ');
      }
    }
    return '${buf.toString().split('').reversed.join()} Ar';
  }

  static String dateFr(DateTime? d) {
    if (d == null) return '—';
    const mois = [
      'janvier',
      'février',
      'mars',
      'avril',
      'mai',
      'juin',
      'juillet',
      'août',
      'septembre',
      'octobre',
      'novembre',
      'décembre',
    ];
    return '${d.day} ${mois[d.month - 1]} ${d.year}';
  }

  static String dateISO(DateTime d) {
    String p(int v) => v.toString().padLeft(2, '0');
    return '${d.year}-${p(d.month)}-${p(d.day)}';
  }

  static String distanceMeters(double meters) {
    if (meters < 1) return '< 1 m';
    if (meters < 1000) return '${meters.toStringAsFixed(0)} m';
    return '${(meters / 1000).toStringAsFixed(1)} km';
  }

  /// Numéro de quittance généré localement quand le serveur est hors-ligne
  /// (section 6.4 : la quittance doit pouvoir être imprimée sans réseau).
  /// Remplacé par le numéro officiel du serveur à la synchronisation.
  static String quittanceLocale(int sequence) {
    final now = DateTime.now();
    String p(int v) => v.toString().padLeft(2, '0');
    return 'QUIT-OFF-${now.year}${p(now.month)}${p(now.day)}-$sequence';
  }

  /// Référence unique générée côté client (anomalies…). Réutilisée au rejeu
  /// de la file `sync_offline_queue` pour garantir l'idempotence (section 11).
  static String referenceLocale(String prefix) {
    final now = DateTime.now();
    final seq = now.millisecondsSinceEpoch % 1000000;
    return '$prefix-${now.year}${now.month}${now.day}-$seq';
  }
}

/// Cryptographie : hachage SHA-256 (aucune donnée sensible stockée en clair).
class Crypto {
  Crypto._();

  static String sha256(String input) {
    return crypto.sha256.convert(utf8.encode(input)).toString();
  }
}
