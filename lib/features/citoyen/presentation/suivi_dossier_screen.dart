import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/config/app_config.dart';
import '../../../core/localization/app_localizations.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/utils/formatters.dart';
import '../../auth/bloc/auth_cubit.dart';
import '../../shared/presentation/kiosque_qr_screen.dart';
import '../../shared/widgets/shared_widgets.dart';
import '../bloc/demande_cubit.dart';

/// Suivi du dossier (lecture seule, section 5.4) — accès cloisonné
/// aux propres dossiers du demandeur (section 4.2).
class SuiviDossierScreen extends StatefulWidget {
  const SuiviDossierScreen({super.key});

  @override
  State<SuiviDossierScreen> createState() => _SuiviDossierScreenState();
}

class _SuiviDossierScreenState extends State<SuiviDossierScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final session = context.read<AuthCubit>().state.session;
      if (session != null) {
        context.read<DemandeCubit>().loadDossiers(session.telephone);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(l.t('track_title')),
        actions: const [LanguageSwitchButton()],
      ),
      body: BlocBuilder<DemandeCubit, DemandeState>(
        builder: (context, state) {
          if (state.loadingDossiers) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state.erreurLecture != null && state.dossiers.isEmpty) {
            // Panne réseau / back-end indisponible : annoncer l'échec plutôt
            // que de faire croire à « aucun dossier ».
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.cloud_off,
                      size: 64,
                      color: Colors.grey,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      state.erreurLecture!,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 13),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton.icon(
                      onPressed: () {
                        final session = context
                            .read<AuthCubit>()
                            .state
                            .session;
                        if (session != null) {
                          context.read<DemandeCubit>().loadDossiers(
                            session.telephone,
                          );
                        }
                      },
                      icon: const Icon(Icons.refresh),
                      label: Text(l.t('retry')),
                    ),
                  ],
                ),
              ),
            );
          }
          if (state.dossiers.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.inbox_outlined,
                    size: 64,
                    color: Colors.grey,
                  ),
                  const SizedBox(height: 12),
                  Text(l.t('empty_dossier')),
                ],
              ),
            );
          }
          return RefreshIndicator(
            onRefresh: () async {
              final session = context.read<AuthCubit>().state.session;
              if (session != null) {
                await context.read<DemandeCubit>().loadDossiers(
                  session.telephone,
                );
              }
            },
            child: ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: state.dossiers.length,
              itemBuilder: (context, i) => _DossierCard(d: state.dossiers[i]),
            ),
          );
        },
      ),
    );
  }
}

class _DossierCard extends StatelessWidget {
  final Map<String, dynamic> d;
  const _DossierCard({required this.d});

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final codeKiosque = d['code_kiosque']?.toString() ?? '';
    final statut = d['statut']?.toString() ?? 'EN_COURS_INSTRUCTION';
    final (color, label) = switch (statut) {
      'APPROUVE' => (AppTheme.statutVert, l.t('status_approved')),
      'REJETE' => (AppTheme.statutRouge, l.t('status_rejected')),
      _ => (AppTheme.statutOrange, l.t('status_en_cours')),
    };
    final statutDroit =
        d['statut_droit_installation']?.toString() ?? 'EN_ATTENTE';
    final taxesAnnuel = (d['taxes_annuel'] as List?) ?? const <dynamic>[];
    final moisRetard = (d['mois_retard_calcules'] as num?)?.toInt() ?? 0;
    final totalDette = (d['total_dette_ariary'] as num?)?.toInt() ?? 0;
    final taxeStatut = d['statut_taxe_mensuelle']?.toString() ?? 'A_JOUR';

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    color: color,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  label,
                  style: TextStyle(color: color, fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                if (codeKiosque.isNotEmpty)
                  TextButton.icon(
                    onPressed: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => KiosqueQrScreen.fromDossier(d),
                      ),
                    ),
                    icon: const Icon(Icons.qr_code_2, size: 18),
                    label: Text(l.t('kiosque_qr')),
                  ),
                Text(
                  d['date_soumission']?.toString() ?? '',
                  style: const TextStyle(fontSize: 11, color: Colors.grey),
                ),
              ],
            ),
            const Divider(height: 16),
            _Row(l.t('case_number'), d['code_dossier']?.toString() ?? '—'),
            _Row(
              l.t('commercial_name'),
              d['nom_commercial']?.toString() ?? '—',
            ),
            _Row(
              l.t('tax_installation'),
              Formatters.ariary(
                d['montant_droit_installation'] ??
                    AppConfig.droitInstallationAriary,
              ),
            ),
            _Row(
              l.t('statut_droit'),
              statutDroit == 'PAYE' ? l.t('paid_yes') : l.t('status_waiting'),
            ),
            if ((d['note_rejet'] ?? '').toString().isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 6),
                child: Text(
                  l.t('rejection_reason', args: [d['note_rejet']]),
                  style: const TextStyle(
                    color: Color(0xFFC62828),
                    fontSize: 12,
                  ),
                ),
              ),
            if (taxesAnnuel.isNotEmpty) ...[
              const Divider(height: 16),
              Text(
                AppLocalizations.of(context).t('renewal_history'),
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              for (final ligne in taxesAnnuel) _TaxeLigne(ligne.toString()),
              if (taxeStatut != 'A_JOUR' && moisRetard > 0)
                Padding(
                  padding: const EdgeInsets.only(top: 6),
                  child: Text(
                    '${AppLocalizations.of(context).t('renewal_current_year')} : '
                    '$moisRetard ${AppLocalizations.of(context).t('overdue_months')} — '
                    '${Formatters.ariary(totalDette)}',
                    style: const TextStyle(
                      color: Color(0xFFC62828),
                      fontSize: 12,
                    ),
                  ),
                ),
            ],
          ],
        ),
      ),
    );
  }
}

class _TaxeLigne extends StatelessWidget {
  final String ligne;
  const _TaxeLigne(this.ligne);

  @override
  Widget build(BuildContext context) {
    final parts = ligne.split('|');
    final annee = parts.isNotEmpty ? parts[0] : '—';
    final montant = parts.length > 1 ? parts[1] : '0';
    final statut = parts.length > 2 ? parts[2].toUpperCase() : 'EN_ATTENTE';
    final quittance = parts.length > 3 ? parts[3] : '';

    final aJour = statut == 'PAYE';
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 32,
            child: Text(
              annee,
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  Formatters.ariary(montant),
                  style: const TextStyle(fontSize: 12),
                ),
                if (quittance.isNotEmpty)
                  Text(
                    AppLocalizations.of(context).t(
                      'receipt_label',
                      args: [quittance],
                    ),
                    style: const TextStyle(fontSize: 10, color: Colors.grey),
                  ),
              ],
            ),
          ),
          Text(
            aJour
                ? AppLocalizations.of(context).t('paid_status_ok')
                : AppLocalizations.of(context).t('paid_status_late'),
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: aJour ? AppTheme.statutVert : AppTheme.statutRouge,
            ),
          ),
        ],
      ),
    );
  }
}

class _Row extends StatelessWidget {
  final String k;
  final String v;
  const _Row(this.k, this.v);

  @override
  Widget build(BuildContext context) {
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
              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }
}
