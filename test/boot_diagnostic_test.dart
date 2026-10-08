import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:cuf_recouvrement_mobile/core/localization/app_localizations.dart';
import 'package:cuf_recouvrement_mobile/main.dart';

/// Tests de garde du chemin de démarrage (§ 6 et § 20 de l'audit).
///
/// Régression : `runApp(BootScreen)` plaçait un `Scaffold` (et appelait
/// `Navigator.of`) sans `MaterialApp` / `WidgetsApp` au-dessus. `runApp` ne
/// fournit que `View > MediaQuery > FocusTraversalGroup` : ni Directionality,
/// ni MaterialLocalizations, ni Navigator. Le build échouait et la fenêtre
/// Android restait entièrement blanche.
void main() {
  testWidgets(
    'Démarrage : la racine se construit sans exception (écran non blanc)',
    (tester) async {
      await tester.pumpWidget(const CufRoot());
      await tester.pump();

      expect(
        tester.takeException(),
        isNull,
        reason: 'la racine doit fournir MaterialApp/Directionality/Navigator',
      );
      expect(find.byType(MaterialApp), findsOneWidget);
      expect(find.byType(Scaffold), findsWidgets);
    },
  );

  testWidgets('Démarrage : l\'écran d\'erreur d\'initialisation est lisible', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: BootScreen(error: 'Isar indisponible', onRetry: () async {}),
      ),
    );
    await tester.pump();

    expect(tester.takeException(), isNull);
    expect(find.text('Échec du démarrage'), findsOneWidget);
    expect(find.text('Isar indisponible'), findsOneWidget);
    expect(find.text('Réessayer'), findsOneWidget);
  });

  testWidgets(
    'Démarrage : le bouton Réessayer est neutralisé pendant l\'amorçage',
    (tester) async {
      var retries = 0;
      await tester.pumpWidget(
        MaterialApp(
          home: BootScreen(
            error: 'Isar indisponible',
            busy: true,
            onRetry: () async => retries++,
          ),
        ),
      );
      await tester.pump();

      final button = tester.widget<FilledButton>(
        find.widgetWithText(FilledButton, 'Réessayer'),
      );
      expect(
        button.onPressed,
        isNull,
        reason: 'pas d\'initialisation concurrente pendant l\'amorçage',
      );

      await tester.tap(find.text('Réessayer'));
      await tester.pump();
      expect(retries, 0);
    },
  );

  testWidgets(
    'Démarrage : deux appuis rapides sur Réessayer = un seul amorçage',
    (tester) async {
      // Reproduit la machine à états de `_CufRootState` : `busy` est vrai tant
      // que l'amorçage est en cours, ce qui neutralise le bouton « Réessayer »
      // et empêche toute initialisation concurrente.
      var calls = 0;
      late StateSetter setOuter;
      await tester.pumpWidget(
        MaterialApp(
          home: StatefulBuilder(
            builder: (context, setState) {
              setOuter = setState;
              return BootScreen(
                error: 'Isar indisponible',
                busy: calls > 0,
                onRetry: () async {
                  calls++;
                  setState(() {});
                  await Future<void>.delayed(const Duration(milliseconds: 50));
                  setState(() {});
                },
              );
            },
          ),
        ),
      );
      await tester.pump();

      final button = tester.widget<FilledButton>(
        find.widgetWithText(FilledButton, 'Réessayer'),
      );
      expect(button.onPressed, isNotNull);

      await tester.tap(find.text('Réessayer'));
      await tester.pump();
      await tester.tap(find.text('Réessayer'));
      await tester.pump();
      expect(
        calls,
        1,
        reason: 'le second appui est neutralisé (bouton désactivé)',
      );

      await tester.pump(const Duration(milliseconds: 60));
      setOuter(() {});
      expect(tester.takeException(), isNull);
    },
  );

  testWidgets('Localisations : FR et MG fournissent MaterialLocalizations', (
    tester,
  ) async {
    for (final lang in const ['fr', 'mg']) {
      await tester.pumpWidget(
        MaterialApp(
          locale: Locale(lang),
          supportedLocales: AppLocalizations.supportedLocales,
          localizationsDelegates: appLocalizationsDelegates,
          home: Builder(
            builder: (context) {
              final l = AppLocalizations.of(context);
              return Scaffold(
                appBar: AppBar(title: Text(l.t('app_name'))),
                body: Center(child: Text(l.t('login_btn'))),
              );
            },
          ),
        ),
      );
      await tester.pump();

      expect(tester.takeException(), isNull, reason: 'locale $lang');
      expect(
        find.text(AppLocalizations(Locale(lang)).t('login_btn')),
        findsOneWidget,
        reason: 'locale $lang',
      );
    }
  });
}
