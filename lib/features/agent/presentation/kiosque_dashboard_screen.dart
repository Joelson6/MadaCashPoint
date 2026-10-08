import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:latlong2/latlong.dart';

import '../../../core/localization/app_localizations.dart';
import '../../../core/security/auto_lock.dart';
import '../../../core/theme/app_theme.dart';
import '../../../data/remote/kiosque_mapper.dart';
import '../../auth/bloc/auth_cubit.dart';
import '../../shared/widgets/shared_widgets.dart';
import '../bloc/agent_cubit.dart';
import '../../shared/presentation/kiosque_qr_screen.dart';
import '../../shared/widgets/real_map_view.dart';
import 'anomalie_screen.dart';
import 'encaissement_screen.dart';

/// Tableau de bord personnalisé du kiosque (section 6.2) : bannière d'état,
/// fiche technique, état financier, mini-carte GPS, navigation par rebond
/// du voisinage (section 6.3), encaissement et signalement d'anomalies.
class KiosqueDashboardScreen extends StatelessWidget {
  const KiosqueDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    return AutoLockScaffold(
      title: l.t('kiosque_fiche'),
      actions: const [LanguageSwitchButton()],
      child: BlocBuilder<AgentCubit, AgentState>(
        builder: (context, state) {
          if (state.loading) {
            return const Center(child: CircularProgressIndicator());
          }
          final fiche = state.fiche;
          if (fiche == null) {
            // État vide explicite (écran atteignable depuis les listes) avec
            // reprise : sans ça, l'agent voyait un écran blanc muet.
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.cloud_off, color: Colors.grey, size: 64),
                    const SizedBox(height: 12),
                    Text(
                      state.error ?? l.t('dash_empty'),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    if (state.kiosqueLocal != null)
                      ElevatedButton.icon(
                        onPressed: () => context
                            .read<AgentCubit>()
                            .loadKiosqueById(
                              state.kiosqueLocal!.codeKiosque,
                            ),
                        icon: const Icon(Icons.refresh),
                        label: Text(l.t('retry')),
                      ),
                  ],
                ),
              ),
            );
          }
          final principal = (fiche['kiosque_principal'] ?? {}) as Map;
          final sf = (principal['situation_fiscale'] ?? {}) as Map;
          final code = principal['code_kiosque']?.toString() ?? '';
          final couleur = _couleur(principal);
          final kiosqueLocal = state.kiosqueLocal;
          final session = context.read<AuthCubit>().state.session;

          return RefreshIndicator(
            onRefresh: () => context.read<AgentCubit>().loadKiosqueById(code),
            child: ListView(
              padding: const EdgeInsets.all(12),
              children: [
                _Header(code: code, couleur: couleur),
                const SizedBox(height: 10),
                StatusBanner(
                  couleur: couleur,
                  situationFiscale: Map<String, dynamic>.from(sf),
                ),
                const SizedBox(height: 10),
                _EtatsCroises(principal: principal, situation: sf),
                const SizedBox(height: 8),
                MenuCard(
                  icon: Icons.payments,
                  title: l.t('encaisse'),
                  subtitle: l.t('dash_cash'),
                  color: AppTheme.statutVert,
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => EncaissementScreen(
                        fiche: fiche,
                        kiosqueLocal: kiosqueLocal,
                      ),
                    ),
                  ),
                ),
                MenuCard(
                  icon: Icons.report_gmailerrorred,
                  title: l.t('report_anomaly'),
                  subtitle: l.t('anomaly_types'),
                  color: AppTheme.statutRouge,
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => AnomalieScreen(
                        fiche: fiche,
                        kiosqueLocal: kiosqueLocal,
                      ),
                    ),
                  ),
                ),
                MenuCard(
                  icon: Icons.qr_code_2,
                  title: l.t('kiosque_qr'),
                  subtitle: l.t('qr_subtitle'),
                  color: AppTheme.accentNavy,
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) =>
                          KiosqueQrScreen.fromFiche(fiche, kiosqueLocal),
                    ),
                  ),
                ),
                SectionTitle(
                  l.t('fiche_technique'),
                  icon: Icons.badge_outlined,
                ),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      children: [
                        InfoRow(
                          l.t('owner'),
                          principal['proprietaire_nom']?.toString() ?? '—',
                        ),
                        InfoRow(
                          l.t('dash_phone'),
                          principal['proprietaire_telephone']?.toString() ??
                              '—',
                        ),
                        InfoRow(
                          l.t('authorization'),
                          principal['autorisation_numero']?.toString() ?? '—',
                        ),
                        InfoRow(
                          l.t('dash_type'),
                          principal['type_identification']?.toString() ?? '—',
                        ),
                        InfoRow(
                          l.t('fokontany_list'),
                          principal['fokontany']?.toString() ?? '—',
                        ),
                        InfoRow(
                          l.t('operators_label'),
                          '${(principal['operations_actives'] ?? const [])}',
                        ),
                        InfoRow(
                          l.t('materials_label'),
                          principal['materiaux_construction']?.toString() ??
                              '—',
                        ),
                        InfoRow(
                          l.t('dimensions'),
                          '${principal['kiosque_longueur']} × ${principal['kiosque_largeur']} m',
                        ),
                        InfoRow(
                          l.t('occupation'),
                          principal['terrain_occupation']?.toString() ?? '—',
                        ),
                        InfoRow(
                          l.t('dash_general_state'),
                          principal['etat_general']?.toString() ?? '—',
                        ),
                        InfoRow(
                          l.t('dash_landmark'),
                          principal['emplacement_repere']?.toString() ?? '—',
                        ),
                      ],
                    ),
                  ),
                ),
                SectionTitle(l.t('etat_financier'), icon: Icons.receipt_long),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      children: [
                        InfoRow(
                          l.t('dash_auth_no'),
                          principal['autorisation_numero']?.toString() ?? '—',
                        ),
                        InfoRow(
                          l.t('dash_auth_date'),
                          principal['autorisation_date']?.toString() ?? '—',
                        ),
                        InfoRow(
                          l.t('dash_avis_no'),
                          principal['avis_paiement_numero']?.toString() ?? '—',
                        ),
                        InfoRow(
                          l.t('dash_quittance_no'),
                          principal['quittance_numero']?.toString() ?? '—',
                        ),
                        InfoRow(
                          l.t('dash_quittance_date'),
                          principal['quittance_date']?.toString() ?? '—',
                        ),
                        InfoRow(
                          l.t('dash_droit_stat'),
                          sf['statut_droit_installation']?.toString() ?? '—',
                        ),
                        InfoRow(
                          l.t('dash_taxe_stat'),
                          sf['statut_taxe_mensuelle']?.toString() ?? '—',
                        ),
                        if ((sf['mois_retard_calcules'] ?? 0) is num &&
                            (sf['mois_retard_calcules'] as num) > 0)
                          InfoRow(
                            l.t('dash_delay_months'),
                            '${sf['mois_retard_calcules']} ${l.t('months')}',
                          ),
                        if (couleur == StatutFiscalCouleur.rouge)
                          InfoRow(
                            l.t('dash_total_debt'),
                            '${sf['total_dette_ariary'] ?? 0} Ar',
                          ),
                      ],
                    ),
                  ),
                ),
                SectionTitle('GPS', icon: Icons.gps_fixed),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      children: [
                        RealMapView(
                          pins: [
                            MapPin(
                              point: LatLng(
                                _d(principal['gps_latitude']),
                                _d(principal['gps_longitude']),
                              ),
                              color: switch (couleur) {
                                StatutFiscalCouleur.vert => AppTheme.statutVert,
                                StatutFiscalCouleur.orange =>
                                  AppTheme.statutOrange,
                                StatutFiscalCouleur.rouge =>
                                  AppTheme.statutRouge,
                              },
                              label: '$code',
                              primary: true,
                            ),
                          ],
                          height: 220,
                        ),
                        const SizedBox(height: 6),
                        Text(
                          '${_d(principal['gps_latitude']).toStringAsFixed(6)}, '
                          '${_d(principal['gps_longitude']).toStringAsFixed(6)}',
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                if (state.voisins.isNotEmpty) ...[
                  SectionTitle(l.t('neighbors'), icon: Icons.location_on),
                  SizedBox(
                    height: 108,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 6),
                      children: state.voisins.map((v) {
                        return NeighbourCard(
                          voisin: v,
                          onTap: () {
                            final vCode = v['code_kiosque']?.toString() ?? '';
                            if (vCode.isNotEmpty) {
                              context.read<AgentCubit>().loadKiosqueById(vCode);
                            }
                          },
                        );
                      }).toList(),
                    ),
                  ),
                ],
                if (session != null &&
                    kiosqueLocal != null &&
                    kiosqueLocal.totalDetteAriary > 0)
                  Card(
                    color: Colors.amber.shade50,
                    child: ListTile(
                      leading: const Icon(
                        Icons.warning,
                        color: AppTheme.statutOrange,
                      ),
                      title: Text(
                        l.t(
                          'dash_encaisse_hint',
                          args: [kiosqueLocal.totalDetteAriary],
                        ),
                      ),
                      subtitle: Text(l.t('dash_offline_hint')),
                    ),
                  ),
                const SizedBox(height: 20),
              ],
            ),
          );
        },
      ),
    );
  }

  double _d(Object? o) {
    if (o is num) return o.toDouble();
    return double.tryParse('$o') ?? 0;
  }

  /// Règle de mapping (section 8.3) : statut_fiscal vers bannière couleur.
  StatutFiscalCouleur _couleur(Map principal) {
    final sf = (principal['situation_fiscale'] ?? {}) as Map;
    final droit = sf['statut_droit_installation']?.toString() ?? 'EN_ATTENTE';
    final taxe = sf['statut_taxe_mensuelle']?.toString() ?? 'REDEVABLE';
    if (droit == 'EN_ATTENTE') return StatutFiscalCouleur.orange;
    if (taxe == 'REDEVABLE') return StatutFiscalCouleur.rouge;
    return StatutFiscalCouleur.vert;
  }
}

