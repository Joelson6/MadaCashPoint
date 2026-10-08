import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/config/app_config.dart';
import '../../../core/di/service_locator.dart';
import '../../../core/localization/app_localizations.dart';
import '../../../core/security/auto_lock.dart';
import '../../../core/theme/app_theme.dart';
import '../../agent/bloc/agent_cubit.dart';
import '../../agent/presentation/agent_home_screen.dart';
import '../../citoyen/bloc/demande_cubit.dart';
import '../../citoyen/presentation/citoyen_home_screen.dart';
import '../../shared/widgets/shared_widgets.dart';
import '../bloc/auth_cubit.dart';
import '../bloc/auth_state.dart';
import 'login_screen.dart';
import 'register_screen.dart';

/// Porte d'entrée RBAC (section 4) :
/// - Fournit le Cubit métier (Agent ou Citoyen) AU-DESSUS du Navigator,
///   afin que toutes les routes poussées partagent la même instance.
/// - Construit le MaterialApp bilingue (FR / MG).
class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    final sl = ServiceLocator.instance;
    final auth = context.watch<AuthCubit>().state;

    // Providers du domaine selon le rôle.
    final provider = _featureProvider(sl, auth);

    return BlocListener<AuthCubit, AuthState>(
      // Déconnexion : on dépile explicitement jusqu'à la racine. Sans cela une
      // déconnexion déclenchée depuis un écran empilé (fiche kiosque, scan,
      // encaissement) laisserait cet écran au-dessus de l'écran de connexion.
      listenWhen: (prev, curr) => !prev.isAuthenticated && curr.loggedOut,
      listener: (context, _) {
        final nav = rootNavigatorKey.currentState;
        if (nav != null && nav.canPop()) {
          nav.popUntil((route) => route.isFirst);
        }
      },
      child: ValueListenableBuilder<Locale>(
        valueListenable: sl.localeController,
        builder: (context, locale, _) {
          final materialApp = MaterialApp(
            title: AppConfig.appName,
            debugShowCheckedModeBanner: false,
            // Clé du navigateur racine : requise par AutoLockService pour pousser
            // l'overlay de verrouillage au-dessus de toutes les routes (§ 4.3).
            navigatorKey: rootNavigatorKey,
            theme: AppTheme.light,
            locale: locale,
            // Inclut les delegates de repli 'mg' : sans eux, basculer en
            // malgache supprime MaterialLocalizations de l'arbre (écran vide).
            localizationsDelegates: appLocalizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            routes: {
              LoginScreen.route: (_) => const LoginScreen(),
              RegisterScreen.route: (_) => const RegisterScreen(),
              AgentHomeScreen.route: (_) => const AgentHomeScreen(),
              CitoyenHomeScreen.route: (_) => const CitoyenHomeScreen(),
            },
            // `ActivityListener` à la racine : TOUTE interaction utilisateur,
            // y compris sur un écran poussé (fiche kiosque, encaissement, scan),
            // réinitialise le verrouillage auto de 5 min (§ 4.3). Placé
            // seulement dans `AutoLockScaffold`, l'agent était verrouillé
            // alors qu'il travaillait sur un écran empilé.
            home: const ActivityListener(child: _AuthHome()),
          );

          final withProvider = provider?.call(materialApp);
          return withProvider ?? materialApp;
        },
      ),
    );
  }

  /// Écran racine de l'application.
  ///
  /// `WidgetsApp` ne lit `home` qu'au moment de CRÉER la route `/` : passer
  /// `home: _home(state)` à `MaterialApp` laissait donc l'écran de connexion
  /// affiché après connexion (le `Navigator` conservait l'ancienne page).
  /// Ce widget est donc À L'INTÉRIEUR de la route : il s'abonne à l'`AuthCubit`
  /// et se reconstruit seul au changement de rôle.
  ///
  /// Provider du Cubit métier selon le rôle ; null sinon.
  Widget Function(Widget child)? _featureProvider(
    ServiceLocator sl,
    AuthState state,
  ) {
    if (state.isAgent) {
      return (child) => BlocProvider(
        // `load()` est déclenché explicitement (jamais dans le
        // constructeur) pour ne pas lancer d'E/S Isar à la construction.
        create: (ctx) => AgentCubit(
          sl.backend,
          sl.kiosqueRepo,
          sl.encaissementRepo,
          sl.syncService,
        )..load(),
        child: child,
      );
    }
    if (state.isAuthenticated) {
      return (child) => BlocProvider(
        create: (ctx) =>
            DemandeCubit(sl.backend, sl.demandeRepo, sl.syncService),
        child: child,
      );
    }
    return null;
  }
}

/// Contenu de la route `/` : choisit l'écran selon l'état de la session.
class _AuthHome extends StatelessWidget {
  const _AuthHome();

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AuthCubit>().state;
    if (state.loading && state.session == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    if (!state.isAuthenticated) return const LoginScreen();
    if (state.isAgent) return const AgentHomeScreen();
    return const CitoyenHomeScreen();
  }
}
