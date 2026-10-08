import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/localization/app_localizations.dart';
import '../../../core/security/auto_lock.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/utils/formatters.dart';
import '../../../data/models/kiosque.dart';
import '../../../data/remote/kiosque_mapper.dart';
import '../../shared/widgets/shared_widgets.dart';
import '../bloc/agent_cubit.dart';
import '../bloc/agent_cubit.dart' as agent_state;
import 'kiosque_dashboard_screen.dart';

/// Liste de travail recouvrement (section 6) : kiosques en retard de paiement,
/// triés par dette décroissante. Chaque ligne ouvre la fiche kiosque du tableau
/// de bord (émission d'une quittance directement depuis la liste).
class KiosquesRedevablesScreen extends StatefulWidget {
  const KiosquesRedevablesScreen({super.key});
  static const route = '/agent/redevables';

  @override
  State<KiosquesRedevablesScreen> createState() =>
      _KiosquesRedevablesScreenState();
}

class _KiosquesRedevablesScreenState extends State<KiosquesRedevablesScreen> {
  String _recherche = '';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) context.read<AgentCubit>().loadRedevables();
    });
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    return AutoLockScaffold(
      title: l.t('kiosques_redevables'),
      actions: const [LanguageSwitchButton()],
      child: BlocBuilder<AgentCubit, agent_state.AgentState>(
        builder: (context, state) {
          final cubit = context.read<AgentCubit>();
          if (state.loadingRedevables && state.redevables.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state.error != null && state.redevables.isEmpty) {
            return EtatErreur(
              message: state.error!,
              onRetry: cubit.loadRedevables,
            );
          }
          if (state.redevables.isEmpty) {
            return EtatVide(
              message: l.t('redevables_empty'),
              onRefresh: cubit.loadRedevables,
            );
          }

          final visibles = state.redevables.where((k) {
            final q = _recherche.trim().toLowerCase();
            if (q.isEmpty) return true;
            return [
              k.codeKiosque,
              k.proprietaireNom,
              k.fokontany,
            ].any((v) => v.toLowerCase().contains(q));
          }).toList();
          final totalDette = state.redevables.fold<int>(
            0,
            (acc, k) => acc + k.totalDetteAriary,
          );
          return RefreshIndicator(
            onRefresh: cubit.loadRedevables,
            child: ListView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.all(16),
              children: [
                // Bandeau récapitulatif : nombre de kiosques + dette cumulée.
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: AppTheme.statutRouge,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.receipt_long,
                        color: Colors.white,
                        size: 30,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          l.t(
                            'redevables_summary',
                            args: [
                              state.redevables.length,
                              Formatters.ariary(totalDette),
                            ],
                          ),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
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
                        onPressed: cubit.loadRedevables,
                        icon: const Icon(Icons.refresh, size: 18),
                        label: Text(l.t('retry')),
                      ),
                    ),
                  ),
                TextField(
                  onChanged: (v) => setState(() => _recherche = v),
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.search),
                    hintText: l.t('search_hint'),
                    isDense: true,
                    border: const OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 12),
                if (state.loadingRedevables) ...[
                  const LinearProgressIndicator(minHeight: 3),
                  const SizedBox(height: 8),
                ],
                if (visibles.isEmpty)
                  EtatVide(
                    message: l.t('search_no_result'),
                    onRefresh: cubit.loadRedevables,
                  )
                else
                  ...visibles.map(
                  (k) => _KiosqueRedevableTile(
                    kiosque: k,
                    onTap: () {
                      cubit.loadKiosqueById(k.codeKiosque);
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => const KiosqueDashboardScreen(),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _KiosqueRedevableTile extends StatelessWidget {
  final Kiosque kiosque;
  final VoidCallback onTap;
  const _KiosqueRedevableTile({required this.kiosque, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final couleur = couleurFiscaleKiosque(kiosque);
    final color = switch (couleur) {
      StatutFiscalCouleur.vert => AppTheme.statutVert,
      StatutFiscalCouleur.orange => AppTheme.statutOrange,
      StatutFiscalCouleur.rouge => AppTheme.statutRouge,
    };

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: ListTile(
        leading: Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        title: Row(
          children: [
            Text(
              kiosque.codeKiosque,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(width: 8),
            if (kiosque.moisRetardCalcules > 0)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: AppTheme.statutRouge.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '${kiosque.moisRetardCalcules} ${l.t('overdue_months')}',
                  style: const TextStyle(
                    fontSize: 11,
                    color: AppTheme.statutRouge,
                  ),
                ),
              ),
          ],
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              kiosque.proprietaireNom,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Row(
              children: [
                const Icon(Icons.location_on, size: 13, color: Colors.grey),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    kiosque.fokontany,
                    style: const TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                ),
                Text(
                  Formatters.ariary(kiosque.totalDetteAriary),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppTheme.statutRouge,
                  ),
                ),
              ],
            ),
          ],
        ),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
}
