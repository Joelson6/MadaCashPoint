import 'package:cuf_recouvrement_mobile/core/db/local_store.dart';
import 'package:cuf_recouvrement_mobile/core/db/local_store_web.dart';
import 'package:cuf_recouvrement_mobile/core/localization/app_localizations.dart';
import 'package:cuf_recouvrement_mobile/core/security/auto_lock.dart';
import 'package:cuf_recouvrement_mobile/core/security/secure_store.dart';
import 'package:cuf_recouvrement_mobile/core/service/sync_service.dart';
import 'package:cuf_recouvrement_mobile/data/local/repositories/encaissement_repo.dart';
import 'package:cuf_recouvrement_mobile/data/local/repositories/kiosque_repo.dart';
import 'package:cuf_recouvrement_mobile/data/local/repositories/sync_queue_repo.dart';
import 'package:cuf_recouvrement_mobile/data/remote/embedded_backend.dart';
import 'package:cuf_recouvrement_mobile/features/agent/bloc/agent_cubit.dart';
import 'package:cuf_recouvrement_mobile/features/agent/presentation/agent_home_screen.dart';
import 'package:cuf_recouvrement_mobile/features/agent/presentation/kiosque_dashboard_screen.dart';
import 'package:cuf_recouvrement_mobile/features/auth/bloc/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Tableau de bord agent : la section **Recent** suit les décisions
/// (§ 4.4 instruction → § 6 fiche kiosque).
///
/// Régression corrigée : `deciderDossier` ne rechargeait que la liste
/// d'instruction ; `state.recents` n'était relu qu'une fois à la connexion
/// (garde `_loaded`), donc le kiosque né de l'approbation n'apparaissait
/// dans Recent qu'après reconnexion, sans aucun refresh manuel possible.
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late LocalStore store;
  late EmbeddedBackend backend;
  late KiosqueRepo kiosques;
  late SyncService sync;
  late AgentCubit cubit;

  const dossier = 'CUF2026-22189';
  const agent = '0340000001';
  const token = 'session-de-test';

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    await SecureStore.instance.init();
    store = MemoryLocalStore();
    backend = EmbeddedBackend(store, SecureStore.instance);
    kiosques = KiosqueRepo(store);
    sync = SyncService(SyncQueueRepo(store), backend);
    cubit = AgentCubit(backend, kiosques, EncaissementRepo(store), sync);
    await backend.provisionCitoyenDemo();
    await cubit.load();
  });

  tearDown(() async {
    await cubit.close();
    sync.dispose();
    // Coupe le minuteur de verrouillage auto éventuellement armé par un
    // test de widget (AutoLockScaffold) : aucun timer résiduel.
    AutoLockService.instance.shutdown();
  });

  Future<bool> approuver() => cubit.deciderDossier(
    codeDossier: dossier,
    decision: 'APPROUVE',
    note: '',
    agentTelephone: agent,
    sessionToken: token,
  );

  test("l'approbation fait apparaître le kiosque dans Recent sans "
      'reconnexion', () async {
    expect(
      cubit.state.recents.any((k) => k.dossierEncoursNumero == dossier),
      isFalse,
      reason: 'aucun kiosque avant la décision',
    );
    final avant = cubit.state.recents.length;

    final ok = await approuver();

    expect(ok, isTrue, reason: 'la décision est portée');
    expect(cubit.state.decisionMessage, isNotNull);

    final recents = cubit.state.recents;
    final neuf = recents.where((k) => k.dossierEncoursNumero == dossier);
    expect(
      neuf.length,
      1,
      reason: 'le kiosque créé par la décision est visible dans Recent',
    );
    expect(neuf.first.codeKiosque, isNotEmpty);
    expect(
      recents.first.dossierEncoursNumero,
      dossier,
      reason: 'Recent reste trié du plus récent au plus ancien',
    );
    expect(recents.length, avant + 1, reason: 'aucun doublon de kiosque');

    // La liste d'instruction est rafraîchie dans la foulée.
    final ligne = cubit.state.dossiers.firstWhere(
      (d) => d['code_dossier'] == dossier,
    );
    expect(ligne['statut'], 'APPROUVE');
  });

  test('un rechargement ultérieur (nouvelle visite de l\'écran) confirme la '
      'persistance du kiosque dans Recent', () async {
    await approuver();
    final codes = cubit.state.recents.map((k) => k.codeKiosque).toList();

    // Relit la base : la fiche y est bien persistée, pas seulement en mémoire.
    final relus = await kiosques.recent();
    expect(
      relus.map((k) => k.codeKiosque),
      codes,
      reason: 'Recent relu depuis le stockage local contient le nouveau kiosque',
    );
    expect(
      relus.first.dossierEncoursNumero,
      dossier,
      reason: 'le kiosque approuvé en tête de la liste',
    );
  });

  test('une décision refusée laisse les listes inchangées', () async {
    final recentsAvant = cubit.state.recents.map((k) => k.codeKiosque).toList();
    final dossiersAvant =
        cubit.state.dossiers.map((d) => d['code_dossier']).toList();

    final ok = await cubit.deciderDossier(
      codeDossier: dossier,
      decision: 'REJETE',
      note: '   ',
      agentTelephone: agent,
      sessionToken: token,
    );

    expect(ok, isFalse, reason: 'le motif est obligatoire');
    expect(cubit.state.decisionError, isNotNull);
    expect(cubit.state.decisionMessage, isNull);
    expect(
      cubit.state.recents.map((k) => k.codeKiosque),
      recentsAvant,
      reason: 'aucune décision partiellement appliquée',
    );
    expect(
      cubit.state.dossiers.map((d) => d['code_dossier']),
      dossiersAvant,
    );
    expect(cubit.state.loading, isFalse, reason: "l'indicateur se termine");
  });

  testWidgets(
    "Recent s'actualise à l'écran dès l'approbation, sans refresh manuel",
    (tester) async {
      tester.view.physicalSize = const Size(1100, 3400);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.reset);

      await SecureStore.instance.saveSession(
        telephone: agent,
        nom: 'AGENT COMMUNAL',
        role: 'agent',
        sessionToken: token,
      );
      final auth = AuthCubit(backend, SecureStore.instance)..restoreSession();

      Future<void> afficher() async {
        // Providers au-dessus du MaterialApp (montage réel de l'application).
        await tester.pumpWidget(
          MultiBlocProvider(
            providers: [
              BlocProvider.value(value: auth),
              BlocProvider.value(value: cubit),
            ],
            child: MaterialApp(
              localizationsDelegates: appLocalizationsDelegates,
              supportedLocales: AppLocalizations.supportedLocales,
              home: const AgentHomeScreen(),
            ),
          ),
        );
        for (var i = 0; i < 12; i++) {
          await tester.pump(const Duration(milliseconds: 50));
        }
      }

      await afficher();
      expect(tester.takeException(), isNull);
      expect(find.byType(AgentHomeScreen), findsOneWidget);
      expect(find.text('2D001'), findsOneWidget, reason: 'kiosque de '
          'référence déjà dans Recent');
      expect(
        find.text(dossier),
        findsNothing,
        reason: 'aucun kiosque pour le dossier avant la décision',
      );

      expect(await approuver(), isTrue);
      final neuf = cubit.state.recents.first.codeKiosque;
      await afficher();

      expect(
        find.text(neuf),
        findsOneWidget,
        reason: "le kiosque créé par l'approbation apparaît immédiatement "
            "dans Recent, sans fermer/réouvrir l'écran",
      );
      expect(
        find.text('2D001'),
        findsOneWidget,
        reason: 'les kiosques précédents restent affichés',
      );
      expect(tester.takeException(), isNull);

      // Navigation vers le kiosque depuis Recent.
      await tester.tap(find.widgetWithText(ListTile, neuf));
      for (var i = 0; i < 12; i++) {
        await tester.pump(const Duration(milliseconds: 50));
      }
      expect(
        find.byType(KiosqueDashboardScreen),
        findsOneWidget,
        reason: "le kiosque approuvé est ouvrable directement depuis Recent",
      );
      expect(tester.takeException(), isNull);

      // Démontage : annule le minuteur de verrouillage auto puis ferme l'auth.
      await tester.pumpWidget(const SizedBox());
      await tester.pump(const Duration(milliseconds: 50));
      await auth.close();
    },
  );
}
