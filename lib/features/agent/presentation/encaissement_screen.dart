import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';

import '../../../core/config/app_config.dart';
import '../../../core/localization/app_localizations.dart';
import '../../../core/theme/app_theme.dart';
import '../../../data/models/kiosque.dart';
import '../../auth/bloc/auth_cubit.dart';
import '../../shared/widgets/shared_widgets.dart';
import '../bloc/agent_cubit.dart';
import '../bloc/agent_cubit.dart' as agent_state;
import '../widgets/receipt_printer.dart';

/// Enregistrement d'un encaissement (section 6.4) : saisie du montant perçu
/// en espèces, nature de la taxe, horodatage + session_token + GPS, puis
/// génération et impression de la quittance.
class EncaissementScreen extends StatefulWidget {
  final Map<String, dynamic> fiche;
  final Kiosque? kiosqueLocal;
  const EncaissementScreen({super.key, required this.fiche, this.kiosqueLocal});

  @override
  State<EncaissementScreen> createState() => _EncaissementScreenState();
}

class _EncaissementScreenState extends State<EncaissementScreen> {
  final _montantCtrl = TextEditingController();
  String _nature = 'RENOUVELLEMENT';
  double _gpsLat = 0;
  double _gpsLon = 0;
  bool _gpsEnCours = true;
  bool _gpsOk = false;

  Map _principal() => (widget.fiche['kiosque_principal'] ?? {}) as Map;

  @override
  void initState() {
    super.initState();
    _tentativeGps();
  }

  @override
  void dispose() {
    _montantCtrl.dispose();
    super.dispose();
  }

  /// Capture automatique de la position (traçabilité §4.3) : lancée à
  /// l'ouverture de l'écran et rejouable via « Réessayer ».
  ///
  /// Correctifs :
  ///  * permission vérifiée UNE seule fois puis demandée si refusée, avec
  ///    re-vérification après la demande (certaines plateformes retournent
  ///    sans accorder la permission — sans ce contrôle, `getCurrentPosition`
  ///    partait quand même en échec) ;
  ///  * `LocationSettings.timeLimit` remplace `.timeout()` (le désistement
  ///    laissait le géolocaliseur actif en arrière-plan) et l'API dépréciée
  ///    `desiredAccuracy` ;
  ///  * garde `mounted` après chaque `await` : sans elle, l'écran fermé
  ///    pendant la recherche déclenchait `setState() called after dispose()`.
  Future<void> _tentativeGps() async {
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
          accuracy: LocationAccuracy.medium,
          // Délai de garde en intérieur : au-delà, pas de coordonnées — la
          // quittance exigera la confirmation explicite de l'agent.
          timeLimit: Duration(seconds: 6),
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
      // GPS indisponible (service coupé, permission refusée, aucun terminal) :
      // l'encaissement reste possible — mais sans coordonnées, la quittance
      // exige la confirmation explicite de l'agent (traçabilité section 4.3).
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
        content: Text(l.t('enc_gps_missing_body')),
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

  Future<void> _validate() async {
    final l = AppLocalizations.of(context);
    final montant = int.tryParse(_montantCtrl.text);
    if (montant == null || montant <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l.t('enc_amount_invalid'))),
      );
      return;
    }
    // Traçabilité (section 4.3) : sans coordonnées GPS, confirmation explicite.
    if (!_gpsOk) {
      final ok = await _confirmerSansGps();
      if (ok != true || !mounted) return;
    }
    final session = context.read<AuthCubit>().state.session;
    if (session == null) return;
    final principal = _principal();
    context.read<AgentCubit>().encaisser(
      codeKiosque: principal['code_kiosque']?.toString() ?? '',
      nomKiosque: principal['code_kiosque']?.toString() ?? '',
      proprietaireNom: principal['proprietaire_nom']?.toString() ?? '',
      montant: montant,
      natureTaxe: _nature,
      agentTelephone: session.telephone,
      sessionToken: session.sessionToken,
      gpsLat: _gpsLat,
      gpsLon: _gpsLon,
    );
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final principal = _principal();

    return Scaffold(
      appBar: AppBar(
        title: Text(l.t('encaisse')),
        actions: const [LanguageSwitchButton()],
      ),
      body: BlocConsumer<AgentCubit, agent_state.AgentState>(
        listenWhen: (prev, curr) =>
            curr.encaissementOk == true ||
            (curr.infoMessage != null && curr.infoMessage != prev.infoMessage),
        listener: (context, state) {
          if (state.encaissementOk == true && state.quittanceNumero != null) {
            // Confirmation + affichage de la quittance.
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => _ReceiptPage(
                  numeroQuittance: state.quittanceNumero!,
                  principal: principal,
                  montant: int.tryParse(_montantCtrl.text) ?? 0,
                  nature: _nature,
                ),
              ),
            );
          }
          // Encaissement mis en file hors-ligne : l'agent doit le savoir
          // (la quittance affichée est alors LOCALE, encore à synchroniser).
          if (state.infoMessage != null && mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.infoMessage!),
                backgroundColor: AppTheme.statutVert,
              ),
            );
            context.read<AgentCubit>().clearTransient();
          }
        },
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
                  title: Text(
                    principal['code_kiosque']?.toString() ?? '',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    '${principal['proprietaire_nom'] ?? ''}\n'
                    '${principal['fokontany'] ?? ''}',
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                l.t('tax_nature'),
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              RadioListTile<String>(
                dense: true,
                value: 'INSTALLATION',
                groupValue: _nature,
                title: Text(
                  l.t(
                    'enc_nature_installation',
                    args: [AppConfig.droitInstallationAriary],
                  ),
                ),
                onChanged: (v) => setState(() => _nature = v!),
              ),
              RadioListTile<String>(
                dense: true,
                value: 'RENOUVELLEMENT',
                groupValue: _nature,
                title: Text(
                  l.t(
                    'enc_nature_renewal',
                    args: [AppConfig.renouvellementAnnuelAriary],
                  ),
                ),
                onChanged: (v) => setState(() => _nature = v!),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _montantCtrl,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: InputDecoration(
                  labelText: l.t('enc_amount_label'),
                  prefixIcon: const Icon(Icons.payments),
                ),
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
                children: [
                  ActionChip(
                    label: const Text('150 000'),
                    onPressed: () =>
                        setState(() => _montantCtrl.text = '150000'),
                  ),
                  ActionChip(
                    label: const Text('120 000'),
                    onPressed: () =>
                        setState(() => _montantCtrl.text = '120000'),
                  ),
                  ActionChip(
                    label: Text('80 000 (${l.t('debt')})'),
                    onPressed: () =>
                        setState(() => _montantCtrl.text = '80000'),
                  ),
                ],
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
                  Text(
                    l.t(
                      'timestamp',
                      args: [
                        DateTime.now().toString().substring(0, 19),
                      ],
                    ),
                    style: const TextStyle(fontSize: 11, color: Colors.grey),
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
                          l.t('enc_gps_warning'),
                          style: const TextStyle(
                            fontSize: 11,
                            color: AppTheme.statutOrange,
                          ),
                        ),
                      ),
                      TextButton.icon(
                        onPressed: _tentativeGps,
                        icon: const Icon(Icons.refresh, size: 16),
                        label: Text(l.t('retry')),
                      ),
                    ],
                  ),
                ),
              const SizedBox(height: 12),
              ElevatedButton.icon(
                onPressed: state.loading ? null : _validate,
                icon: state.loading
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : const Icon(Icons.payments),
                label: Text(
                  state.loading
                      ? l.t('enc_recording')
                      : l.t('enc_validate'),
                ),
              ),
              if (state.error != null)
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Text(
                    state.error!,
                    style: const TextStyle(color: AppTheme.statutRouge),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}

