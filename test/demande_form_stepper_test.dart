import 'package:cuf_recouvrement_mobile/core/config/app_config.dart';
import 'package:cuf_recouvrement_mobile/core/db/local_store_web.dart';
import 'package:cuf_recouvrement_mobile/core/di/service_locator.dart';
import 'package:cuf_recouvrement_mobile/core/localization/app_localizations.dart';
import 'package:cuf_recouvrement_mobile/core/security/secure_store.dart';
import 'package:cuf_recouvrement_mobile/features/auth/bloc/auth_cubit.dart';
import 'package:cuf_recouvrement_mobile/features/citoyen/bloc/demande_cubit.dart';
import 'package:cuf_recouvrement_mobile/features/citoyen/presentation/demande_form_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> _pump(WidgetTester tester, [int frames = 10]) async {
  for (var i = 0; i < frames; i++) {
    await tester.pump(const Duration(milliseconds: 50));
  }
}

/// Ouvre le formulaire 3 étapes et renvoie son cubit.
Future<DemandeCubit> _ouvrir(WidgetTester tester) async {
  tester.view.physicalSize = const Size(1200, 2600);
  tester.view.devicePixelRatio = 1.0;
  addTearDown(tester.view.reset);

  // Chaque test repart d'un formulaire vierge : le brouillon devenu
  // persistant (étape 3 atteinte au test précédent) ferait ouvrir le
  // formulaire sur une autre étape.
  await SecureStore.instance.clearDraftDemande();

  final sl = ServiceLocator.instance;
  await tester.pumpWidget(
    MaterialApp(
      localizationsDelegates: appLocalizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => AuthCubit(sl.backend, sl.secureStore)),
          BlocProvider(
            create: (_) =>
                DemandeCubit(sl.backend, sl.demandeRepo, sl.syncService),
          ),
        ],
        child: const DemandeFormScreen(),
      ),
    ),
  );
  await _pump(tester);
  return tester.element(find.byType(DemandeFormScreen)).read<DemandeCubit>();
}

/// Indices des `TextFormField` dans l'arbre (toutes les étapes sont
/// construites) : 0 nom, 1 CIN, 2 date CIN, 3 lieu CIN, 4 quartier,
/// 5 nom commercial, 6 longueur, 7 largeur, 8 emplacement.
Future<void> _remplirEtape0(WidgetTester tester) async {
  final cubit = tester
      .element(find.byType(DemandeFormScreen))
      .read<DemandeCubit>();
  final champs = find.byType(TextFormField);
  await tester.enterText(champs.at(0), 'RASOLOARISON Jean Claude');
  await tester.enterText(champs.at(1), '201012345678');
  cubit.setField('cin_date', '2020-03-15');
  await tester.enterText(champs.at(3), 'Fianarantsoa');
  await tester.enterText(champs.at(4), 'Ambohijatovo');
}

/// Coherence métier de l'étape 2, sans opérateur volontairement.
Future<void> _remplirEtape1(
  WidgetTester tester,
  DemandeCubit cubit, {
  bool avecOperateurs = true,
}) async {
  final champs = find.byType(TextFormField);
  await tester.enterText(champs.at(5), 'Kiosque Mirindra');
  await tester.enterText(champs.at(6), '3');
  await tester.enterText(champs.at(7), '2');
  cubit.setField('type_identification', AppConfig.typeIndividuel);
  cubit.setField(
    'materiaux_construction',
    AppConfig.materiauxConstructions.first,
  );
  if (avecOperateurs) {
    cubit.setField('operateurs', [AppConfig.operateurs.first]);
  }
}

Finder _boutonSoumettre() =>
    find.widgetWithText(FilledButton, 'Soumettre ma demande');

