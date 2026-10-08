import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/config/app_config.dart';
import '../../../core/localization/app_localizations.dart';
import '../../../core/security/auto_lock.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/utils/formatters.dart';
import '../../shared/widgets/shared_widgets.dart';
import '../../auth/bloc/auth_cubit.dart';
import '../bloc/agent_cubit.dart';
import '../bloc/agent_cubit.dart' as agent_state;

/// Décision de l'agent communal sur un dossier (section 4.4) : lecture
/// complète du dossier puis approbation / demandes de corrections / rejet.
///
/// L'approbation fait naître la fiche kiosque côté serveur (kiosque
/// scannable, droit d'installation exigible) — l'écran l'affiche dès qu'elle
/// existe.
class DossierDetailScreen extends StatefulWidget {
  const DossierDetailScreen({super.key, required this.codeDossier});
  final String codeDossier;

  @override
  State<DossierDetailScreen> createState() => _DossierDetailScreenState();
}

class _DossierDetailScreenState extends State<DossierDetailScreen> {
  final _noteCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Ouverture directe (lien, restauration) : la liste d'instruction n'est
    // pas encore chargée — charger avant d'afficher « introuvable ».
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      final cubit = context.read<AgentCubit>();
      if (_trouver(cubit.state.dossiers, widget.codeDossier) == null) {
        cubit.loadDossiers();
      }
    });
  }

  @override
  void dispose() {
    _noteCtrl.dispose();
    super.dispose();
  }

  static Map<String, dynamic>? _trouver(
    List<Map<String, dynamic>> dossiers,
    String code,
  ) {
    for (final d in dossiers) {
      if (d['code_dossier']?.toString() == code) return d;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    return BlocConsumer<AgentCubit, agent_state.AgentState>(
      listenWhen: (_, c) =>
          c.decisionMessage != null || c.decisionError != null,
      listener: (context, state) {
        final cubit = context.read<AgentCubit>();
        if (state.decisionMessage != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.decisionMessage!),
              backgroundColor: AppTheme.statutVert,
            ),
          );
        }
        if (state.decisionError != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.decisionError!),
              backgroundColor: Colors.red.shade700,
            ),
          );
        }
        cubit.clearDecisionMessage();
      },
      builder: (context, state) {
        final dossier = _trouver(state.dossiers, widget.codeDossier);
return AutoLockScaffold(
          title: l.t('dossier_decision'),
          actions: const [LanguageSwitchButton()],
          child: dossier == null
              ? (state.loadingDossiers
                    ? const Center(child: CircularProgressIndicator())
                    : _Introuvable(onRetry: state.loadingDossiers
                        ? null
                        : context.read<AgentCubit>().loadDossiers))
              : _Contenu(
                  d: dossier,
                  loading: state.loading,
                  onApprouver: _confirmerApprobation,
                  onCorrections: () => _saisirNote(
                    decision: 'EN_COURS_INSTRUCTION',
                    titre: l.t('decision_corrections_title'),
                    aide: l.t('decision_corrections_hint'),
                  ),
                  onRejeter: () => _saisirNote(
                    decision: 'REJETE',
                    titre: l.t('decision_reject_title'),
                    aide: l.t('decision_reject_hint'),
                  ),
                ),
        );
      },
    );
  }

  /// Émission de la décision (le cubit recharge la liste derrière).
  Future<void> _decider(String decision, String note) async {
    final session = context.read<AuthCubit>().state.session;
    await context.read<AgentCubit>().deciderDossier(
      codeDossier: widget.codeDossier,
      decision: decision,
      note: note,
      agentTelephone: session?.telephone ?? '',
      sessionToken: session?.sessionToken ?? '',
    );
  }

  // -------------------------------------------------------------------------
  // Boîtes de dialogue de décision
  // -------------------------------------------------------------------------

  Future<void> _confirmerApprobation() async {
    final l = AppLocalizations.of(context);
    final ok = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l.t('decision_approve_title')),
        content: Text(
          '${widget.codeDossier}\n\n${l.t('decision_approve_body')}',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(l.t('cancel')),
          ),
          FilledButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: FilledButton.styleFrom(
              backgroundColor: AppTheme.statutVert,
            ),
            child: Text(l.t('decision_approve')),
          ),
        ],
      ),
    );
    if (ok == true) await _decider('APPROUVE', '');
  }

  Future<void> _saisirNote({
    required String decision,
    required String titre,
    required String aide,
  }) async {
    final l = AppLocalizations.of(context);
    _noteCtrl.clear();
    final valide = await showDialog<bool>(
      context: context,
      builder: (context) {
        var erreur = false;
        return StatefulBuilder(
          builder: (context, setState) => AlertDialog(
            title: Text(titre),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.codeDossier),
                const SizedBox(height: 12),
                TextField(
                  controller: _noteCtrl,
                  autofocus: true,
                  minLines: 3,
                  maxLines: 6,
                  maxLength: 250,
                  decoration: InputDecoration(
                    labelText: l.t('label_note'),
                    hintText: aide,
                    border: const OutlineInputBorder(),
                    errorText: erreur ? l.t('decision_note_required') : null,
                  ),
                  onChanged: (_) {
                    if (erreur) setState(() => erreur = false);
                  },
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text(l.t('cancel')),
              ),
              FilledButton(
                onPressed: () {
                  if (_noteCtrl.text.trim().isEmpty) {
                    setState(() => erreur = true);
                    return;
                  }
                  Navigator.of(context).pop(true);
                },
                child: Text(l.t('confirm')),
              ),
            ],
          ),
        );
      },
    );
    if (valide == true) {
      await _decider(decision, _noteCtrl.text.trim());
    }
  }
}

