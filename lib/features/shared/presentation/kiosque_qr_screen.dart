import 'dart:ui' as ui;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../../core/localization/app_localizations.dart';
import '../../../core/security/auto_lock.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/utils/qr_file_export.dart';
import '../../../data/models/kiosque.dart';
import '../../../data/remote/kiosque_mapper.dart';
import '../widgets/shared_widgets.dart';

/// Générateur / visuel du code QR de référence d'un kiosque (section 6.1).
///
/// Chaque kiosque du cache possède un QR encodant son `code_kiosque`
/// (ex. "1S008") : scanné avec le Scanner agent, il retombe exactement sur la
/// même fiche via `get_kiosque_by_qrcode`. L'écran présente l'autocollant
/// officiel CUF et permet son export PNG haute résolution (3x) :
///  - copie locale `documents/CUF_QR` (offline) ;
///  - copie vers `Download/CUF` (MediaStore) sur Android.
///
/// Partagé entre l'espace **agent** (accueil, fiche kiosque) et l'espace
/// **demandeur** (suivi du dossier liant un kiosque).
class KiosqueQrScreen extends StatefulWidget {
  final String codeKiosque;
  final String proprietaire;
  final String fokontany;
  final String autorisation;
  final String statutDroit; // PAYE | EN_ATTENTE
  final String statutTaxe; // A_JOUR | REDEVABLE
  final int totalDette;

  const KiosqueQrScreen({
    super.key,
    required this.codeKiosque,
    required this.proprietaire,
    required this.fokontany,
    required this.autorisation,
    required this.statutDroit,
    required this.statutTaxe,
    this.totalDette = 0,
  });

  /// Construit l'écran à partir de la fiche JSON (tableau de bord agent)
  /// + du kiosque local éventuel (plus riche).
  factory KiosqueQrScreen.fromFiche(
    Map<String, dynamic> fiche,
    Kiosque? local,
  ) {
    final principal = (fiche['kiosque_principal'] ?? {}) as Map;
    return KiosqueQrScreen(
      codeKiosque: principal['code_kiosque']?.toString() ?? '',
      proprietaire: principal['proprietaire_nom']?.toString() ?? '',
      fokontany: principal['fokontany']?.toString() ?? '',
      autorisation: principal['autorisation_numero']?.toString() ?? '',
      statutDroit: principal['situation_fiscale'] is Map
          ? (principal['situation_fiscale']['statut_droit_installation']
                    ?.toString() ??
                'EN_ATTENTE')
          : (local?.statutDroitInstallation ?? 'EN_ATTENTE'),
      statutTaxe: principal['situation_fiscale'] is Map
          ? (principal['situation_fiscale']['statut_taxe_mensuelle']
                    ?.toString() ??
                'REDEVABLE')
          : (local?.statutTaxeMensuelle ?? 'REDEVABLE'),
      totalDette:
          local?.totalDetteAriary ??
          (principal['situation_fiscale'] is Map
              ? intOf(
                  Map<String, dynamic>.from(
                    principal['situation_fiscale'] as Map,
                  ),
                  'total_dette_ariary',
                )
              : 0),
    );
  }

  /// Construit l'écran à partir d'un kiosque du cache local (accueil agent).
  factory KiosqueQrScreen.fromLocal(Kiosque k) {
    return KiosqueQrScreen(
      codeKiosque: k.codeKiosque,
      proprietaire: k.proprietaireNom,
      fokontany: k.fokontany,
      autorisation: k.autorisationNumero,
      statutDroit: k.statutDroitInstallation,
      statutTaxe: k.statutTaxeMensuelle,
      totalDette: k.totalDetteAriary,
    );
  }

  /// Construit l'écran depuis une ligne de `get_mes_dossiers` (espace
  /// demandeur) : le dossier lié porte `code_kiosque` lorsque le kiosque
  /// est déjà créé (demande approuvée / levier en place).
  factory KiosqueQrScreen.fromDossier(Map<String, dynamic> d) {
    return KiosqueQrScreen(
      codeKiosque: d['code_kiosque']?.toString() ?? '',
      proprietaire: d['nom_commercial']?.toString() ??
          d['nom_prenoms']?.toString() ??
          '',
      fokontany: d['fokontany']?.toString() ?? '',
      autorisation: d['autorisation_numero']?.toString() ?? '',
      statutDroit: d['statut_droit_installation']?.toString() ?? 'EN_ATTENTE',
      statutTaxe: d['statut_taxe_mensuelle']?.toString() ?? 'REDEVABLE',
      totalDette: (d['total_dette_ariary'] as num?)?.toInt() ?? 0,
    );
  }

  @override
  State<KiosqueQrScreen> createState() => _KiosqueQrScreenState();
}

class _KiosqueQrScreenState extends State<KiosqueQrScreen> {
  final GlobalKey _autocollantKey = GlobalKey();
  bool _saving = false;

  StatutFiscalCouleur get _couleur {
    if (widget.statutDroit == 'EN_ATTENTE') return StatutFiscalCouleur.orange;
    if (widget.statutTaxe == 'REDEVABLE') return StatutFiscalCouleur.rouge;
    return StatutFiscalCouleur.vert;
  }

