import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/localization/app_localizations.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/utils/formatters.dart';
import '../../auth/bloc/auth_cubit.dart';
import '../../shared/widgets/shared_widgets.dart';
import '../bloc/demande_cubit.dart';

/// Historique des paiements du demandeur (section 5.4, accès cloisonné 4.2).
/// Affiche le Droit d'Installation et les taxes annuelles de renouvellement
/// avec leur statut (à jour / en retard / à payer) et les quittances.
class MesPaiementsScreen extends StatefulWidget {
  const MesPaiementsScreen({super.key});

  @override
  State<MesPaiementsScreen> createState() => _MesPaiementsScreenState();
}

class _MesPaiementsScreenState extends State<MesPaiementsScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final session = context.read<AuthCubit>().state.session;
      if (session != null) {
        context.read<DemandeCubit>().loadPaiements(session.telephone);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(l.t('payments_title')),
        actions: const [LanguageSwitchButton()],
      ),
      body: BlocBuilder<DemandeCubit, DemandeState>(
        builder: (context, state) {
          if (state.loadingPaiements && state.paiements.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state.erreurLecture != null && state.paiements.isEmpty) {
            // Panne réseau : annoncer l'échec plutôt qu'un faux « aucun
            // paiement ».
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.cloud_off, size: 64, color: Colors.grey),
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
                          context.read<DemandeCubit>().loadPaiements(
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
          if (state.paiements.isEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.receipt_long_outlined,
                      size: 64,
                      color: Colors.grey,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      l.t('payments_empty'),
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
            );
          }
          final installation = state.paiements.where(
            (p) => p['type'] == 'DROIT_INSTALLATION',
          );
          final renouvellements = state.paiements.where(
            (p) => p['type'] == 'RENOUVELLEMENT',
          );

          return RefreshIndicator(
            onRefresh: () async {
              final session = context.read<AuthCubit>().state.session;
              if (session != null) {
                await context.read<DemandeCubit>().loadPaiements(
                  session.telephone,
                );
              }
            },
            child: ListView(
              padding: const EdgeInsets.only(bottom: 24),
              children: [
                _SummaryBanner(paiements: state.paiements, l: l),
                const SizedBox(height: 4),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    l.t('payments_via_agent'),
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ),
                if (installation.isNotEmpty) ...[
                  _SectionHeader(l.t('payments_type_installation')),
                  for (final p in installation) _PaymentCard(p: p, l: l),
                ],
                if (renouvellements.isNotEmpty) ...[
                  _SectionHeader(l.t('payments_type_renewal')),
                  for (final p in renouvellements) _PaymentCard(p: p, l: l),
                ],
              ],
            ),
          );
        },
      ),
    );
  }
}

class _SummaryBanner extends StatelessWidget {
  final List<Map<String, dynamic>> paiements;
  final AppLocalizations l;
  const _SummaryBanner({required this.paiements, required this.l});

  @override
  Widget build(BuildContext context) {
    int totalPaye = 0;
    int totalDu = 0;
    // Le total dû : une seule fois par exercice (le montant_du global + les
    // droits d'installation non réglés). On évite de cumuler les lignes
    // « EN_RETARD » répétées pour un même exercice.
    final exercicesVus = <String>{};
    for (final p in paiements) {
      final montantPaye = (p['montant_paye'] as num?)?.toInt() ?? 0;
      final montantDu = (p['montant_du'] as num?)?.toInt() ?? 0;
      totalPaye += montantPaye;
      final type = p['type']?.toString() ?? '';
      if (type == 'DROIT_INSTALLATION') {
        totalDu += montantDu;
      } else {
        final annee = '${p['annee']}';
        final code = p['code_dossier']?.toString() ?? '';
        final cle = '$annee|$code';
        if (montantDu > 0 && !exercicesVus.contains(cle)) {
          exercicesVus.add(cle);
          totalDu += montantDu;
        }
      }
    }

    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppTheme.primaryNavy, AppTheme.accentNavy],
        ),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l.t('payments_total_paid'),
                  style: const TextStyle(color: Colors.white70, fontSize: 12),
                ),
                Text(
                  Formatters.ariary(totalPaye),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Container(width: 1, height: 40, color: Colors.white24),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l.t('payments_total_due'),
                  style: const TextStyle(color: Colors.white70, fontSize: 12),
                ),
                Text(
                  Formatters.ariary(totalDu),
                  style: TextStyle(
                    color: totalDu > 0 ? Colors.amber.shade300 : Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  const _SectionHeader(this.title);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
      child: Text(
        title,
        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
      ),
    );
  }
}

class _PaymentCard extends StatelessWidget {
  final Map<String, dynamic> p;
  final AppLocalizations l;
  const _PaymentCard({required this.p, required this.l});

  String _labelStatut() {
    final s = p['statut']?.toString() ?? '';
    return switch (s) {
      'PAYE' => l.t('payments_status_paid'),
      'A_JOUR' => l.t('payments_status_acjour'),
      'EN_RETARD' => l.t('payments_status_retard'),
      _ => l.t('payments_status_due'),
    };
  }

  (Color, IconData) _visuelStatut() {
    final s = p['statut']?.toString() ?? '';
    return switch (s) {
      'PAYE' => (AppTheme.statutVert, Icons.check_circle),
      'A_JOUR' => (AppTheme.statutVert, Icons.event_available),
      'EN_RETARD' => (AppTheme.statutRouge, Icons.error),
      _ => (AppTheme.statutOrange, Icons.schedule),
    };
  }

  @override
  Widget build(BuildContext context) {
    final (couleur, icone) = _visuelStatut();
    final montant = (p['montant'] as num?)?.toInt() ?? 0;
    final montantDu = (p['montant_du'] as num?)?.toInt() ?? 0;
    final annee = p['annee'];
    final nom = p['nom_commercial']?.toString() ?? '—';
    final code = p['code_dossier']?.toString() ?? '';
    final quittance = p['numero_quittance']?.toString() ?? '';
    final datePaiement = p['date_paiement']?.toString() ?? '';
    final echeance = p['echeance']?.toString() ?? '';

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icone, color: couleur, size: 20),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    annee == null
                        ? 'Droit d\'installation — $nom'
                        : '$nom — $annee',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Chip(
                  visualDensity: VisualDensity.compact,
                  backgroundColor: couleur.withValues(alpha: 0.12),
                  label: Text(
                    _labelStatut(),
                    style: TextStyle(
                      color: couleur,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            if (code.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 2),
                child: Text(
                  'N° dossier : $code',
                  style: const TextStyle(fontSize: 11, color: Colors.grey),
                ),
              ),
            if (quittance.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 2),
                child: Text(
                  '${l.t('payments_quittance')} : $quittance',
                  style: const TextStyle(fontSize: 12),
                ),
              ),
            Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (datePaiement.isNotEmpty)
                          Text(
                            '${l.t('dates')} : $datePaiement',
                            style: const TextStyle(
                              fontSize: 11,
                              color: Colors.grey,
                            ),
                          ),
                        if (echeance.isNotEmpty && datePaiement.isEmpty)
                          Text(
                            '${l.t('payments_due_date')} : $echeance',
                            style: const TextStyle(
                              fontSize: 11,
                              color: Colors.grey,
                            ),
                          ),
                        if (montantDu > 0)
                          Text(
                            '${l.t('payments_total_due')} : '
                            '${Formatters.ariary(montantDu)}',
                            style: TextStyle(fontSize: 11, color: couleur),
                          ),
                      ],
                    ),
                  ),
                  Text(
                    Formatters.ariary(montant),
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
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
