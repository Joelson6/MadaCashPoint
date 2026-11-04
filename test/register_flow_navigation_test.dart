import 'dart:async';

import 'package:cuf_recouvrement_mobile/core/db/local_store_web.dart';
import 'package:cuf_recouvrement_mobile/core/di/service_locator.dart';
import 'package:cuf_recouvrement_mobile/features/auth/bloc/auth_cubit.dart';
import 'package:cuf_recouvrement_mobile/features/auth/presentation/auth_gate.dart';
import 'package:cuf_recouvrement_mobile/features/auth/presentation/login_screen.dart';
import 'package:cuf_recouvrement_mobile/features/agent/presentation/agent_home_screen.dart';
import 'package:cuf_recouvrement_mobile/features/agent/presentation/agent_profil_screen.dart';
import 'package:cuf_recouvrement_mobile/features/auth/presentation/register_screen.dart';
import 'package:cuf_recouvrement_mobile/features/citoyen/presentation/citoyen_home_screen.dart';
import 'package:cuf_recouvrement_mobile/data/remote/cuf_backend.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Back-end stub : isole la navigation (ce qui est réellement testé) de l'I/O
/// Isar du back-end embarqué.
class _StubBackend implements CufBackend {
  String? error;
  String? loginError;
  String? requestOtpError;
  int registerCalls = 0;

  /// Rôle renvoyé par la « Wortie ». Volontairement une variante non
  /// canonique : le routage RBAC ne doit pas dépendre de l'écriture exacte
  /// du site web CUF (voir `Roles.normalize`).
  String role = 'agent';

  @override
  Future<String> requestOtp(String telephone) async {
    if (requestOtpError != null) throw ArgumentError(requestOtpError!);
    return '123456';
  }

  @override
  Future<SessionInfo> userLogin(String telephone, String pin) async {
    if (loginError != null) throw ArgumentError(loginError!);
    return SessionInfo(
      telephone: '0340000001',
      nom: 'AGENT COMMUNAL',
      role: role,
      sessionToken: 'STUB-AGENT',
    );
  }

  @override
  Future<SessionInfo> verifyOtpAndRegister(Map<String, dynamic> payload) async {
    if (error != null) throw ArgumentError(error!);
    registerCalls++;
    return SessionInfo(
      telephone: '0341234567',
      nom: 'RASOLOARISOA Jean Claude',
      role: 'demandeur',
      sessionToken: 'STUB-TOKEN',
    );
  }

  @override
  dynamic noSuchMethod(Invocation invocation) =>
      throw UnimplementedError('${invocation.memberName} non utilisé');
}

Future<void> _pump(WidgetTester tester, [int frames = 10]) async {
  for (var i = 0; i < frames; i++) {
    await tester.pump(const Duration(milliseconds: 50));
  }
}