/// Contenu : récapitulatif, pièces, puis les trois décisions.
class _Contenu extends StatelessWidget {
  final Map<String, dynamic> d;
  final bool loading;
  final VoidCallback onApprouver;
  final VoidCallback onCorrections;
  final VoidCallback onRejeter;
  const _Contenu({
    required this.d,
    required this.loading,
    required this.onApprouver,
    required this.onCorrections,
    required this.onRejeter,
  });

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final statut = d['statut']?.toString() ?? 'EN_COURS_INSTRUCTION';
    final (couleur, libelle) = switch (statut) {
      'APPROUVE' => (AppTheme.statutVert, l.t('status_approved')),
      'REJETE' => (AppTheme.statutRouge, l.t('status_rejected')),
      _ => (AppTheme.statutOrange, l.t('status_en_cours')),
    };
    final note = (d['note_rejet'] ?? '').toString();
    final pieces = (d['pieces_jointes'] as List?) ?? const [];
    final operateurs = (d['operateurs'] as List?) ?? const [];
    final materiaux = (d['materiaux_construction'] ?? '').toString();
    final statutDroit =
        d['statut_droit_installation']?.toString() ?? 'EN_ATTENTE';
    final codeKiosque = (d['code_kiosque'] ?? '').toString();
    final autorisation = (d['autorisation_numero'] ?? '').toString();

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // --- En-tête : dossier + statut + note de décision ---
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: couleur.withValues(alpha: 0.10),
            border: Border.all(color: couleur.withValues(alpha: 0.4)),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.description, color: couleur),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      d['code_dossier']?.toString() ?? '—',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: couleur,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      libelle,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Text(
                '${l.t('label_date_soumission')} : '
                '${d['date_soumission']?.toString() ?? '—'}',
                style: const TextStyle(fontSize: 12, color: Colors.black54),
              ),
              if (note.isNotEmpty) ...[
                const SizedBox(height: 8),
                Text(
                  '${l.t('label_note')} : $note',
                  style: TextStyle(
                    fontSize: 13,
                    color: couleur,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ],
          ),
        ),
        const SizedBox(height: 12),
        if (loading) ...[
          const LinearProgressIndicator(minHeight: 3),
          const SizedBox(height: 12),
        ],

        // --- Demandeur (étape 1) ---
        _Section(
          titre: l.t('step1'),
          lignes: [
            _ligne(l.t('label_nom_prenoms'), d['nom_prenoms']),
            _ligne(l.t('phone_label'), d['telephone']),
            _ligne(l.t('cin_label'), d['cin']),
            // Champs d'état civil : le back-end distant ne les expose pas —
            // on l'annonce explicitement plutôt que d'afficher un vide.
            _ligne(
              l.t('cin_date_label'),
              d.containsKey('cin_date')
                  ? d['cin_date']
                  : l.t('non_disponible_backend'),
            ),
            _ligne(
              l.t('cin_lieu_label'),
              d.containsKey('cin_lieu')
                  ? d['cin_lieu']
                  : l.t('non_disponible_backend'),
            ),
            _ligne(
              l.t('label_date_creation'),
              d.containsKey('date_creation')
                  ? d['date_creation']
                  : l.t('non_disponible_backend'),
            ),
            _ligne(l.t('quartier_label'), d['quartier']),
            _ligne(l.t('fokontany_label'), d['fokontany']),
            _ligne(l.t('commercial_name'), d['nom_commercial']),
            _ligne(l.t('id_type'), d['type_identification']),
          ],
        ),

        // --- Kiosque (étape 2) ---
        _Section(
          titre: l.t('step2'),
          lignes: [
            _ligne(
              l.t('operators_label'),
              operateurs.join(', '),
            ),
            _ligne(l.t('materials_label'), materiaux),
            _ligne(
              l.t('length_label'),
              '${d['kiosque_longueur'] ?? '—'}',
            ),
            _ligne(
              l.t('width_label'),
              '${d['kiosque_largeur'] ?? '—'}',
            ),
            _ligne(l.t('location_hint'), d['emplacement_repere']),
          ],
        ),

        // --- Implantation (étape 3) ---
        _Section(
          titre: l.t('step3'),
          lignes: [
            _ligne(
              l.t('gps'),
              '${d['gps_latitude'] ?? '—'}, ${d['gps_longitude'] ?? '—'}',
            ),
            _ligne(l.t('label_georestriction'), d['georestriction_resultat']),
            _ligne(
              l.t('pieces_jointes'),
              pieces.isEmpty ? '—' : pieces.join(', '),
            ),
          ],
        ),

        // --- Pièces numériques (photos) avec visionneur zoom ---
        _PhotosDossier(d: d),

        // --- Droit d'installation / kiosque créé ---
        _Section(
          titre: l.t('droit_install'),
          lignes: [
            _ligne(
              l.t('label_droit_montant'),
              Formatters.ariary(
                d['montant_droit_installation'] ??
                    AppConfig.droitInstallationAriary,
              ),
            ),
            _ligne(
              l.t('label_statut_droit'),
              statutDroit == 'PAYE'
                  ? l.t('payments_status_paid')
                  : l.t('payments_status_due'),
            ),
            if (codeKiosque.isNotEmpty)
              _ligne(l.t('label_kiosque_code'), codeKiosque),
            if (autorisation.isNotEmpty)
              _ligne(l.t('label_autorisation'), autorisation),
          ],
        ),

        const SizedBox(height: 8),

        // --- Décisions (§ 4.4) ---
        FilledButton.icon(
          onPressed: loading ? null : onApprouver,
          style: FilledButton.styleFrom(
            backgroundColor: AppTheme.statutVert,
            padding: const EdgeInsets.symmetric(vertical: 14),
          ),
          icon: const Icon(Icons.check_circle_outline),
          label: Text(
            l.t('decision_approve'),
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 8),
        OutlinedButton.icon(
          onPressed: loading ? null : onCorrections,
          style: OutlinedButton.styleFrom(
            foregroundColor: AppTheme.statutOrange,
            side: const BorderSide(color: AppTheme.statutOrange),
            padding: const EdgeInsets.symmetric(vertical: 14),
          ),
          icon: const Icon(Icons.edit_note),
          label: Text(l.t('decision_corrections')),
        ),
        const SizedBox(height: 8),
        OutlinedButton.icon(
          onPressed: loading ? null : onRejeter,
          style: OutlinedButton.styleFrom(
            foregroundColor: AppTheme.statutRouge,
            side: const BorderSide(color: AppTheme.statutRouge),
            padding: const EdgeInsets.symmetric(vertical: 14),
          ),
          icon: const Icon(Icons.block),
          label: Text(l.t('decision_reject')),
        ),
        const SizedBox(height: 40),
      ],
    );
  }

  static String _ligne(String k, Object? v) => '$k|||${v ?? '—'}';
}

