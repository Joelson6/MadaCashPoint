import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/localization/app_localizations.dart';
import '../../../core/di/service_locator.dart';
import '../../../core/security/auto_lock.dart';
import '../../../core/theme/app_theme.dart';
import '../../shared/widgets/shared_widgets.dart';
import '../../auth/bloc/auth_cubit.dart';
import '../bloc/agent_cubit.dart';

/// Écran « Profil » de l'agent communal : identité de la session en cours,
/// langue de l'état local, état du cache et sortie de session.
///
/// Auparavant l'agent n'avait aucun écran pour vérifier qui était connecté ni
/// pour changer de langue depuis l'intérieur de l'application.
class AgentProfilScreen extends StatelessWidget {
  const AgentProfilScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final session = context.read<AuthCubit>().state.session;
    final agent = context.watch<AgentCubit>().state;

    return AutoLockScaffold(
      title: l.t('profile_title'),
      actions: const [LanguageSwitchButton()],
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: Column(
              children: [
                const SizedBox(height: 16),
                const CircleAvatar(
                  radius: 34,
                  backgroundColor: AppTheme.accentNavy,
                  child: Icon(Icons.shield, color: Colors.white, size: 34),
                ),
                const SizedBox(height: 10),
                Text(
                  session?.nom ?? '',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                _Ligne(label: l.t('phone_label'), valeur: session?.telephone ?? '—'),
                _Ligne(label: l.t('profile_role'), valeur: session?.role ?? '—'),
                _Ligne(
                  label: l.t('profile_token'),
                  valeur: _court(session?.sessionToken),
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
                  child: Text(
                    l.t('profile_cache_section'),
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      color: AppTheme.primaryNavy,
                    ),
                  ),
                ),
                ListTile(
                  dense: true,
                  leading: const Icon(Icons.storage),
                  title: Text(
                    l.t('agent_cache_count', args: [agent.recents.length]),
                  ),
                  subtitle: Text(l.t('agent_cache')),
                ),
                ListTile(
                  dense: true,
                  leading: const Icon(Icons.cloud_upload),
                  title: Text('${agent.pendingSync} ${l.t('pending_sync')}'),
                ),
              ],
            ),
          ),
          Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
                  child: Text(
                    l.t('language'),
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      color: AppTheme.primaryNavy,
                    ),
                  ),
                ),
                const ListTile(
                  leading: Icon(Icons.language),
                  title: _ChoixLangue(),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () => context.read<AuthCubit>().logout(),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.statutRouge,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              icon: const Icon(Icons.logout),
              label: Text(l.t('logout')),
            ),
          ),
        ],
      ),
    );
  }

  static String _court(String? s) {
    if (s == null || s.isEmpty) return '—';
    if (s.length <= 20) return s;
    return '${s.substring(0, 20)}…';
  }
}

class _Ligne extends StatelessWidget {
  const _Ligne({required this.label, required this.valeur});

  final String label;
  final String valeur;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 130,
            child: Text(
              label,
              style: TextStyle(color: Colors.grey.shade700),
            ),
          ),
          Expanded(child: Text(valeur, style: const TextStyle(fontWeight: FontWeight.w500))),
        ],
      ),
    );
  }
}

class _ChoixLangue extends StatelessWidget {
  const _ChoixLangue();

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: ['fr', 'mg'].map((code) {
        final actif = l.locale.languageCode == code;
        return TextButton.icon(
          onPressed: actif
              ? null
              : () {
                  final sl = ServiceLocator.instance;
                  sl.localeController.value = Locale(code);
                  sl.secureStore.setLanguage(code);
                },
          icon: Icon(
            actif ? Icons.radio_button_checked : Icons.radio_button_off,
            size: 18,
          ),
          label: Text(
            code == 'fr' ? l.t('fr') : l.t('mg'),
            style: TextStyle(
              fontWeight: actif ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        );
      }).toList(),
    );
  }
}
