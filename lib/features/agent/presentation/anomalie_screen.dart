import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';

import '../../../core/localization/app_localizations.dart';
import '../../../core/theme/app_theme.dart';
import '../../../data/models/kiosque.dart';
import '../../auth/bloc/auth_cubit.dart';
import '../../shared/widgets/shared_widgets.dart';
import '../bloc/agent_cubit.dart';
import '../bloc/agent_cubit.dart' as agent_state;
import 'agent_feedback.dart';

/// Signalement d'anomalies terrain (section 6.5 du CDC) :
/// kiosque non déclaré / non-conformité physique / déplacement GPS.
class AnomalieScreen extends StatefulWidget {
  final Map<String, dynamic> fiche;
  final Kiosque? kiosqueLocal;
  const AnomalieScreen({super.key, required this.fiche, this.kiosqueLocal});

  @override
  State<AnomalieScreen> createState() => _AnomalieScreenState();
}

class _AnomalieScreenState extends State<AnomalieScreen> {
  String _type = 'NON_DECLARE';
  final _descCtrl = TextEditingController();
  double _gpsLat = 0;
  double _gpsLon = 0;
  bool _gpsEnCours = true;
  bool _gpsOk = false;

  Map _principal() => (widget.fiche['kiosque_principal'] ?? {}) as Map;

  @override
  void initState() {
    super.initState();
    _tryGps();
  }

  @override
  void dispose() {
    _descCtrl.dispose();
    super.dispose();
  }

  /// Capture automatique de la position (traçabilité §4.3), lancée à l'ouverture
  /// et rejouable via « Réessayer » — même correctif que l'encaissement :
  /// permission vérifiée/demandée une fois puis re-vérifiée, `LocationSettings`
  /// (fin du `.timeout()` qui laissait le géolocaliseur actif en arrière-plan et
  /// de l'API dépréciée `desiredAccuracy`), gardes `mounted` après chaque
  /// `await` (un écran fermé pendant la recherche ne déclenche plus
  /// `setState() called after dispose()`).
  Future<void> _tryGps() async {
    if (!mounted) return;
    setState(() => _gpsEnCours = true);
    try {
      var permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        if (!mounted) return;
        setState(() {
          _gpsOk = false;
          _gpsEnCours = false;
        });
        return;
      }
      final pos = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
          // Délai de garde en intérieur : au-delà, pas de coordonnées — la
          // confirmation explicite de l'agent est requise.
          timeLimit: Duration(seconds: 5),
        ),
      );
      if (!mounted) return;
      setState(() {
        _gpsLat = pos.latitude;
        _gpsLon = pos.longitude;
        _gpsOk = true;
        _gpsEnCours = false;
      });
    } catch (_) {
      // GPS indisponible : le signalement reste possible — sans coordonnées,
      // la confirmation explicite de l'agent est requise (traçabilité §4.3).
      if (!mounted) return;
      setState(() {
        _gpsOk = false;
        _gpsEnCours = false;
      });
    }
  }

  Future<bool?> _confirmerSansGps() {
    final l = AppLocalizations.of(context);
    return showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l.t('anom_gps_missing_title')),
        content: Text(l.t('anom_gps_missing_body')),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: Text(l.t('cancel')),
          ),
          FilledButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            child: Text(l.t('anom_continue_no_gps')),
          ),
        ],
      ),
    );
  }

  Future<void> _signaler() async {
    final session = context.read<AuthCubit>().state.session;
    if (session == null) return;
    // Traçabilité (section 4.3) : sans coordonnées GPS, confirmation explicite.
    if (!_gpsOk) {
      final ok = await _confirmerSansGps();
      if (ok != true || !mounted) return;
    }
    final code = _principal()['code_kiosque']?.toString() ?? '';
    final envoye = await context.read<AgentCubit>().signalerAnomalie(
      codeKiosque: code,
      type: _type,
      description: _descCtrl.text,
      agentTelephone: session.telephone,
      sessionToken: session.sessionToken,
      gpsLat: _gpsLat,
      gpsLon: _gpsLon,
    );
    // Retour unique : seul un envoi concluant ferme l'écran. En cas d'erreur
    // métier, le message est affiché par l'écouteur et l'agent corrige le
    // signalement sur place (aucun double retour en arrière).
    if (envoye && mounted) Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final principal = _principal();

    return Scaffold(
      appBar: AppBar(
        title: Text(l.t('report_anomaly')),
        actions: const [LanguageSwitchButton()],
      ),
      body: BlocConsumer<AgentCubit, agent_state.AgentState>(
        listenWhen: agentEcouteMessages,
        listener: agentAfficherMessages,
        builder: (context, state) {
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Card(
                child: ListTile(
                  leading: const Icon(
                    Icons.storefront,
                    color: AppTheme.primaryNavy,
                  ),
                  title: Text(principal['code_kiosque']?.toString() ?? ''),
                  subtitle: Text(
                    principal['proprietaire_nom']?.toString() ?? '',
                  ),
                ),
              ),
              const SizedBox(height: 14),
              Text(
                l.t('anom_type'),
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              RadioListTile<String>(
                dense: true,
                value: 'NON_DECLARE',
                groupValue: _type,
                title: Text(l.t('anom_undeclared')),
                onChanged: (v) => setState(() => _type = v!),
              ),
              RadioListTile<String>(
                dense: true,
                value: 'NON_CONFORMITE',
                groupValue: _type,
                title: Text(l.t('anom_nonconform')),
                onChanged: (v) => setState(() => _type = v!),
              ),
              RadioListTile<String>(
                dense: true,
                value: 'DEPLACEMENT',
                groupValue: _type,
                title: Text(l.t('anom_moved')),
                onChanged: (v) => setState(() => _type = v!),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _descCtrl,
                maxLines: 4,
                decoration: InputDecoration(
                  labelText: l.t('anom_details'),
                  hintText: l.t('anom_hint'),
                  border: const OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  if (_gpsEnCours) ...[
                    const SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                  ] else
                    Icon(
                      _gpsOk ? Icons.gps_fixed : Icons.gps_off,
                      size: 16,
                      color: _gpsOk
                          ? AppTheme.statutVert
                          : AppTheme.statutOrange,
                    ),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      _gpsEnCours
                          ? l.t('gps_pending')
                          : _gpsOk
                          ? '${_gpsLat.toStringAsFixed(6)}, '
                                '${_gpsLon.toStringAsFixed(6)}'
                          : l.t('gps_missing_short'),
                      style: TextStyle(
                        fontSize: 12,
                        color: _gpsEnCours || _gpsOk
                            ? null
                            : AppTheme.statutOrange,
                      ),
                    ),
                  ),
                ],
              ),
              if (!_gpsEnCours && !_gpsOk)
                Padding(
                  padding: const EdgeInsets.only(top: 6),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          l.t('gps_warning'),
                          style: const TextStyle(
                            fontSize: 11,
                            color: AppTheme.statutOrange,
                          ),
                        ),
                      ),
                      TextButton.icon(
                        onPressed: _tryGps,
                        icon: const Icon(Icons.refresh, size: 16),
                        label: Text(l.t('retry')),
                      ),
                    ],
                  ),
                ),
              const SizedBox(height: 12),
              ElevatedButton.icon(
                onPressed: state.loading ? null : _signaler,
                icon: const Icon(Icons.send),
                label: Text(l.t('report_anomaly')),
              ),
            ],
          );
        },
      ),
    );
  }
}