class _Header extends StatelessWidget {
  final String code;
  final StatutFiscalCouleur couleur;
  const _Header({required this.code, required this.couleur});

  @override
  Widget build(BuildContext context) {
    final c = switch (couleur) {
      StatutFiscalCouleur.vert => AppTheme.statutVert,
      StatutFiscalCouleur.orange => AppTheme.statutOrange,
      StatutFiscalCouleur.rouge => AppTheme.statutRouge,
    };
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
            color: c.withOpacity(0.12),
            border: Border.all(color: c),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            '$code',
            style: TextStyle(
              color: c,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ),
        const Spacer(),
        Chip(label: Text('Mobile Money CUF2026')),
      ],
    );
  }
}

class _EtatsCroises extends StatelessWidget {
  final Map principal;
  final Map situation;
  const _EtatsCroises({required this.principal, required this.situation});

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    // Affichage croisé des références (section 6.2).
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Column(
          children: [
            _Ligne(
              l.t('authorization'),
              principal['autorisation_numero']?.toString() ?? '—',
              principal['autorisation_date']?.toString() ?? '',
            ),
            _Ligne(
              l.t('dash_case_current'),
              principal['dossier_encours_numero']?.toString() ?? '—',
              principal['dossier_encours_date']?.toString() ?? '',
            ),
            _Ligne(
              l.t('dash_avis'),
              principal['avis_paiement_numero']?.toString() ?? '—',
              principal['avis_paiement_date']?.toString() ?? '',
            ),
          ],
        ),
      ),
    );
  }
}

class _Ligne extends StatelessWidget {
  final String label;
  final String numero;
  final String date;
  const _Ligne(this.label, this.numero, this.date);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ),
          Expanded(
            child: Text(
              numero,
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
          ),
          if (date.isNotEmpty)
            Text(
              date,
              style: const TextStyle(fontSize: 11, color: Colors.grey),
            ),
        ],
      ),
    );
  }
}
