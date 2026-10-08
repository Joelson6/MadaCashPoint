import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../../../core/localization/app_localizations.dart';
import '../../../core/theme/app_theme.dart';
import '../../auth/bloc/auth_cubit.dart';
import '../../shared/widgets/shared_widgets.dart';
import '../bloc/agent_cubit.dart';
import '../qr_import.dart';
import 'agent_feedback.dart';
import 'kiosque_dashboard_screen.dart';

/// Lecture du QR Code de référence apposé sur le kiosque (section 6.1).
/// Transmet la référence au back-end : get_kiosque_by_qrcode(code).
///
/// Deux modes de saisie (§ 6.1) :
///  * **caméra en direct** (détection continue) ;
///  * **image de la galerie**, analysée par `analyzeImage` — même chaîne de
///    traitement qu'une détection live (`_traiterValeur`).
class ScannerScreen extends StatefulWidget {
  const ScannerScreen({super.key});

  @override
  State<ScannerScreen> createState() => _ScannerScreenState();
}

class _ScannerScreenState extends State<ScannerScreen> {
  final MobileScannerController _controller = MobileScannerController(
    detectionSpeed: DetectionSpeed.noDuplicates,
    formats: const [BarcodeFormat.qrCode],
  );

  bool _handling = false;
  String? _erreurCamera;

  @override
  void dispose() {
    // Le contrôleur ouvre un flux caméra : sans dispose(), il reste ouvert
    // après la sortie de l'écran (fuite + caméra allumée en arrière-plan).
    _controller.dispose();
    super.dispose();
  }

  /// Chemin unique de traitement d'une valeur QR (live ou image), avec
  /// gestion des erreurs et du retour caméra.
  Future<void> _traiterValeur(String brut) async {
    if (_handling) return;
    setState(() => _handling = true);

    // Le Cubit est résolu AVANT tout `await` : `context` ne doit pas être
    // utilisé après une frontière asynchrone (l'écran a pu être démonté).
    final cubit = context.read<AgentCubit>();
    final auth = context.read<AuthCubit>();
    final value = brut.trim();

    try {
      await _controller.stop();
      await cubit.loadKiosqueByQr(value);

      if (!mounted) return;

      final state = cubit.state;
      if (state.kiosqueInconnu) {
        // Kiosque non déclaré : proposer le signalement (section 6.5).
        await _proposerSignalement(context, cubit, auth, value);
        return;
      }

      if (cubit.state.fiche != null && mounted) {
        await Navigator.of(
          context,
        ).push(MaterialPageRoute(builder: (_) => const KiosqueDashboardScreen()));
      }
    } finally {
      if (mounted) {
        setState(() => _handling = false);
        // Reprend la lecture live (inutile après analyse d'image statique,
        // mais sans effet de bord : le contrôleur est déjà démarré).
        await _controller.start();
      }
    }
  }

