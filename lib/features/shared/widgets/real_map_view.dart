import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import '../../../core/localization/app_localizations.dart';
import '../../../core/theme/app_theme.dart';

/// Carte réelle OpenStreetMap (tuiles web, sans clé API) — remplacent les
/// anciennes mini-cartes simulées (CustomPaint). Utilise de l'internet
/// (forfait de données) pour charger les tuiles : la carte est affichée en
/// ligne d'après les coordonnées GPS du kiosque / de l'utilisateur.
///
/// - Marqueurs colorés ([MapPin]) pour les kiosques / positions.
/// - Cercles géographiques ([MapZone]) pour les zones interdites (section 5.3).
/// - Repli hors-ligne : si aucun réseau, message explicite au lieu des tuiles.
class MapPin {
  final LatLng point;
  final Color color;
  final String label;
  final bool primary;

  const MapPin({
    required this.point,
    required this.color,
    required this.label,
    this.primary = false,
  });
}

class MapZone {
  final LatLng center;
  final double radiusMeters;
  final Color color;
  final String label;

  const MapZone({
    required this.center,
    required this.radiusMeters,
    required this.color,
    required this.label,
  });
}

class RealMapView extends StatefulWidget {
  final List<MapPin> pins;
  final List<MapZone> zones;
  final double height;

  const RealMapView({
    super.key,
    required this.pins,
    this.zones = const [],
    this.height = 220,
  });

  @override
  State<RealMapView> createState() => _RealMapViewState();
}

class _RealMapViewState extends State<RealMapView> {
  bool? _online;

  @override
  void initState() {
    super.initState();
    _checkConnectivity();
  }

  Future<void> _checkConnectivity() async {
    // connectivity_plus v6 renvoie une liste de résultats (une par interface).
    final r = await Connectivity().checkConnectivity();
    final online = r.any((result) => result != ConnectivityResult.none);
    if (mounted) setState(() => _online = online);
  }

  LatLngBounds _bounds() {
    final pts = <LatLng>[
      for (final p in widget.pins) p.point,
      for (final z in widget.zones) z.center,
    ];
    if (pts.isEmpty) {
      return LatLngBounds(
        const LatLng(-21.466, 47.08),
        const LatLng(-21.466, 47.08),
      );
    }
    return LatLngBounds.fromPoints(pts);
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    return SizedBox(
      height: widget.height,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: _online == false
            ? _OfflinePlaceholder(message: l.t('map_offline'))
            : Stack(
                children: [
                  FlutterMap(
                    options: MapOptions(
                      initialCameraFit: CameraFit.bounds(
                        bounds: _bounds(),
                        padding: const EdgeInsets.all(48),
                        maxZoom: 18,
                      ),
                      minZoom: 12,
                      interactionOptions: const InteractionOptions(
                        flags: InteractiveFlag.all,
                      ),
                      backgroundColor: AppTheme.backgroundLight,
                    ),
                    children: [
                      TileLayer(
                        urlTemplate:
                            'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                        userAgentPackageName: 'mg.cuf.recouvrement_mobile',
                        maxNativeZoom: 19,
                        maxZoom: 19,
                        tileProvider: NetworkTileProvider(),
                      ),
                      if (widget.zones.isNotEmpty)
                        CircleLayer(
                          circles: [
                            for (final z in widget.zones)
                              CircleMarker(
                                point: z.center,
                                radius: z.radiusMeters,
                                useRadiusInMeter: true,
                                color: z.color.withValues(alpha: 0.22),
                                borderColor: z.color,
                                borderStrokeWidth: 2,
                              ),
                          ],
                        ),
                      MarkerLayer(
                        markers: [
                          for (final p in widget.pins)
                            Marker(
                              point: p.point,
                              width: 120,
                              height: 64,
                              alignment: const Alignment(0, 1),
                              child: _KiosquePin(
                                color: p.color,
                                label: p.label,
                                primary: p.primary,
                              ),
                            ),
                        ],
                      ),
                      const _AttributionBar(),
                    ],
                  ),
                ],
              ),
      ),
    );
  }
}

/// Épinglette kiosque : pastille + libellé au-dessus de la pointe.
class _KiosquePin extends StatelessWidget {
  final Color color;
  final String label;
  final bool primary;

  const _KiosquePin({
    required this.color,
    required this.label,
    required this.primary,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          constraints: const BoxConstraints(maxWidth: 110),
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(6),
            boxShadow: const [BoxShadow(blurRadius: 4, color: Colors.black26)],
          ),
          child: Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ),
        Icon(
          Icons.location_on,
          size: primary ? 40 : 30,
          color: color,
          shadows: const [Shadow(blurRadius: 4, color: Colors.black38)],
        ),
      ],
    );
  }
}

class _AttributionBar extends StatelessWidget {
  const _AttributionBar();

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 4,
      bottom: 2,
      child: Text(
        '© OpenStreetMap contributors',
        style: TextStyle(
          fontSize: 9,
          color: Colors.grey.shade800,
          backgroundColor: Colors.white70,
        ),
      ),
    );
  }
}

class _OfflinePlaceholder extends StatelessWidget {
  final String message;
  const _OfflinePlaceholder({required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.surfaceLight,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.cloud_off, color: Colors.grey, size: 40),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                message,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.grey),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
