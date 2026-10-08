import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/config/app_config.dart';
import '../../../core/localization/app_localizations.dart';
import '../../../core/service/notification_service.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/utils/formatters.dart';
import '../../auth/bloc/auth_cubit.dart';
import '../../shared/widgets/shared_widgets.dart';
import '../bloc/demande_cubit.dart';
import 'demande_form_screen.dart';
import 'mes_paiements_screen.dart';
import 'notifications_screen.dart';
import 'suivi_dossier_screen.dart';

/// Espace Citoyen (section 5) : demande d'autorisation, suivi de dossier,
/// historique des paiements (5.4 / 4.2) et notifications (12).
class CitoyenHomeScreen extends StatefulWidget {
  const CitoyenHomeScreen({super.key});
  static const route = '/citoyen';

  @override
  State<CitoyenHomeScreen> createState() => _CitoyenHomeScreenState();
}

class _CitoyenHomeScreenState extends State<CitoyenHomeScreen> {
  bool _chargementsLances = false;
  int _nouvellesNotifications = 0;

  void _demarrerChargements(String telephone) {
    final cubit = context.read<DemandeCubit>();
    cubit.loadDossiers(telephone);
    cubit.loadPaiements(telephone);
    cubit.loadNotifications(telephone);
  }

  void _actualiserBadge(AuthCubit auth, DemandeState state) {
    final session = auth.state.session;
    if (session == null) return;
    final service = NotificationService.instance;
    _nouvellesNotifications = service.unreadCountComplet(
      session.telephone,
      service.buildComplet(
        session.telephone,
        state.dossiers,
        state.paiements,
        state.notifications,
      ),
      state.notifications,
    );
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final auth = context.watch<AuthCubit>();
    final state = auth.state;
    final session = state.session;

    if (session != null && !_chargementsLances) {
      _chargementsLances = true;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) _demarrerChargements(session.telephone);
      });
    }
    _actualiserBadge(auth, context.watch<DemandeCubit>().state);

    return Scaffold(
      appBar: AppBar(
        title: Text(l.t('citoyen_home_title')),
        actions: [
          const LanguageSwitchButton(),
          IconButton(
            icon: _BadgeNotifications(
              count: _nouvellesNotifications,
              child: const Icon(Icons.notifications_outlined),
            ),
            tooltip: l.t('notifications_title'),
            onPressed: () async {
              await Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const NotificationsScreen()),
              );
              if (mounted) setState(() {});
            },
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: l.t('logout'),
            onPressed: () => context.read<AuthCubit>().logout(),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [AppTheme.primaryNavy, AppTheme.accentNavy],
              ),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${l.t('welcome')},',
                  style: const TextStyle(color: Colors.white70, fontSize: 14),
                ),
                Text(
                  session?.nom ?? '',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  session?.telephone ?? '',
                  style: const TextStyle(color: Colors.white70, fontSize: 13),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          if (state.demoOtp != null && state.otpPending)
            Card(
              color: Colors.amber.shade50,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Text('${l.t('otp_demo')}${state.demoOtp}'),
              ),
            ),
          _GrilleCard(l: l),
          MenuCard(
            icon: Icons.add_business,
            title: l.t('new_demande'),
            subtitle:
                'Droit d\'installation : ${Formatters.ariary(AppConfig.droitInstallationAriary)}',
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const DemandeFormScreen()),
            ),
          ),
          MenuCard(
            icon: Icons.folder_open,
            title: l.t('track_dossier'),
            subtitle:
                '${l.t('status')} : ${l.t('status_en_cours')} / ${l.t('status_approved')} / ${l.t('status_rejected')}',
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const SuiviDossierScreen()),
            ),
          ),
          MenuCard(
            icon: Icons.payments_outlined,
            title: l.t('my_payments'),
            subtitle:
                '150 000 Ar / ${Formatters.ariary(AppConfig.renouvellementAnnuelAriary)}',
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const MesPaiementsScreen()),
            ),
          ),
        ],
      ),
    );
  }
}

/// Badge de notifications non lues (Material 3, état claqué dès t>0 non lues).
class _BadgeNotifications extends StatelessWidget {
  final int count;
  final Widget child;
  const _BadgeNotifications({required this.count, required this.child});

  @override
  Widget build(BuildContext context) {
    if (count <= 0) return child;
    return Badge.count(
      count: count,
      backgroundColor: AppTheme.statutRouge,
      child: child,
    );
  }
}

class _GrilleCard extends StatelessWidget {
  final AppLocalizations l;
  const _GrilleCard({required this.l});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l.t('grille_tarifaire'),
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            _TaxeRow(
              'Droit d\'installation',
              AppConfig.droitInstallationAriary,
              'Taxe unique',
            ),
            const SizedBox(height: 6),
            _TaxeRow(
              'Renouvellement annuel',
              AppConfig.renouvellementAnnuelAriary,
              'Par an',
            ),
          ],
        ),
      ),
    );
  }
}

class _TaxeRow extends StatelessWidget {
  final String nom;
  final int montant;
  final String modalite;
  const _TaxeRow(this.nom, this.montant, this.modalite);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.receipt_long, size: 16, color: AppTheme.primaryNavy),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(nom, style: const TextStyle(fontSize: 13)),
            Text(
              modalite,
              style: const TextStyle(fontSize: 11, color: Colors.grey),
            ),
          ],
        ),
        const Spacer(),
        Text(
          Formatters.ariary(montant),
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        ),
      ],
    );
  }
}
