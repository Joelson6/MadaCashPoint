import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/localization/app_localizations.dart';
import '../../../core/security/auto_lock.dart';
import '../../../core/theme/app_theme.dart';
import '../../shared/widgets/shared_widgets.dart';
import '../bloc/agent_cubit.dart';
import '../bloc/agent_cubit.dart' as agent_state;
import 'dossier_detail_screen.dart';

/// Liste d'instruction de l'agent communal (section 4.4) : tous les dossiers
/// de la commune, filtrables par statut. Chaque ligne ouvre l'écran de décision
/// (approbation / corrections / rejet).
class DossiersScreen extends StatefulWidget {
  const DossiersScreen({super.key});
  static const route = '/agent/dossiers';

  @override
  State<DossiersScreen> createState() => _DossiersScreenState();
}

class _DossiersScreenState extends State<DossiersScreen> {
  String _filtre = 'TOUS';
  String _recherche = '';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) context.read<AgentCubit>().loadDossiers();
    });
  }

  bool _correspondRecherche(Map<String, dynamic> d, String q) {
    final s = q.trim().toLowerCase();
    if (s.isEmpty) return true;
    final codeDossier = (d['code_dossier'] ?? '').toString().toLowerCase();
    final nomPrenoms = (d['nom_prenoms'] ?? '').toString().toLowerCase();
    final nomCommercial = (d['nom_commercial'] ?? '').toString().toLowerCase();
    final proprietaireNom = (d['proprietaire_nom'] ?? '').toString().toLowerCase();
    final demandeurNom = (d['demandeur_nom'] ?? '').toString().toLowerCase();
    return codeDossier.contains(s) ||
        nomPrenoms.contains(s) ||
        nomCommercial.contains(s) ||
        proprietaireNom.contains(s) ||
        demandeurNom.contains(s);
  }

  List<Map<String, dynamic>> _filtrer(List<Map<String, dynamic>> dossiers) {
    var liste = _filtre == 'TOUS'
        ? dossiers
        : dossiers.where((d) => d['statut'] == _filtre).toList();
    liste = liste.where((d) => _correspondRecherche(d, _recherche)).toList();
    return liste;
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    return AutoLockScaffold(
      title: l.t('dossiers_title'),
      actions: const [LanguageSwitchButton()],
      child: BlocBuilder<AgentCubit, agent_state.AgentState>(
        builder: (context, state) {
          final cubit = context.read<AgentCubit>();
          if (state.loadingDossiers && state.dossiers.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state.error != null && state.dossiers.isEmpty) {
            return EtatErreur(
              message: state.error!,
              onRetry: cubit.loadDossiers,
            );
          }

          final visibles = _filtrer(state.dossiers);
          return RefreshIndicator(
            onRefresh: cubit.loadDossiers,
            child: ListView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.all(16),
              children: [
                // Bandeau de synthèse : total + dossiers en attente de décision.
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [AppTheme.primaryNavy, AppTheme.accentNavy],
                    ),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.assignment_turned_in,
                        color: Colors.white,
                        size: 30,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              l.t(
                                'dossiers_summary',
                                args: [
                                  state.dossiers.length,
                                  state.dossiersAInstruire,
                                ],
                              ),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              l.t('dossiers_hint'),
                              style: const TextStyle(
                                color: Colors.white70,
                                fontSize: 11,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                if (state.error != null)
                  Card(
                    color: AppTheme.statutRouge.withValues(alpha: 0.08),
                    child: ListTile(
                      leading: const Icon(
                        Icons.cloud_off,
                        color: AppTheme.statutRouge,
                      ),
                      title: Text(
                        state.error!,
                        style: const TextStyle(fontSize: 13),
                      ),
                      trailing: TextButton.icon(
                        onPressed: cubit.loadDossiers,
                        icon: const Icon(Icons.refresh, size: 18),
                        label: Text(l.t('retry')),
                      ),
                    ),
                  ),
                // Filtres par statut.
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      _FiltrePuce(
                        libelle: l.t('filter_all'),
                        actif: _filtre == 'TOUS',
                        couleur: AppTheme.primaryNavy,
                        onTap: () => setState(() => _filtre = 'TOUS'),
                      ),
                      _FiltrePuce(
                        libelle: l.t('status_en_cours'),
                        actif: _filtre == 'EN_COURS_INSTRUCTION',
                        couleur: AppTheme.statutOrange,
                        onTap: () => setState(
                          () => _filtre = 'EN_COURS_INSTRUCTION',
                        ),
                      ),
                      _FiltrePuce(
                        libelle: l.t('status_approved'),
                        actif: _filtre == 'APPROUVE',
                        couleur: AppTheme.statutVert,
                        onTap: () => setState(() => _filtre = 'APPROUVE'),
                      ),
                      _FiltrePuce(
                        libelle: l.t('status_rejected'),
                        actif: _filtre == 'REJETE',
                        couleur: AppTheme.statutRouge,
                        onTap: () => setState(() => _filtre = 'REJETE'),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                TextField(
                  onChanged: (v) => setState(() => _recherche = v),
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.search),
                    hintText: 'Rechercher par nom du demandeur ou par n° de dossier',
                    isDense: true,
                    border: const OutlineInputBorder(),
                    suffixIcon: _recherche.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: () => setState(() => _recherche = ''),
                          )
                        : null,
                  ),
                ),
                const SizedBox(height: 8),
                if (state.loadingDossiers) ...[
                  const LinearProgressIndicator(minHeight: 3),
                  const SizedBox(height: 8),
                ],
                if (state.dossiers.isEmpty)
                  EtatVide(message: l.t('dossiers_empty'))
                else if (visibles.isEmpty)
                  EtatVide(
                    message: _recherche.trim().isNotEmpty
                        ? 'Aucun dossier trouvé pour cette recherche (nom du demandeur ou n° de dossier).'
                        : l.t('dossiers_empty_filter'),
                  )
                else
                  ...visibles.map((d) => _DossierTile(d: d)),
                const SizedBox(height: 40),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _DossierTile extends StatelessWidget {
  final Map<String, dynamic> d;
  const _DossierTile({required this.d});

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final statut = d['statut']?.toString() ?? 'EN_COURS_INSTRUCTION';
    final (couleur, libelle) = switch (statut) {
      'APPROUVE' => (AppTheme.statutVert, l.t('status_approved')),
      'REJETE' => (AppTheme.statutRouge, l.t('status_rejected')),
      _ => (AppTheme.statutOrange, l.t('status_en_cours')),
    };

    return Card(
      margin: const EdgeInsets.only(bottom: 6),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: couleur.withValues(alpha: 0.12),
          child: Icon(Icons.description, color: couleur),
        ),
        title: Text(
          d['code_dossier']?.toString() ?? '—',
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        ),
        subtitle: Text(
          [
            if ((d['nom_prenoms'] ?? '').toString().isNotEmpty)
              d['nom_prenoms'],
            if ((d['nom_commercial'] ?? '').toString().isNotEmpty)
              d['nom_commercial'],
            d['fokontany'] ?? '',
          ].where((e) => e.toString().isNotEmpty).join(' · '),
          style: const TextStyle(fontSize: 12),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: couleur.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                libelle,
                style: TextStyle(
                  color: couleur,
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const Icon(Icons.chevron_right),
          ],
        ),
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => DossierDetailScreen(
              codeDossier: d['code_dossier']?.toString() ?? '',
            ),
          ),
        ),
      ),
    );
  }
}

class _FiltrePuce extends StatelessWidget {
  final String libelle;
  final bool actif;
  final Color couleur;
  final VoidCallback onTap;
  const _FiltrePuce({
    required this.libelle,
    required this.actif,
    required this.couleur,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: ChoiceChip(
        label: Text(libelle),
        selected: actif,
        onSelected: (_) => onTap(),
        selectedColor: couleur.withValues(alpha: 0.15),
        labelStyle: TextStyle(
          color: actif ? couleur : Colors.black87,
          fontWeight: actif ? FontWeight.w700 : FontWeight.w500,
          fontSize: 12,
        ),
        side: BorderSide(color: actif ? couleur : Colors.black26),
      ),
    );
  }
}
