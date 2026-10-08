import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../core/di/service_locator.dart';
import '../../../core/localization/app_localizations.dart';
import '../../../core/security/auto_lock.dart';
import '../../../core/theme/app_theme.dart';
import '../../../data/remote/kiosque_mapper.dart';

/// Carte de statut d'un kiosque (bannière d'état visuelle, section 6.2).
class StatusBanner extends StatelessWidget {
  final StatutFiscalCouleur couleur;
  final Map<String, dynamic>? situationFiscale;
  const StatusBanner({super.key, required this.couleur, this.situationFiscale});

  Color _color() => switch (couleur) {
    StatutFiscalCouleur.vert => AppTheme.statutVert,
    StatutFiscalCouleur.orange => AppTheme.statutOrange,
    StatutFiscalCouleur.rouge => AppTheme.statutRouge,
  };

  IconData _icon() => switch (couleur) {
    StatutFiscalCouleur.vert => Icons.check_circle,
    StatutFiscalCouleur.orange => Icons.warning_amber_rounded,
    StatutFiscalCouleur.rouge => Icons.error,
  };

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final color = _color();
    final label = switch (couleur) {
      StatutFiscalCouleur.vert => l.t('statut_vert'),
      StatutFiscalCouleur.orange => l.t('statut_orange'),
      StatutFiscalCouleur.rouge => l.t('statut_rouge'),
    };
    final dette = intOf(situationFiscale ?? {}, 'total_dette_ariary');

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Icon(_icon(), color: Colors.white, size: 34),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (couleur == StatutFiscalCouleur.rouge)
                  Text(
                    '${l.t('debt')} : ${_ariary(dette)}',
                    style: const TextStyle(color: Colors.white, fontSize: 13),
                  ),
                if (couleur == StatutFiscalCouleur.orange)
                  const Text(
                    '150 000 Ar',
                    style: TextStyle(color: Colors.white, fontSize: 13),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _ariary(int n) {
    final s = n.toString();
    final r = StringBuffer();
    for (var i = 0; i < s.length; i++) {
      r.write(s[s.length - 1 - i]);
      if (i > 0 && (i + 1) % 3 == 0 && s.length - 1 - i != 0) r.write(' ');
    }
    return '${r.toString().split('').reversed.join()} Ar';
  }
}

/// Carte compacte d'un kiosque voisin (navigation par rebond, section 6.3).
class NeighbourCard extends StatelessWidget {
  final Map<String, dynamic> voisin;
  final VoidCallback onTap;
  const NeighbourCard({super.key, required this.voisin, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final couleur = voisin['couleur_statut_fiscal']?.toString() ?? 'rouge';
    final color = AppTheme.statusColor(couleur.toUpperCase());
    final code = voisin['code_kiosque']?.toString() ?? '';
    final distance = voisin['distance_estimee_metres'] is num
        ? '${((voisin['distance_estimee_metres'] as num).toDouble()).toStringAsFixed(0)} m'
        : (voisin['distance_estimee_metres']?.toString() ?? '?');

    return SizedBox(
      width: 190,
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
        child: InkWell(
          borderRadius: BorderRadius.circular(14),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        color: color,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        code,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  voisin['proprietaire_nom']?.toString() ?? '',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 13),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.near_me, size: 14, color: Colors.grey),
                    const SizedBox(width: 4),
                    Text(
                      distance,
                      style: const TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                  ],
                ),
                Text(
                  '${voisin['montant_dette_ariary'] ?? 0} Ar',
                  style: TextStyle(
                    color: color,
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// En-tête de section réutilisable.
class SectionTitle extends StatelessWidget {
  final String title;
  final IconData? icon;
  const SectionTitle(this.title, {super.key, this.icon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Row(
        children: [
          if (icon != null) ...[
            Icon(icon, size: 18, color: AppTheme.primaryNavy),
            const SizedBox(width: 6),
          ],
          Expanded(
            child: Text(
              title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}

/// Ligne clé/valeur d'une fiche technique.
class InfoRow extends StatelessWidget {
  final String label;
  final String value;
  const InfoRow(this.label, this.value, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 130,
            child: Text(
              label,
              style: const TextStyle(color: Colors.grey, fontSize: 13),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }
}

/// Carte de menu principale (accueil citoyen/agent).
class MenuCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final VoidCallback onTap;
  final Color? color;
  const MenuCard({
    super.key,
    required this.icon,
    required this.title,
    this.subtitle,
    required this.onTap,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: color ?? AppTheme.primaryNavy,
          child: Icon(icon, color: Colors.white),
        ),
        title: Text(
          title,
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
        ),
        subtitle: subtitle == null
            ? null
            : Text(subtitle!, style: const TextStyle(fontSize: 12)),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
}

/// Bouton de bascule de langue (FR / MG) — section 9.
///
/// Pilule arrondie (icône traduire + libellé de la langue CIBLE), visible sur
/// chacune des AppBar de l'application : le fond clair/thème s'adapte via
/// `Theme.of(context)`.
class LanguageSwitchButton extends StatelessWidget {
  const LanguageSwitchButton({super.key});

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final scheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.only(right: 4),
      child: Tooltip(
        message: l.t('language'),
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: () {
            final sl = ServiceLocator.instance;
            final next = l.isMg ? const Locale('fr') : const Locale('mg');
            sl.localeController.value = next;
            sl.secureStore.setLanguage(next.languageCode);
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              border: Border.all(color: scheme.outlineVariant),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.translate, size: 14, color: scheme.primary),
                const SizedBox(width: 4),
                Text(
                  l.isMg ? 'FR' : 'MG',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                    color: scheme.primary,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Couche d'activité : réinitialise le verrouillage auto (section 4.3).
class ActivityListener extends StatelessWidget {
  final Widget child;
  const ActivityListener({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: (_) => AutoLockService.instance.recordActivity(),
      child: child,
    );
  }
}

/// Champ de pièce jointe photo : capture caméra, import galerie et
/// suppression explicite (section 5.2 du cahier des charges).
///
/// Le touch ouvre un menu des actions disponibles plutôt que de déclencher
/// directement la caméra : l'utilisateur garde le choix entre photographier
/// et importer un document déjà présent dans le téléphone.
class PhotoCaptureField extends StatelessWidget {
  final String label;
  final VoidCallback onCapture;
  final VoidCallback? onImport;
  final VoidCallback? onDelete;
  final String? path;
  const PhotoCaptureField({
    super.key,
    required this.label,
    required this.onCapture,
    this.onImport,
    this.onDelete,
    this.path,
  });

  bool get _hasPhoto => path != null && path!.isNotEmpty;

  void _openMenu(BuildContext context) {
    final l = AppLocalizations.of(context);
    showModalBottomSheet<void>(
      context: context,
      builder: (ctx) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.photo_camera),
              title: Text(l.t('take_photo')),
              onTap: () {
                Navigator.of(ctx).pop();
                onCapture();
              },
            ),
            if (onImport != null)
              ListTile(
                leading: const Icon(Icons.photo_library_outlined),
                title: Text(l.t('import_gallery')),
                onTap: () {
                  Navigator.of(ctx).pop();
                  onImport!();
                },
              ),
            if (_hasPhoto && onDelete != null)
              ListTile(
                leading: const Icon(Icons.delete_outline, color: Colors.red),
                title: Text(
                  l.t('photo_delete'),
                  style: const TextStyle(color: Colors.red),
                ),
                onTap: () {
                  Navigator.of(ctx).pop();
                  onDelete!();
                },
              ),
            ListTile(
              leading: const Icon(Icons.close),
              title: Text(l.t('cancel')),
              onTap: () => Navigator.of(ctx).pop(),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _openMenu(context),
      borderRadius: BorderRadius.circular(12),
      child: Container(
        height: 130,
        decoration: BoxDecoration(
          color: !_hasPhoto ? AppTheme.surfaceLight : null,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade300),
          image: !_hasPhoto
              ? null
              : DecorationImage(
                  image: kIsWeb ? NetworkImage(path!) : FileImage(File(path!)),
                  fit: BoxFit.cover,
                ),
        ),
        child: !_hasPhoto
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(_icon(label), size: 34, color: Colors.grey.shade500),
                  const SizedBox(height: 6),
                  Text(label, style: const TextStyle(fontSize: 13)),
                  Text(
                    AppLocalizations.of(context).t('photo_tap_hint'),
                    style: const TextStyle(fontSize: 10, color: Colors.grey),
                  ),
                ],
              )
            : Stack(
                children: [
                  Positioned(
                    top: 6,
                    right: 6,
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Colors.black54,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(
                        Icons.edit,
                        color: Colors.white,
                        size: 15,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 8,
                    right: 8,
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: Colors.black54,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(
                        Icons.check_circle,
                        color: AppTheme.statutVert,
                        size: 18,
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  IconData _icon(String label) => label.toLowerCase().contains('recto')
      ? Icons.badge
      : label.toLowerCase().contains('verso')
      ? Icons.badge_outlined
      : Icons.photo_camera;
}

/// État d'échec de chargement (message + action « Réessayer »).
///
/// Factorisé pour uniformiser les écrans agent (dossiers, redevables…) :
/// un même squelette évite la duplication des widgets privés `_Erreur`.
class EtatErreur extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;
  const EtatErreur({super.key, required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.cloud_off, color: Colors.grey, size: 64),
            const SizedBox(height: 16),
            Text(message, textAlign: TextAlign.center),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh),
              label: Text(l.t('retry')),
            ),
          ],
        ),
      ),
    );
  }
}

/// État vide (aucune donnée à afficher), avec action de rafraîchissement
/// optionnelle. Factorisé pour remplacer les `_Vide` dupliqués.
class EtatVide extends StatelessWidget {
  final String message;
  final VoidCallback? onRefresh;
  final IconData icon;
  const EtatVide({
    super.key,
    required this.message,
    this.onRefresh,
    this.icon = Icons.inbox_outlined,
  });

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final contenu = Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: Colors.grey, size: 64),
        const SizedBox(height: 12),
        Text(message, textAlign: TextAlign.center),
        if (onRefresh != null) ...[
          const SizedBox(height: 16),
          OutlinedButton.icon(
            onPressed: onRefresh,
            icon: const Icon(Icons.refresh),
            label: Text(l.t('retry')),
          ),
        ],
      ],
    );
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: contenu,
      ),
    );
  }
}
