import 'package:cuf_recouvrement_mobile/core/db/local_store_web.dart';
import 'package:cuf_recouvrement_mobile/core/di/service_locator.dart';
import 'package:cuf_recouvrement_mobile/core/localization/app_localizations.dart';
import 'package:cuf_recouvrement_mobile/data/local/repositories/demande_repo.dart';
import 'package:cuf_recouvrement_mobile/data/local/repositories/kiosque_repo.dart';
import 'package:cuf_recouvrement_mobile/data/remote/embedded_backend.dart';
import 'package:cuf_recouvrement_mobile/features/agent/bloc/agent_cubit.dart';
import 'package:cuf_recouvrement_mobile/features/agent/presentation/dossier_detail_screen.dart';
import 'package:cuf_recouvrement_mobile/features/agent/presentation/dossiers_screen.dart';
import 'package:cuf_recouvrement_mobile/features/auth/bloc/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Parcours agent : liste d'instruction → dossier → décision (§ 4.4).
///
/// Régression : la décision n'existait pas (aucun écran, aucune méthode de
/// back-end). Ici sont vérifiés le motif obligatoire, l'émission de la
/// décision et l'apparition du kiosque créé à l'approbation.
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  const dossier = 'CUF2026-22189';

  setUpAll(() async {
    SharedPreferences.setMockInitialValues({});
    ServiceLocator.storeOverride = () async => MemoryLocalStore();
    await ServiceLocator.instance.init();
    await (ServiceLocator.instance.backend as EmbeddedBackend)
        .provisionCitoyenDemo();
  });

  tearDownAll(() async {
    ServiceLocator.storeOverride = null;
  });

  /// Remet le dossier de test dans son état d'origine : un test ne doit pas
  /// conditionner le suivant (rejet / approbation modifient le même dossier).
  Future<void> resetDossier() async {
    final sl = ServiceLocator.instance;
    final d = await DemandeRepo(sl.store).byCode(dossier);
    d!
      ..statut = 'EN_COURS_INSTRUCTION'
      ..noteRejet = '';
    await DemandeRepo(sl.store).put(d);
    for (final k in await KiosqueRepo(sl.store).all()) {
      if (k.dossierEncoursNumero == dossier) {
        await KiosqueRepo(sl.store).remove(k.codeKiosque);
      }
    }
  }

  Future<void> _pump(WidgetTester tester, [int frames = 12]) async {
    for (var i = 0; i < frames; i++) {
      await tester.pump(const Duration(milliseconds: 50));
    }
  }

  Future<void> _ouvrir(
    WidgetTester tester,
    Widget ecran,
  ) async {
    tester.view.physicalSize = const Size(1100, 3400);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);

    final sl = ServiceLocator.instance;
    // Providers AU-DESSUS du MaterialApp : c'est le montage réel (AuthGate
    // enveloppe le MaterialApp), et les routes poussées par Navigator — donc
    // aussi DossierDetailScreen — doivent y accéder.
    await tester.pumpWidget(
      MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => AuthCubit(sl.backend, sl.secureStore),
          ),
          BlocProvider(
            create: (_) => AgentCubit(
              sl.backend,
              sl.kiosqueRepo,
              sl.encaissementRepo,
              sl.syncService,
            ),
          ),
        ],
        child: MaterialApp(
          localizationsDelegates: appLocalizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: ecran,
        ),
      ),
    );
    await tester.pump(const Duration(milliseconds: 80));
    await tester.pumpAndSettle();
  }

  testWidgets("la liste d'instruction affiche les dossiers de la commune et "
      'ouvre le détail', (tester) async {
    await resetDossier();
    await _ouvrir(tester, const DossiersScreen());

    expect(find.text(dossier), findsOneWidget);
    expect(find.text('CUF2026-22145'), findsOneWidget);
    expect(
      find.textContaining('en attente de décision'),
      findsWidgets,
      reason: 'bandeau de synthèse',
    );

    await tester.tap(find.text(dossier));
    await _pump(tester);

    expect(find.byType(DossierDetailScreen), findsOneWidget);
    expect(find.text('Identité du demandeur'), findsOneWidget);
    expect(find.text('RASOANANDRASANA Claire'), findsWidgets);
    expect(find.text('Approuver'), findsOneWidget);
    expect(find.text('Demander des corrections'), findsOneWidget);
    expect(find.text('Rejeter'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('filtre : seuls les dossiers du statut choisi restent', (
    tester,
  ) async {
    await resetDossier();
    await _ouvrir(tester, const DossiersScreen());

    await tester.tap(find.text('Rejeté'));
    await _pump(tester);
    expect(find.text('CUF2026-22145'), findsNothing);
    expect(find.text(dossier), findsNothing);
    expect(find.text('Aucun dossier dans ce filtre'), findsOneWidget);

    await tester.tap(find.text('Approuvé'));
    await _pump(tester);
    expect(find.text('CUF2026-22145'), findsOneWidget);
    expect(find.text(dossier), findsNothing);
  });

  testWidgets('rejet : le motif est obligatoire, puis la décision s\'applique',
      (tester) async {
    await resetDossier();
    await _ouvrir(tester, DossierDetailScreen(codeDossier: dossier));

    await tester.tap(find.widgetWithText(OutlinedButton, 'Rejeter'));
    await _pump(tester);

    // Confirmation sans motif : rien n'est émis.
    await tester.tap(find.widgetWithText(FilledButton, 'Confirmer'));
    await _pump(tester);
    expect(find.text('Ce motif est obligatoire.'), findsOneWidget);
    expect(find.byType(AlertDialog), findsOneWidget);

    // Avec motif : le dossier passe en REJETE.
    await tester.enterText(
      find.byType(TextField),
      'Emplacement en zone inondable',
    );
    await tester.tap(find.widgetWithText(FilledButton, 'Confirmer'));
    await tester.pumpAndSettle();

    expect(find.byType(AlertDialog), findsNothing);
    expect(find.textContaining('Dossier rejeté'), findsOneWidget);
    expect(
      find.textContaining('Emplacement en zone inondable'),
      findsWidgets,
      reason: 'le motif reste affiché sur la fiche',
    );

    final d = await DemandeRepo(
      ServiceLocator.instance.store,
    ).byCode(dossier);
    expect(d?.statut, 'REJETE');
    expect(d?.noteRejet, 'Emplacement en zone inondable');
    expect(tester.takeException(), isNull);
  });

  testWidgets('approbation : la fiche kiosque naît et s\'affiche', (
    tester,
  ) async {
    await resetDossier();
    final kiosquesAvant = (await KiosqueRepo(
      ServiceLocator.instance.store,
    ).all()).length;

    await _ouvrir(tester, DossierDetailScreen(codeDossier: dossier));

    await tester.tap(find.widgetWithText(FilledButton, 'Approuver'));
    await _pump(tester);

    // Le dialogue de confirmation porte le même libellé que le bouton.
    final dialogue = find.byType(AlertDialog);
    expect(dialogue, findsOneWidget);
    // Le dialogue préfixe le libellé par le numéro de dossier.
    expect(
      find.descendant(
        of: dialogue,
        matching: find.textContaining(
          'La fiche kiosque sera créée automatiquement : le kiosque devient '
          'scannable et le droit d\'installation devient exigible.',
        ),
      ),
      findsOneWidget,
    );
    await tester.tap(
      find.descendant(of: dialogue, matching: find.text('Approuver')),
    );
    await tester.pumpAndSettle();

    expect(find.textContaining('kiosque'), findsWidgets);
    expect(find.textContaining('Dossier approuvé'), findsOneWidget);

    final kiosques = await KiosqueRepo(
      ServiceLocator.instance.store,
    ).all();
    expect(kiosques.length, kiosquesAvant + 1, reason: 'kiosque créé');
    final neuf = kiosques.firstWhere((k) => k.dossierEncoursNumero == dossier);
    expect(
      neuf.statutDroitInstallation,
      'EN_ATTENTE',
      reason: "le droit d'installation reste à encaisser (§ 7.2)",
    );

    final d = await DemandeRepo(
      ServiceLocator.instance.store,
    ).byCode(dossier);
    expect(d?.statut, 'APPROUVE');
    expect(tester.takeException(), isNull);
  });

  testWidgets('corrections : la consigne est obligatoire et revient au '
      'demandeur', (tester) async {
    await resetDossier();
    await _ouvrir(tester, DossierDetailScreen(codeDossier: dossier));

    await tester.tap(
      find.widgetWithText(OutlinedButton, 'Demander des corrections'),
    );
    await _pump(tester);

    await tester.tap(find.widgetWithText(FilledButton, 'Confirmer'));
    await _pump(tester);
    expect(find.text('Ce motif est obligatoire.'), findsOneWidget);

    await tester.enterText(
      find.byType(TextField),
      'Compléter la photo de l\'emplacement',
    );
    await tester.tap(find.widgetWithText(FilledButton, 'Confirmer'));
    await tester.pumpAndSettle();

    expect(find.textContaining('Corrections demandées'), findsOneWidget);

    final d = await DemandeRepo(
      ServiceLocator.instance.store,
    ).byCode(dossier);
    expect(d?.statut, 'EN_COURS_INSTRUCTION');
    expect(d?.noteRejet, 'Compléter la photo de l\'emplacement');
    expect(tester.takeException(), isNull);
  });
}