/// Bloc de présentation d'un ensemble de champs (libellé ||| valeur).
class _Section extends StatelessWidget {
  final String titre;
  final List<String> lignes;
  const _Section({required this.titre, required this.lignes});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              titre,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: AppTheme.primaryNavy,
              ),
            ),
            const Divider(height: 16),
            for (final ligne in lignes) _Champ(ligne: ligne),
          ],
        ),
      ),
    );
  }
}

class _Champ extends StatelessWidget {
  final String ligne;
  const _Champ({required this.ligne});

  @override
  Widget build(BuildContext context) {
    final parts = ligne.split('|||');
    final k = parts.first;
    final v = parts.length > 1 && parts[1].trim().isNotEmpty
        ? parts[1]
        : '—';
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 130,
            child: Text(
              k,
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ),
          Expanded(
            child: Text(
              v,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Pièces numériques du dossier (CIN recto/verso, emplacement) avec
/// visionneur zoom.
///
/// Honnêteté des données : seul le back-end embarqué expose les chemins des
/// photos. Lorsque les clés sont absentes (back-end distant), le bloc affiche
/// explicitement « NON DISPONIBLE DANS LE BACKEND » au lieu d'un vide.
class _PhotosDossier extends StatelessWidget {
  final Map<String, dynamic> d;
  const _PhotosDossier({required this.d});

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    // Clé de données → clé de traduction (l'emplacement a sa propre clé).
    const libelles = {
      'photo_cin_recto': 'photo_cin_recto',
      'photo_cin_verso': 'photo_cin_verso',
      'photo_emplacement': 'photo_location',
    };
    final clesPhotos = libelles.keys.toList();
    final expose = clesPhotos.any(d.containsKey);
    if (!expose) {
      return Card(
        margin: const EdgeInsets.only(bottom: 10),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: _Champ(
            ligne: '${l.t('photos_label')}|||${l.t('non_disponible_backend')}',
          ),
        ),
      );
    }

    final photos = <_Photo>[
      for (final cle in clesPhotos)
        _Photo(libelle: l.t(libelles[cle]!), chemin: d[cle]?.toString() ?? ''),
    ];
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l.t('photos_label'),
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: AppTheme.primaryNavy,
              ),
            ),
            const Divider(height: 16),
            Text(
              l.t('photo_zoom_hint'),
              style: const TextStyle(fontSize: 11, color: Colors.grey),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                for (final p in photos) _VignettePhoto(photo: p),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _Photo {
  final String libelle;
  final String chemin;
  const _Photo({required this.libelle, required this.chemin});

  bool get presente => !kIsWeb && chemin.isNotEmpty;
}

class _VignettePhoto extends StatelessWidget {
  final _Photo photo;
  const _VignettePhoto({required this.photo});

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final legende = photo.chemin.isNotEmpty
        ? photo.libelle
        : '${photo.libelle} — ${l.t('photo_absent')}';
    return InkWell(
      onTap: photo.presente ? () => _zoom(context) : null,
      borderRadius: BorderRadius.circular(8),
      child: SizedBox(
        width: 96,
        child: Column(
          children: [
            Container(
              width: 88,
              height: 72,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey.shade400),
              ),
              child: photo.presente
                  ? Image.file(
                      File(photo.chemin),
                      fit: BoxFit.cover,
                      errorBuilder: (_, _, _) => const Icon(
                        Icons.broken_image_outlined,
                        color: Colors.grey,
                      ),
                    )
                  : const Icon(Icons.image_not_supported_outlined,
                      color: Colors.grey, size: 28),
            ),
            const SizedBox(height: 4),
            Text(
              legende,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 10, color: Colors.black54),
            ),
          ],
        ),
      ),
    );
  }

  /// Visionneur plein écran : zoom à la molette / pincement.
  void _zoom(BuildContext context) {
    showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (context) => Dialog(
        backgroundColor: Colors.black,
        insetPadding: const EdgeInsets.all(8),
        child: Stack(
          children: [
            InteractiveViewer(
              maxScale: 6,
              child: Center(
                child: Image.file(
                  File(photo.chemin),
                  fit: BoxFit.contain,
                  errorBuilder: (_, _, _) => const Icon(
                    Icons.broken_image_outlined,
                    color: Colors.white54,
                    size: 64,
                  ),
                ),
              ),
            ),
            Positioned(
              top: 6,
              right: 6,
              child: IconButton(
                icon: const Icon(Icons.close, color: Colors.white),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
            Positioned(
              bottom: 8,
              left: 0,
              right: 0,
              child: Text(
                photo.libelle,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white70, fontSize: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Introuvable extends StatelessWidget {
  final VoidCallback? onRetry;
  const _Introuvable({this.onRetry});

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.search_off, color: Colors.grey, size: 64),
            const SizedBox(height: 16),
            Text(l.t('dossier_not_found'), textAlign: TextAlign.center),
            if (onRetry != null) ...[
              const SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: onRetry,
                icon: const Icon(Icons.refresh),
                label: Text(l.t('retry')),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