  Future<void> _proposerSignalement(
    BuildContext context,
    AgentCubit cubit,
    AuthCubit auth,
    String value,
  ) async {
    final l = AppLocalizations.of(context);
    final answer = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        icon: const Icon(Icons.error, color: Colors.deepOrange),
        title: Text(l.t('scan_unknown_kiosk_title')),
        content: Text(l.t('scan_unknown_kiosk_body', args: [value])),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: Text(l.t('cancel')),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: Text(l.t('report_anomaly')),
          ),
        ],
      ),
    );
    if (answer == true) {
      final session = auth.state.session;
      if (session != null) {
        await cubit.signalerAnomalie(
          codeKiosque: value,
          type: 'NON_DECLARE',
          description: l.t('scan_qr_unassigned'),
          agentTelephone: session.telephone,
          sessionToken: session.sessionToken,
        );
      }
    }
  }

  /// Import d'une image de la galerie et lecture du QR qu'elle contient.
  Future<void> _importerImage() async {
    if (_handling) return;
    final l = AppLocalizations.of(context);
    final messenger = ScaffoldMessenger.of(context);
    final XFile? fichier = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 1920,
      imageQuality: 92,
    );
    if (fichier == null || !mounted) return;

    setState(() => _handling = true);
    BarcodeCapture? capture;
    try {
      capture = await _controller.analyzeImage(fichier.path);
    } catch (_) {
      capture = null;
    }
    if (!mounted) return;

    final resultat = interpreterCapture(capture);
    switch (resultat.statut) {
      case QrImportStatut.ok:
        setState(() => _handling = false);
        await _traiterValeur(resultat.valeur);
      case QrImportStatut.aucunQr:
        setState(() => _handling = false);
        messenger.showSnackBar(
          SnackBar(content: Text(l.t('scan_no_qr'))),
        );
      case QrImportStatut.plusieursQr:
        setState(() => _handling = false);
        messenger.showSnackBar(
          SnackBar(content: Text(l.t('scan_multiple_qr'))),
        );
      case QrImportStatut.erreurLecture:
        setState(() => _handling = false);
        messenger.showSnackBar(
          SnackBar(
            content: Text(l.t('scan_read_error')),
            backgroundColor: Colors.red.shade700,
          ),
        );
    }
  }

  Future<void> _onDetect(BarcodeCapture capture) async {
    final value = capture.barcodes.isEmpty
        ? null
        : capture.barcodes.first.rawValue;
    if (value == null || value.isEmpty) return;
    await _traiterValeur(value);
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(l.t('scan_kiosque')),
        actions: [
          const LanguageSwitchButton(),
          IconButton(
            icon: const Icon(Icons.image),
            tooltip: l.t('scan_import'),
            onPressed: _handling ? null : _importerImage,
          ),
        ],
      ),
      body: BlocListener<AgentCubit, AgentState>(
        listenWhen: agentEcouteMessages,
        listener: agentAfficherMessages,
        child: Stack(
        children: [
          // La vue caméra reste montée MÊME derrière l'overlay d'erreur :
          // retirer le widget du contrôleur rendrait l'impossible (le
          // contrôleur serait détaché et « Réessayer » échouerait).
          MobileScanner(
            controller: _controller,
            onDetect: _onDetect,
            errorBuilder: (context, error) {
              if (_erreurCamera == null) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  if (mounted && _erreurCamera == null) {
                    setState(
                      () => _erreurCamera = switch (error.errorCode) {
                        MobileScannerErrorCode.permissionDenied =>
                          l.t('scan_permission_denied'),
                        MobileScannerErrorCode.unsupported =>
                          l.t('scan_unsupported'),
                        _ => '${l.t('scan_camera_error')} (${error.errorCode.message})',
                      },
                    );
                  }
                });
              }
              return const SizedBox.shrink();
            },
          ),
          if (_erreurCamera != null)
            Container(
              color: Theme.of(context).scaffoldBackgroundColor,
              alignment: Alignment.center,
              child: _ErreurCamera(
                message: _erreurCamera!,
                onRetry: () async {
                  setState(() => _erreurCamera = null);
                  try {
                    await _controller.start();
                  } on MobileScannerException catch (e) {
                    if (mounted) {
                      setState(() => _erreurCamera = e.errorCode.message);
                    }
                  }
                },
              ),
            ),
          // Zone de visée
          if (_erreurCamera == null)
            Center(
              child: Container(
                width: 250,
                height: 250,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 3),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: const Icon(
                  Icons.qr_code,
                  color: Colors.white38,
                  size: 120,
                ),
              ),
            ),
          if (_erreurCamera == null)
            Positioned(
              bottom: 40,
              left: 24,
              right: 24,
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Text(
                    l.t('scan_hint'),
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 13),
                  ),
                ),
              ),
            ),
          if (_handling)
            Container(
              color: Colors.black54,
              alignment: Alignment.center,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const CircularProgressIndicator(color: Colors.white),
                  const SizedBox(height: 14),
                  Text(
                    l.t('scan_processing'),
                    style: const TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
        ],
        ),
      ),
    );
  }
}

class _ErreurCamera extends StatelessWidget {
  const _ErreurCamera({required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.no_photography, color: Colors.grey, size: 64),
            const SizedBox(height: 16),
            Text(message, textAlign: TextAlign.center),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh),
              label: Text(l.t('retry')),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primaryNavy,
                foregroundColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