/// Parcours d'auto-inscription citoyen (section 4.2 du CDC).
///
/// Régression : `LoginScreen` pousse `RegisterScreen` avec `pushNamed` sur le
/// navigateur racine. Après `registerCitoyen`, `AuthState.session` est renseigné
/// et `AuthGate._home` bascule sur `CitoyenHomeScreen`, MAIS la route `/register`
/// reste empilée au-dessus : l'utilisateur reste bloqué sur le formulaire
/// d'inscription et ne voit jamais son espace citoyen.
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() async {
    SharedPreferences.setMockInitialValues({});
    // Magasin en mémoire : ces tests portent sur le ROUTAGE, pas sur Isar.
    // Une vraie base ne peut pas être fermée après un `testWidgets` — voir
    // `ServiceLocator.storeOverride`.
    ServiceLocator.storeOverride = () async => MemoryLocalStore();
    await ServiceLocator.instance.init();
  });

  tearDownAll(() async {
    ServiceLocator.storeOverride = null;
  });

  testWidgets(
    'inscription OTP : l\'espace citoyen remplace l\'écran d\'inscription',
    (tester) async {
      tester.view.physicalSize = const Size(1000, 2200);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.reset);

      final stub = _StubBackend();
      final sl = ServiceLocator.instance;

      await tester.pumpWidget(
        BlocProvider<AuthCubit>(
          create: (_) => AuthCubit(stub, sl.secureStore),
          child: const AuthGate(),
        ),
      );
      await _pump(tester);
      expect(find.byType(LoginScreen), findsOneWidget);

      // 1. Ouvrir l'auto-inscription depuis la connexion.
      await tester.tap(find.text('Créer un compte citoyen'));
      await _pump(tester);
      expect(find.byType(RegisterScreen), findsOneWidget);

      // 2. Pilotage du Cubit : c'est la navigation qui est testée, pas le
      //    back-end (démarré ici sans I/O via [_StubBackend]).
      final ctx = tester.element(find.byType(RegisterScreen));
      final cubit = BlocProvider.of<AuthCubit>(ctx);
      unawaited(cubit.requestOtp('0341234567'));
      await _pump(tester);
      expect(
        cubit.state.otpPending,
        isTrue,
        reason:
            'OTP demandé — état : ${cubit.state.otpPending} / '
            'loading=${cubit.state.loading} / error=${cubit.state.error}',
      );

      // 3. Création du compte.
      unawaited(
        cubit.registerCitoyen({
          'telephone': '0341234567',
          'otp': '123456',
          'pin': '1234',
          'nom': 'RASOLOARISOA Jean Claude',
          'prenom': 'Jean Claude',
        }),
      );
      await _pump(tester);
      await tester.pumpAndSettle();

      expect(stub.registerCalls, 1, reason: 'le compte doit être créé');
      expect(tester.takeException(), isNull);
      expect(
        find.byType(RegisterScreen),
        findsNothing,
        reason: 'la route /register doit être dépilée après inscription',
      );
      expect(
        find.byType(CitoyenHomeScreen),
        findsOneWidget,
        reason: 'l\'accueil citoyen doit être affiché après inscription',
      );
    },
  );

  testWidgets('connexion : l\'espace agent remplace l\'écran de connexion', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(1000, 2200);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);

    final stub = _StubBackend();
    final sl = ServiceLocator.instance;
    late AuthCubit cubit;

    await tester.pumpWidget(
      BlocProvider<AuthCubit>(
        create: (_) => cubit = AuthCubit(stub, sl.secureStore),
        child: const AuthGate(),
      ),
    );
    await _pump(tester);
    expect(find.byType(LoginScreen), findsOneWidget);

    unawaited(cubit.login('034 00 000 01', '1234'));
    await tester.pumpAndSettle();

    expect(cubit.state.isAuthenticated, isTrue);
    expect(
      cubit.state.isAgent,
      isTrue,
      reason: 'le rôle « ${stub.role} » doit être normalisé en agent',
    );
    expect(
      cubit.state.session!.role,
      Roles.agent,
      reason: 'la session conservée doit porter le rôle canonique',
    );
    expect(
      find.byType(AgentHomeScreen),
      findsOneWidget,
      reason: 'le rôle agent doit afficher l\'accueil agent',
    );
  });

  testWidgets(
    'déconnexion depuis le profil agent : retour automatique à la connexion',
    (tester) async {
      tester.view.physicalSize = const Size(1000, 2200);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.reset);

      final stub = _StubBackend();
      final sl = ServiceLocator.instance;
      late AuthCubit cubit;

      await tester.pumpWidget(
        BlocProvider<AuthCubit>(
          create: (_) => cubit = AuthCubit(stub, sl.secureStore),
          child: const AuthGate(),
        ),
      );
      await _pump(tester);

      unawaited(cubit.login('034 00 000 01', '1234'));
      await tester.pumpAndSettle();
      expect(find.byType(AgentHomeScreen), findsOneWidget);

      await tester.tap(find.byIcon(Icons.account_circle));
      await tester.pumpAndSettle();
      expect(find.byType(AgentProfilScreen), findsOneWidget);

      await tester.tap(find.text('Se déconnecter'));
      await tester.pumpAndSettle();

      expect(cubit.state.isAuthenticated, isFalse);
      expect(
        find.byType(AgentProfilScreen),
        findsNothing,
        reason: 'la route du profil doit être dépilée à la déconnexion',
      );
      expect(
        find.byType(LoginScreen),
        findsOneWidget,
        reason: 'la page de connexion doit être affichée automatiquement',
      );
    },
  );

  testWidgets('RBAC : toute variante du rôle agent ouvre l\'espace agent', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(1000, 2200);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);

    final sl = ServiceLocator.instance;

    // Le site web CUF n'emploie pas la même écriture partout (web, base,
    // import) : l'application doit router de façon identique.
    for (final variante in [
      'agent',
      'AGENT_COMMUNAL',
      'Agent Communal',
      'agent-communal',
    ]) {
      final stub = _StubBackend()..role = variante;
      late AuthCubit cubit;

      await tester.pumpWidget(
        BlocProvider<AuthCubit>(
          // `Key` indispensable : sans elle, `pumpWidget` met à jour l'élément
          // existant et `create` n'est rappelé qu'à la première itération.
          key: ValueKey(variante),
          create: (_) => cubit = AuthCubit(stub, sl.secureStore),
          child: const AuthGate(),
        ),
      );
      await _pump(tester);

      unawaited(cubit.login('034 00 000 01', '1234'));
      await tester.pumpAndSettle();

      expect(
        cubit.state.session!.role,
        Roles.agent,
        reason: '« $variante » doit se normaliser en ${Roles.agent}',
      );
      expect(
        find.byType(AgentHomeScreen),
        findsOneWidget,
        reason: '« $variante » doit ouvrir l\'espace agent',
      );

      await cubit.logout();
      await tester.pumpAndSettle();
    }
  });

  testWidgets(
    'inscription OTP : un code invalide laisse l\'écran d\'inscription',
    (tester) async {
      tester.view.physicalSize = const Size(1000, 2200);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.reset);

      final stub = _StubBackend()..error = 'Code OTP incorrect';
      final sl = ServiceLocator.instance;

      await tester.pumpWidget(
        BlocProvider<AuthCubit>(
          create: (_) => AuthCubit(stub, sl.secureStore),
          child: const AuthGate(),
        ),
      );
      await _pump(tester);

      await tester.tap(find.text('Créer un compte citoyen'));
      await _pump(tester);

      final ctx = tester.element(find.byType(RegisterScreen));
      final cubit = BlocProvider.of<AuthCubit>(ctx);
      unawaited(cubit.requestOtp('0341234567'));
      await _pump(tester);
      unawaited(
        cubit.registerCitoyen({
          'telephone': '0341234567',
          'otp': '123456',
          'pin': '1234',
          'nom': 'TEST CITOYEN',
          'prenom': 'TEST',
        }),
      );
      await _pump(tester);

      expect(stub.registerCalls, 0, reason: 'aucun compte ne doit être créé');
      expect(cubit.state.isAuthenticated, isFalse);
      expect(
        find.byType(RegisterScreen),
        findsOneWidget,
        reason: 'un échec doit maintenir l\'écran d\'inscription',
      );
      expect(find.byType(CitoyenHomeScreen), findsNothing);
    },
  );

  testWidgets(
    'inscription OTP : un numéro déjà utilisé reste sur le formulaire',
    (tester) async {
      tester.view.physicalSize = const Size(1000, 2200);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.reset);

      final stub = _StubBackend()
        ..requestOtpError =
            'Un compte existe déjà pour ce numéro. Connectez-vous.';
      final sl = ServiceLocator.instance;

      await tester.pumpWidget(
        BlocProvider<AuthCubit>(
          create: (_) => AuthCubit(stub, sl.secureStore),
          child: const AuthGate(),
        ),
      );
      await _pump(tester);

      await tester.tap(find.text('Créer un compte citoyen'));
      await _pump(tester);
      expect(find.byType(RegisterScreen), findsOneWidget);

      final ctx = tester.element(find.byType(RegisterScreen));
      final cubit = BlocProvider.of<AuthCubit>(ctx);
      unawaited(cubit.requestOtp('0341234567'));
      await _pump(tester);

      expect(cubit.state.isAuthenticated, isFalse);
      expect(cubit.state.otpPending, isFalse);
      expect(
        find.byType(RegisterScreen),
        findsOneWidget,
        reason: 'un numéro déjà utilisé ne doit pas quitter l\'inscription',
      );
      expect(
        find.text('Un compte existe déjà pour ce numéro. Connectez-vous.'),
        findsWidgets,
        reason: 'l\'erreur doit être affichée à l\'utilisateur',
      );
      expect(find.byType(LoginScreen), findsNothing);
      expect(find.byType(CitoyenHomeScreen), findsNothing);
    },
  );
}