/// Page de confirmation : quittance visuelle + impression Bluetooth.
class _ReceiptPage extends StatelessWidget {
  final String numeroQuittance;
  final Map principal;
  final int montant;
  final String nature;
  const _ReceiptPage({
    required this.numeroQuittance,
    required this.principal,
    required this.montant,
    required this.nature,
  });

  Future<void> _imprimer(BuildContext context) async {
    final session = context.read<AuthCubit>().state.session;
    final text = QuittanceRenderer.render(
      numeroQuittance: numeroQuittance,
      date: DateTime.now(),
      nomKiosque: principal['code_kiosque']?.toString() ?? '',
      proprietaire: principal['proprietaire_nom']?.toString() ?? '',
      montant: montant,
      natureTaxe: nature == 'INSTALLATION'
          ? "Droit d'installation"
          : 'Renouvellement annuel',
      codeKiosque: principal['code_kiosque']?.toString() ?? '',
      agentTelephone: session?.telephone ?? '',
      agentSession: session?.sessionToken ?? '',
    );

    final printer = BluetoothReceiptPrinter.instance;
    final available = await printer.isAvailable();
    final success = await printer.printText(text);

    if (context.mounted) {
      final l = AppLocalizations.of(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            available && success
                ? l.t('receipt_printed')
                : l.t('print_fallback'),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final session = context.read<AuthCubit>().state.session;
    final text = QuittanceRenderer.render(
      numeroQuittance: numeroQuittance,
      date: DateTime.now(),
      nomKiosque: principal['code_kiosque']?.toString() ?? '',
      proprietaire: principal['proprietaire_nom']?.toString() ?? '',
      montant: montant,
      natureTaxe: nature == 'INSTALLATION'
          ? "Droit d'installation"
          : 'Renouvellement annuel',
      codeKiosque: principal['code_kiosque']?.toString() ?? '',
      agentTelephone: session?.telephone ?? '',
      agentSession: session?.sessionToken ?? '',
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(l.t('receipt')),
        actions: const [LanguageSwitchButton()],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Center(
                child: Container(
                  width: 320,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.black),
                    boxShadow: const [
                      BoxShadow(blurRadius: 6, color: Colors.black26),
                    ],
                  ),
                  child: Text(
                    text,
                    style: const TextStyle(
                      fontSize: 11,
                      height: 1.4,
                      fontFamily: 'monospace',
                    ),
                  ),
                ),
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(Icons.close),
                        label: Text(l.t('close')),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: FilledButton.icon(
                        onPressed: () => _imprimer(context),
                        icon: const Icon(Icons.print),
                        label: Text(l.t('print')),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