/// Formulaire séquentiel en 3 étapes (section 5.1 du CDC).
///
/// Régression : `GlobalKey<FormState>` identique sur plusieurs `Form` →
/// « Duplicate GlobalKey detected in widget tree » et l'écran ne s'affiche pas.
/// Chaque étape a donc SA propre clé (étapes 0, 1 et 2).
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() async {
    SharedPreferences.setMockInitialValues({});
    // Magasin en mémoire : `Isar.close()` ne peut pas s'exécuter après un
    // `testWidgets` (transactions suspendues dans la zone FakeAsync) — voir
    // `ServiceLocator.storeOverride`.
    ServiceLocator.storeOverride = () async => MemoryLocalStore();
    await ServiceLocator.instance.init();
  });

  tearDownAll(() async {
    ServiceLocator.storeOverride = null;
  });

  testWidgets(
    'formulaire 3 étapes : se construit sans exception (3 Form distincts)',
    (tester) async {
      await _ouvrir(tester);

      expect(
        tester.takeException(),
        isNull,
        reason: 'aucun GlobalKey dupliqué ni erreur de build',
      );
      expect(find.byType(DemandeFormScreen), findsOneWidget);

      // Les 3 étapes du Stepper sont présentes.
      expect(find.text('Identité du demandeur'), findsOneWidget);
      expect(find.text('Spécificités du kiosque'), findsOneWidget);
      expect(find.text('Implantation géographique'), findsOneWidget);
    },
  );

  testWidgets(
    'étape 3 : soumission bloquée, avec la liste des prérequis manquants',
    (tester) async {
      final cubit = await _ouvrir(tester);
      cubit.nextStep();
      cubit.nextStep();
      await _pump(tester);

      expect(_boutonSoumettre(), findsOneWidget);
      expect(
        tester.widget<FilledButton>(_boutonSoumettre()).onPressed,
        isNull,
        reason: 'GPS, zone et photo manquent : le bouton reste inactif',
      );

      // Le motif du blocage est AFFICHÉ : un bouton grisé doit s'expliquer.
      expect(find.textContaining('Avant l\'envoi'), findsOneWidget);
      expect(find.textContaining('Capturer la position GPS'), findsWidgets);
      expect(
        find.textContaining('Photo de l\'emplacement obligatoire'),
        findsWidgets,
      );
      expect(find.textContaining('Champ obligatoire'), findsWidgets);
    },
  );

  testWidgets(
    'étape 3 : l\'emplacement est obligatoire et suffisamment détaillé',
    (tester) async {
      final cubit = await _ouvrir(tester);

      // Prérequis métier (GPS réel, zone autorisée du serveur embarqué, photo).
      cubit.setGps(-21.13, 47.06);
      await cubit.checkLocationAllowance();
      expect(
        cubit.state.geoAllowed,
        isTrue,
        reason: 'hors des zones interdites du serveur embarqué',
      );
      cubit.setField('photo_emplacement', 'photo_emplacement.jpg');

      await _remplirEtape0(tester);
      cubit.setField('fokontany', 'Andrainjato');
      cubit
          .nextStep(); // étape 2 : ses champs ne sont saisis qu'une fois actifs
      await _pump(tester);
      await _remplirEtape1(tester, cubit);
      cubit.nextStep(); // étape 3
      await _pump(tester);

      expect(
        tester.widget<FilledButton>(_boutonSoumettre()).onPressed,
        isNotNull,
        reason: 'tous les prérequis sont réunis : le bouton s\'active',
      );

      // Emplacement vide → rien n'est envoyé (message en clair + erreur sous
      // le champ).
      await tester.tap(_boutonSoumettre());
      await _pump(tester);
      expect(find.textContaining('Décrivez l\'emplacement'), findsWidgets);
      expect(cubit.state.submitting, isFalse);
      expect(cubit.state.success, isFalse);

      // Emplacement trop court → même refus.
      await tester.enterText(find.byType(TextFormField).at(8), 'troc');
      await tester.pump();
      await tester.tap(_boutonSoumettre());
      await _pump(tester);
      expect(cubit.state.submitting, isFalse);
      expect(cubit.state.success, isFalse);
    },
  );

  testWidgets(
    'étape 2 : sans opérateur, « Suivant » n\'avance pas et le message nomme le problème',
    (tester) async {
      final cubit = await _ouvrir(tester);

      await _remplirEtape0(tester);
      cubit.setField('fokontany', 'Andrainjato');
      await _pump(tester);

      await tester.tap(find.text('Suivant').first);
      await _pump(tester);
      expect(cubit.state.step, 1);

      // Étape 2 complète SAUF les opérateurs (coherence métier, hors Form).
      await _remplirEtape1(tester, cubit, avecOperateurs: false);
      await _pump(tester);

      await tester.tap(find.text('Suivant').first);
      await _pump(tester);

      expect(cubit.state.step, 1, reason: 'étape 2 non validée');
      expect(find.text('Sélectionnez au moins un opérateur'), findsOneWidget);
    },
  );
}
