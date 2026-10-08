import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/localization/app_localizations.dart';
import '../../../core/security/auto_lock.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/utils/formatters.dart';
import '../../../data/models/kiosque.dart';
import '../../../data/remote/kiosque_mapper.dart';
import '../../auth/bloc/auth_cubit.dart';
import '../../shared/widgets/shared_widgets.dart';
import '../bloc/agent_cubit.dart';
import '../bloc/agent_cubit.dart' as agent_state;
import 'agent_feedback.dart';
import 'agent_profil_screen.dart';
import '../../shared/presentation/kiosque_qr_screen.dart';
import 'dossiers_screen.dart';
import 'kiosque_dashboard_screen.dart';
import 'kiosques_redevables_screen.dart';
import 'scanner_screen.dart';

/// Écran d'accueil Agent Communal (section 6) : tableau de bord personnel,
/// bouton Scanner, synchronisation, navigation par rebond.
class AgentHomeScreen extends StatelessWidget {
  const AgentHomeScreen({super.key});
  static const route = '/agent';

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final auth = context.read<AuthCubit>().state.session;

    return AutoLockScaffold(
      title: l.t('agent_home_title'),
      actions: [
        const LanguageSwitchButton(),
        IconButton(
          icon: const Icon(Icons.account_circle),
          tooltip: l.t('profile'),
          onPressed: () => Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => const AgentProfilScreen()),
          ),
        ),
      ],
      child: BlocConsumer<AgentCubit, agent_state.AgentState>(
        listenWhen: agentEcouteMessages,
        listener: agentAfficherMessages,
        builder: (context, state) {
          final cubit = context.read<AgentCubit>();
          // Un écran empilé a pu laisser une erreur non affichée : au retour
          // sur l'accueil, elle est effacée silencieusement (l'invite SnackBar
          // a déjà été montrée — ou le widget d'erreur rendu — sur l'écran
          // qui l'a produite).
          if (state.error != null && agentRouteCourante(context)) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (agentRouteCourante(context)) {
                cubit.clearTransient();
              }
            });
          }
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              if (state.loading) const LinearProgressIndicator(),
              // Bannière agent
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
                    const Icon(Icons.shield, color: Colors.white, size: 36),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            auth?.nom ?? '',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            auth?.telephone ?? '',
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 13,
                            ),
                          ),
                          Text(
                            l.t('agent_session', args: [_court(auth?.sessionToken)]),
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.refresh, color: Colors.white),
                      tooltip: l.t('synchronize'),
                      onPressed: cubit.synchroniser,
                    ),
                    IconButton(
                      icon: const Icon(Icons.logout, color: Colors.white),
                      tooltip: l.t('logout'),
                      onPressed: () => context.read<AuthCubit>().logout(),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              if (state.pendingSync > 0)
                Card(
                  color: AppTheme.statutOrange.withOpacity(0.08),
                  child: ListTile(
                    leading: const Icon(
                      Icons.cloud_upload,
                      color: AppTheme.statutOrange,
                    ),
                    title: Text('${state.pendingSync} ${l.t('pending_sync')}'),
                    trailing: OutlinedButton(
                      onPressed: cubit.synchroniser,
                      child: Text(l.t('sync_short')),
                    ),
                  ),
                ),
              const SizedBox(height: 8),
              // Bouton Scanner principal
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () => Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const ScannerScreen()),
                  ),
                  icon: const Icon(Icons.qr_code_scanner, size: 32),
                  label: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l.t('scan_kiosque'),
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        l.t('scan_hint'),
                        style: const TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primaryNavy,
                    padding: const EdgeInsets.all(20),
                    alignment: Alignment.centerLeft,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // Instruction des dossiers (§ 4.4) : approbation / rejet.
              Card(
                margin: const EdgeInsets.only(bottom: 6),
                child: ListTile(
                  leading: const CircleAvatar(
                    backgroundColor: AppTheme.accentNavy,
                    child: Icon(
                      Icons.assignment_turned_in,
                      color: Colors.white,
                    ),
                  ),
                  title: Text(
                    l.t('dossiers_title'),
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  subtitle: Text(
                    state.dossiersAInstruire > 0
                        ? l.t(
                            'dossiers_summary',
                            args: [
                              state.dossiers.length,
                              state.dossiersAInstruire,
                            ],
                          )
                        : l.t('dossiers_hint'),
                    style: const TextStyle(fontSize: 12),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (state.dossiersAInstruire > 0)
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: AppTheme.statutOrange,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            '${state.dossiersAInstruire}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      const Icon(Icons.chevron_right),
                    ],
                  ),
                  onTap: () async {
                    await cubit.loadDossiers();
                    if (context.mounted) {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => const DossiersScreen(),
                        ),
                      );
                    }
                  },
                ),
              ),
              const SizedBox(height: 8),
              // Liste de travail recouvrement (section 6) : kiosques en retard.
              Card(
                margin: const EdgeInsets.only(bottom: 6),
                child: ListTile(
                  leading: const CircleAvatar(
                    backgroundColor: AppTheme.statutRouge,
                    child: Icon(Icons.receipt_long, color: Colors.white),
                  ),
                  title: Text(
                    l.t('kiosques_redevables'),
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  subtitle: state.redevables.isEmpty
                      ? Text(
                          l.t('redevables_hint'),
                          style: const TextStyle(fontSize: 12),
                        )
                      : Text(
                          l.t(
                            'redevables_summary',
                            args: [
                              state.redevables.length,
                              Formatters.ariary(
                                state.redevables.fold<int>(
                                  0,
                                  (acc, k) => acc + k.totalDetteAriary,
                                ),
                              ),
                            ],
                          ),
                          style: const TextStyle(fontSize: 12),
                        ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (state.redevables.isNotEmpty)
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: AppTheme.statutRouge,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            '${state.redevables.length}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      const Icon(Icons.chevron_right),
                    ],
                  ),
                  onTap: () async {
                    await cubit.loadRedevables();
                    if (context.mounted) {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => const KiosquesRedevablesScreen(),
                        ),
                      );
                    }
                  },
                ),
              ),
              const SizedBox(height: 8),
              if (state.recents.isNotEmpty) ...[
                SectionTitle(l.t('recent_kiosques'), icon: Icons.history),
                ...state.recents.map(
                  (k) => Card(
                    child: ListTile(
                      leading: Container(
                        width: 12,
                        height: 12,
                        decoration: BoxDecoration(
                          color: k.statusColor,
                          shape: BoxShape.circle,
                        ),
                      ),
                      title: Text(
                        k.codeKiosque,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(k.proprietaireNom),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.qr_code_2),
                            color: AppTheme.accentNavy,
                            tooltip: l.t('kiosque_qr'),
                            onPressed: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => KiosqueQrScreen.fromLocal(k),
                              ),
                            ),
                          ),
                          const Icon(Icons.chevron_right),
                        ],
                      ),
                      onTap: () {
                        context.read<AgentCubit>().loadKiosqueById(
                          k.codeKiosque,
                        );
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => const KiosqueDashboardScreen(),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ] else
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Text(
                    l.t('recent_empty'),
                    style: TextStyle(color: Colors.grey.shade600),
                  ),
                ),
              const SizedBox(height: 40),
              // Liens utiles
              OutlinedButton.icon(
                onPressed: () => _afficherCacheLocal(context, state.recents),
                icon: const Icon(Icons.storage),
                label: Text(l.t('agent_cache')),
              ),
            ],
          );
        },
      ),
    );
  }

  /// Dialog « État du cache local » : liste réelle des kiosques en cache
  /// (remplace l'ancien bouton inerte qui n'affichait qu'un SnackBar).
  static Future<void> _afficherCacheLocal(
    BuildContext context,
    List<Kiosque> recents,
  ) async {
    final l = AppLocalizations.of(context);
    await showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        icon: const Icon(Icons.storage, color: AppTheme.primaryNavy),
        title: Text(l.t('agent_cache_count', args: ['${recents.length}'])),
        content: recents.isEmpty
            ? Text(l.t('recent_empty'))
            : SizedBox(
                width: double.maxFinite,
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    for (final k in recents)
                      ListTile(
                        dense: true,
                        leading: const Icon(Icons.storefront, size: 20),
                        title: Text(
                          k.codeKiosque,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          '${k.proprietaireNom} · '
                          '${Formatters.dateFr(k.lastSeenAt)}',
                        ),
                        trailing: k.totalDetteAriary > 0
                            ? Text(
                                Formatters.ariary(k.totalDetteAriary),
                                style: const TextStyle(
                                  color: AppTheme.statutRouge,
                                  fontWeight: FontWeight.w600,
                                ),
                              )
                            : null,
                      ),
                    const Divider(height: 8),
                    Text(
                      l.t('agent_cache_hint'),
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),
              ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(l.t('close')),
          ),
        ],
      ),
    );
  }

  static String _court(String? s) {
    if (s == null || s.length <= 16) return s ?? '';
    return '${s.substring(0, 16)}…';
  }
}

/// Utilitaire : couleur du statut fiscal à partir des champs du kiosque local.
extension _StatusColor on Kiosque {
  Color get statusColor {
    final coup = couleurFiscaleKiosque(this);
    return switch (coup) {
      StatutFiscalCouleur.vert => AppTheme.statutVert,
      StatutFiscalCouleur.orange => AppTheme.statutOrange,
      StatutFiscalCouleur.rouge => AppTheme.statutRouge,
    };
  }
}
