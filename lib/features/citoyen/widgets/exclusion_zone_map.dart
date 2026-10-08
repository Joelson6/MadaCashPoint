import 'dart:math';

import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';

import '../../../core/theme/app_theme.dart';
import '../../shared/widgets/real_map_view.dart';

/// Carte d'exclusion cartographique (section 5.3 du CDC).
///
/// Affiche la position de l'utilisateur (point bleu) et, en rouge, les zones
/// où l'implantation est interdite (trottoir intégral, emprise RN7, zone
/// administrative protégée). S'appuie sur les tuiles OpenStreetMap réelles
/// (internet) via [RealMapView].
class ExclusionZoneMap extends StatelessWidget {
  final double latitude;
  final double longitude;
  final List<Map<String, dynamic>> zones;
  final double? height;

  const ExclusionZoneMap({
    super.key,
    required this.latitude,
    required this.longitude,
    required this.zones,
    this.height = 260,
  });

  @override
  Widget build(BuildContext context) {
    // Zones visibles dans un rayon global de 5 km autour de l'utilisateur.
    final zonesProches = zones.where((z) {
      final d = distanceMetres(
        latitude,
        longitude,
        (z['latitude'] as num?)?.toDouble() ?? 0,
        (z['longitude'] as num?)?.toDouble() ?? 0,
      );
      final rayon = (z['rayon_metres'] as num?)?.toDouble() ?? 0;
      return d - rayon <= 5000;
    }).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(
          height: height,
          child: RealMapView(
            pins: [
              MapPin(
                point: LatLng(latitude, longitude),
                color: const Color(0xFF1565C0),
                label: 'Vous êtes ici',
                primary: true,
              ),
            ],
            zones: [
              for (final z in zonesProches)
                MapZone(
                  center: LatLng(
                    (z['latitude'] as num?)?.toDouble() ?? 0,
                    (z['longitude'] as num?)?.toDouble() ?? 0,
                  ),
                  radiusMeters: (z['rayon_metres'] as num?)?.toDouble() ?? 0,
                  color: AppTheme.statutRouge,
                  label: z['label']?.toString() ?? '',
                ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            _Legende(
              couleur: AppTheme.statutRouge,
              icone: Icons.circle,
              label: 'Zone interdite',
            ),
            const SizedBox(width: 16),
            _Legende(
              couleur: const Color(0xFF1565C0),
              icone: Icons.my_location,
              label: 'Vous êtes ici',
            ),
          ],
        ),
      ],
    );
  }
}

class _Legende extends StatelessWidget {
  final Color couleur;
  final IconData icone;
  final String label;
  const _Legende({
    required this.couleur,
    required this.icone,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icone, color: couleur, size: 14),
        const SizedBox(width: 4),
        Text(label, style: const TextStyle(fontSize: 11)),
      ],
    );
  }
}

/// Distance de Haversine en mètres (réutilisée depuis formatters).
double distanceMetres(double lat1, double lon1, double lat2, double lon2) {
  const r = 6371000.0;
  final dLat = (lat2 - lat1) * pi / 180;
  final dLon = (lon2 - lon1) * pi / 180;
  final a =
      sin(dLat / 2) * sin(dLat / 2) +
      cos(lat1 * pi / 180) *
          cos(lat2 * pi / 180) *
          sin(dLon / 2) *
          sin(dLon / 2);
  return 2 * r * atan2(sqrt(a), sqrt(1 - a));
}
