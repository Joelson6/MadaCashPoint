import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/localization/app_localizations.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/service/notification_service.dart';
import '../../auth/bloc/auth_cubit.dart';
import '../../shared/widgets/shared_widgets.dart';
import '../bloc/demande_cubit.dart';

/// Centre de notifications du citoyen (section 12 du CDC).
/// Dérivées des dossiers et des taxes ; badge de non-lus persisté.
class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  String _telephone = '';

  @override
  void initState() {
    super.initState();
    // La session est lue AVANT le premier build : le statut lu/non lu doit
    // être exact dès l'affichage (sinon `seenIds('')` rend toute la liste
    // « non lue » sur le premier rendu, et le bouton de marquage resterait
    // désactivé si la session était absente).
    final session = context.read<AuthCubit>().state.session;
    _telephone = session?.telephone ?? '';
    if (session == null) return;
    final cubit = context.read<DemandeCubit>();
    // Garantit des données à jour pour la dérivation des notifications.
    cubit.loadDossiers(session.telephone);
    cubit.loadPaiements(session.telephone);
    cubit.loadNotifications(session.telephone);
  }

  /// Ouverture d'une notification : passage à LUE (persistant) puis affichage
  /// du détail. L'état visuel est rafraîchi immédiatement et au retour sur la
  /// liste — aucun refresh manuel nécessaire.
  Future<void> _ouvrir(CitizenNotification n) async {
    if (_telephone.isNotEmpty) {
      if (n.id.startsWith('anomalie-')) {
        await context.read<DemandeCubit>().markNotificationRead(n.id);
      } else {
        await NotificationService.instance.markSeenId(_telephone, n.id);
      }
    }
    if (!mounted) return;
    setState(() {});
    final l = AppLocalizations.of(context);
    await showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(n.title),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(n.message),
            const SizedBox(height: 12),
            Text(
              '${n.date.day}/${n.date.month}/${n.date.year}',
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(l.t('ok')),
          ),
        ],
      ),
    );
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(l.t('notifications_title')),
        actions: [
          const LanguageSwitchButton(),
          IconButton(
            icon: const Icon(Icons.done_all),
            tooltip: l.t('notifications_mark_read'),
            onPressed: _telephone.isEmpty
                ? null
                : () async {
                    final cubit = context.read<DemandeCubit>();
                    final state = cubit.state;
                    await NotificationService.instance.markSeen(
                      _telephone,
                      NotificationService.instance.build(
                        _telephone,
                        state.dossiers,
                        state.paiements,
                      ),
                    );
                    await cubit.markAllNotificationsRead();
                    setState(() {});
                  },
          ),
        ],
      ),
      body: BlocBuilder<DemandeCubit, DemandeState>(
        builder: (context, state) {
          if (state.dossiers.isEmpty &&
              state.paiements.isEmpty &&
              state.notifications.isEmpty &&
              (state.loadingDossiers ||
                  state.loadingPaiements ||
                  state.loadingNotifications)) {
            return const Center(child: CircularProgressIndicator());
          }
          final notificationService = NotificationService.instance;
          final liste = notificationService.buildComplet(
            _telephone,
            state.dossiers,
            state.paiements,
            state.notifications,
          );

          if (liste.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.notifications_off_outlined,
                    size: 64,
                    color: Colors.grey,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    l.t('notifications_empty'),
                    style: const TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 8),
            itemCount: liste.length,
            itemBuilder: (context, i) => _NotificationCard(
              n: liste[i],
              lu: notificationService.estLue(
                _telephone,
                liste[i],
                state.notifications,
              ),
              onTap: () => _ouvrir(liste[i]),
            ),
          );
        },
      ),
    );
  }
}

class _NotificationCard extends StatelessWidget {
  final CitizenNotification n;
  final bool lu;
  final VoidCallback onTap;
  const _NotificationCard({
    required this.n,
    required this.lu,
    required this.onTap,
  });

  IconData get _icone => switch (n.type) {
    'DOSSIER_APPROUVE' => Icons.task_alt,
    'DOSSIER_REJETE' => Icons.cancel,
    'TAXE_EN_RETARD' => Icons.notification_important,
    'DROIT_A_PAYER' => Icons.payment,
    'TAXE_A_JOUR' => Icons.event_available,
    'ANOMALIE_SIGNALLEE' => Icons.report_problem,
    _ => Icons.info_outline,
  };

  Color get _couleur => switch (n.type) {
    'DOSSIER_REJETE' || 'TAXE_EN_RETARD' => AppTheme.statutRouge,
    'DROIT_A_PAYER' => AppTheme.statutOrange,
    'TAXE_A_JOUR' => AppTheme.statutVert,
    'DOSSIER_APPROUVE' => AppTheme.statutVert,
    'ANOMALIE_SIGNALLEE' => AppTheme.statutRouge,
    _ => AppTheme.primaryNavy,
  };

  @override
  Widget build(BuildContext context) {
    final d = n.date;
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      child: ListTile(
        onTap: onTap,
        leading: CircleAvatar(
          backgroundColor: _couleur.withValues(alpha: 0.12),
          child: Icon(_icone, color: _couleur),
        ),
        title: Text(
          n.title,
          style: TextStyle(fontWeight: lu ? FontWeight.w500 : FontWeight.bold),
        ),
        subtitle: Text(n.message, style: const TextStyle(fontSize: 12)),
        trailing: Text(
          '${d.day}/${d.month}/${d.year}',
          style: const TextStyle(fontSize: 11, color: Colors.grey),
        ),
        selected: !lu,
        selectedTileColor: AppTheme.surfaceLight,
      ),
    );
  }
}