  Color get _couleurC => switch (_couleur) {
    StatutFiscalCouleur.vert => AppTheme.statutVert,
    StatutFiscalCouleur.orange => AppTheme.statutOrange,
    StatutFiscalCouleur.rouge => AppTheme.statutRouge,
  };

  String _label(AppLocalizations l) => switch (_couleur) {
    StatutFiscalCouleur.vert => l.t('statut_vert'),
    StatutFiscalCouleur.orange => l.t('statut_orange'),
    StatutFiscalCouleur.rouge => l.t('statut_rouge'),
  };

  /// Export PNG (3x) : copie locale + copie `Download/CUF` (Android).
  /// Sur le web (kIsWeb), l'enregistrement fichier est désactivé.
  Future<void> _sauvegarder() async {
    if (kIsWeb || _saving) return;
    setState(() => _saving = true);
    try {
      final boundary =
          _autocollantKey.currentContext?.findRenderObject()
              as RenderRepaintBoundary?;
      if (boundary == null) return;
      final image = await boundary.toImage(pixelRatio: 3.0);
      final bytes = await image.toByteData(format: ui.ImageByteFormat.png);
      image.dispose();
      if (bytes == null || !mounted) return;

      final chemin = await saveQrPng(
        bytes.buffer.asUint8List(),
        'QR_KIOSQUE_${widget.codeKiosque}.png',
      );

      if (!mounted) return;
      final l = AppLocalizations.of(context);
      if (chemin == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(l.t('qr_web_hint')),
            backgroundColor: AppTheme.statutOrange,
          ),
        );
        return;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${l.t('qr_saved')}\n$chemin'),
          duration: const Duration(seconds: 4),
          backgroundColor: AppTheme.statutVert,
        ),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context).t('qr_export_error', args: [e])),
          backgroundColor: AppTheme.statutRouge,
        ),
      );
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    return AutoLockScaffold(
      title: l.t('kiosque_qr'),
      actions: const [LanguageSwitchButton()],
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // --- Autocollant officiel (capturé pour l'export PNG) ---
          Center(
            child: RepaintBoundary(
              key: _autocollantKey,
              child: Container(
                width: 300,
                padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppTheme.primaryNavy, width: 2),
                  boxShadow: const [
                    BoxShadow(blurRadius: 10, color: Colors.black26),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      l.t('kodiac'),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.primaryNavy,
                      ),
                    ),
                    Text(
                      l.t('qr_title_line'),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 9,
                        color: Colors.black54,
                        letterSpacing: 1,
                      ),
                    ),
                    const SizedBox(height: 10),
                    QrImageView(
                      data: widget.codeKiosque,
                      version: QrVersions.auto,
                      size: 224,
                      gapless: true,
                      errorCorrectionLevel: QrErrorCorrectLevel.M,
                      dataModuleStyle: const QrDataModuleStyle(
                        dataModuleShape: QrDataModuleShape.square,
                        color: Color(0xFF000000),
                      ),
                      eyeStyle: QrEyeStyle(
                        eyeShape: QrEyeShape.square,
                        color: AppTheme.primaryNavy,
                      ),
                      backgroundColor: Colors.white,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      widget.codeKiosque,
                      style: const TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 4,
                        fontFamily: 'monospace',
                        color: AppTheme.primaryNavy,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      l.t('qr_kioske_line'),
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.grey.shade700,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),

          // --- Statut fiscal du kiosque ---
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: _couleurC.withValues(alpha: 0.10),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: _couleurC),
            ),
            child: Row(
              children: [
                Icon(
                  switch (_couleur) {
                    StatutFiscalCouleur.vert => Icons.check_circle,
                    StatutFiscalCouleur.orange => Icons.warning_amber_rounded,
                    StatutFiscalCouleur.rouge => Icons.error,
                  },
                  color: _couleurC,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    _label(l),
                    style: TextStyle(
                      color: _couleurC,
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                ),
                if (_couleur == StatutFiscalCouleur.rouge &&
                    widget.totalDette > 0)
                  Text(
                    '${widget.totalDette} Ar',
                    style: TextStyle(
                      color: _couleurC,
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 10),

          // --- Fiche d'identité du QR ---
          Card(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                children: [
                  _LigneQR(l.t('owner'), widget.proprietaire),
                  _LigneQR(l.t('fokontany_list'), widget.fokontany),
                  _LigneQR(l.t('authorization'), widget.autorisation),
                  _LigneQR('QR', l.t('qr_scannable')),
                ],
              ),
            ),
          ),
          const SizedBox(height: 14),

          // --- Actions ---
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close),
                  label: Text(l.t('cancel')),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: FilledButton.icon(
                  onPressed: kIsWeb ? null : (_saving ? null : _sauvegarder),
                  icon: _saving
                      ? const SizedBox(
                          height: 18,
                          width: 18,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : const Icon(Icons.save_alt),
                  label: Text(l.t('qr_save')),
                ),
              ),
            ],
          ),
          if (kIsWeb) ...[
            const SizedBox(height: 10),
            Text(
              l.t('qr_web_hint'),
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ],
      ),
    );
  }
}

class _LigneQR extends StatelessWidget {
  final String k;
  final String v;
  const _LigneQR(this.k, this.v);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 110,
            child: Text(
              k,
              style: const TextStyle(fontSize: 13, color: Colors.grey),
            ),
          ),
          Expanded(
            child: Text(
              v,
              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }
}
