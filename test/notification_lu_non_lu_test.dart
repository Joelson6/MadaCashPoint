import 'package:cuf_recouvrement_mobile/core/db/local_store_web.dart';
import 'package:cuf_recouvrement_mobile/core/di/service_locator.dart';
import 'package:cuf_recouvrement_mobile/core/localization/app_localizations.dart';
import 'package:cuf_recouvrement_mobile/core/security/secure_store.dart';
import 'package:cuf_recouvrement_mobile/core/service/notification_service.dart';
import 'package:cuf_recouvrement_mobile/features/auth/bloc/auth_cubit.dart';
import 'package:cuf_recouvrement_mobile/features/citoyen/bloc/demande_cubit.dart';
import 'package:cuf_recouvrement_mobile/features/citoyen/presentation/notifications_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Centre de notifications du citoyen : lu / non lu (section 12 du CDC).
///
/// Scénarios exigés :
///  1. non lue → ouverture → lue → fermeture / retour → toujours lue ;
///  2. persistance du statut lu (relu depuis [SecureStore]) ;
///  3. « tout lu » sans écrasement des identifiants déjà vus ;
///  4. compteur exact, cloisonnement par téléphone, identifiants uniques.
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  const tel = '0340000002';
  const autreTel = '0340000099';
  final service = NotificationService.instance;

  final dossiers = <Map<String, dynamic>>[
    {
      'code_dossier': 'CUF2026-22189',
      'nom_commercial': 'Kiosque Radius Tsaralalana',
      'statut': 'EN_COURS_INSTRUCTION',
      'date_soumission': '2026-09-28T10:00:00.000',
    },
    {
      'code_dossier': 'CUF2026-22145',
      'nom_commercial': 'Kiosque Mirindra',
      'statut': 'APPROUVE',
      'date_soumission': '2025-11-11T10:00:00.000',
    },
  ];

  final paiements = <Map<String, dynamic>>[
    {
      'type': 'DROIT_INSTALLATION',
      'code_dossier': 'CUF2026-22189',
      'nom_commercial': 'Kiosque Radius Tsaralalana',
      'statut': 'EN_ATTENTE',
      'montant': 150000,
      'date_paiement': '2026-10-01T09:00:00.000',
    },
    {
      'type': 'RENOUVELLEMENT',
      'code_dossier': '2D001',
      'statut': 'EN_RETARD',
      'montant_du': 100000,
      'annee': 2026,
      'date_paiement': '2026-10-02T09:00:00.000',
    },
    // Ligne d'historique fiscal dupliquée : même identifiant générée.
    {
      'type': 'RENOUVELLEMENT',
      'code_dossier': '2D001',
      'statut': 'A_JOUR',
      'montant_paye': 120000,
      'annee': 2025,
      'numero_quittance': 'QUIT-20251205-100234',
      'date_paiement': '2025-12-05T08:00:00.000',
    },
    {
      'type': 'RENOUVELLEMENT',
      'code_dossier': '2D001',
      'statut': 'A_JOUR',
      'montant_paye': 120000,
      'annee': 2025,
      'numero_quittance': 'QUIT-20251205-100234',
      'date_paiement': '2025-12-05T08:00:00.000',
    },
  ];

  setUpAll(() async {
    SharedPreferences.setMockInitialValues({});
    ServiceLocator.storeOverride = () async => MemoryLocalStore();
    await ServiceLocator.instance.init();
  });

  tearDownAll(() {
    ServiceLocator.storeOverride = null;
  });

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    await SecureStore.instance.init();
  });

  group('notifications dérivées', () {
    test('identifiants uniques : une ligne fiscale dupliquée ne produit pas '
        'deux cartes', () {
      final liste = service.build(tel, dossiers, paiements);
      final ids = liste.map((n) => n.id).toList();

      expect(ids.toSet().length, ids.length, reason: 'pas de doublon');
      expect(
        ids.where((id) => id == 'taxe-jour-2025-2D001').length,
        1,
        reason: 'la ligne répétée est dédupliquée',
      );
      expect(liste.length, 5, reason: '2 dossiers + droit + retard + à jour');
    });

    test('compteur de non-lus exact et cloisonné par téléphone', () {
      final liste = service.build(tel, dossiers, paiements);

      expect(service.unreadCount(tel, liste), liste.length);
      expect(
        service.unreadCount(autreTel, liste),
        liste.length,
        reason: 'aucun statut lu partagé entre deux numéros',
      );
    });
  });

  group('notifications persistantes', () {
    test('une ligne d\'anomalie répétée ne produit qu\'une seule carte', () {
      final anomalie = <String, dynamic>{
        'id_unique': 'anomalie-AN-12345',
        'type': 'ANOMALIE_SIGNALLEE',
        'code_kiosque': 'K-001',
        'type_anomalie': 'NON_CONFORMITE',
        'message_agent': 'Kiosque non conforme',
        'reference_anomalie': 'AN-12345',
        'date': '2026-10-01T09:00:00.000',
        'lu': false,
        'important': true,
      };

      final liste = service.buildComplet(tel, const [], const [], [
        anomalie,
        anomalie,
      ]);

      expect(liste.length, 1, reason: 'pas de doublon dans la liste');
      expect(liste.single.id, 'anomalie-AN-12345');
    });
  });

  group('lu / non lu', () {
    test("non lue → ouverture → lue ; retour à la liste → toujours lue",
        () async {
      final liste = service.build(tel, dossiers, paiements);
      final ouverte = liste.first;
      expect(service.unreadCount(tel, liste), liste.length);

      await service.markSeenId(tel, ouverte.id);

      // Retour sur la liste : la liste est reconstruite par `build()`.
      final retour = service.build(tel, dossiers, paiements);
      expect(service.seenIds(tel), contains(ouverte.id));
      expect(
        service.unreadCount(tel, retour),
        retour.length - 1,
        reason: 'seule la notification ouverte est passée à lue',
      );
      final memeCarte = retour.firstWhere((n) => n.id == ouverte.id);
      expect(memeCarte.message, ouverte.message);
      expect(memeCarte.date, ouverte.date);
      expect(
        memeCarte.id,
        ouverte.id,
        reason: 'la carte reste présente, simplement marquée lue',
      );
    });

    test('le statut lu survit à un redémarrage (relecture du stockage)',
        () async {
      final liste = service.build(tel, dossiers, paiements);
      final id = liste.first.id;
      await service.markSeenId(tel, id);

      final prefs = await SharedPreferences.getInstance();
      final stocke = prefs.getStringList('notifications.seen.$tel');
      expect(stocke, contains(id));

      // Redémarrage : même stockage, nouvelle instance de préférences.
      SharedPreferences.setMockInitialValues({
        'notifications.seen.$tel': stocke!,
      });
      await SecureStore.instance.init();

      expect(service.seenIds(tel), contains(id));
      expect(
        service.unreadCount(tel, service.build(tel, dossiers, paiements)),
        liste.length - 1,
        reason: 'la notification lue reste lue après le redémarrage',
      );
    });

    test('« tout lu » n’efface pas un identifiant déjà vu hors de la liste '
        'courante', () async {
      final liste = service.build(tel, dossiers, paiements);
      final cible = liste.first;
      await service.markSeenId(tel, cible.id);

      // Liste partiellement chargée : `markSeen` doit faire l'union.
      await service.markSeen(tel, []);

      expect(
        service.seenIds(tel),
        contains(cible.id),
        reason: 'union avec les identifiants déjà vus, jamais remplacement',
      );

      await service.markSeen(tel, service.build(tel, dossiers, paiements));
      expect(
        service.unreadCount(tel, service.build(tel, dossiers, paiements)),
        0,
        reason: '« tout lu » vide le compteur sans rien perdre',
      );
    });
  });

  testWidgets(
    "ouverture depuis la liste : non lue → lue, et toujours lue au retour",
    (tester) async {
      final sl = ServiceLocator.instance;
      await sl.secureStore.saveSession(
        telephone: tel,
        nom: 'RASOANANDRASANA',
        role: 'demandeur',
        sessionToken: 'token-de-test',
      );
      final auth = AuthCubit(sl.backend, sl.secureStore)..restoreSession();
      final demandes = DemandeCubit(
        sl.backend,
        sl.demandeRepo,
        sl.syncService,
      );

      tester.view.physicalSize = const Size(1100, 3400);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.reset);

      Widget arbre() => MaterialApp(
        localizationsDelegates: appLocalizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: MultiBlocProvider(
          providers: [
            BlocProvider.value(value: auth),
            BlocProvider.value(value: demandes),
          ],
          child: const NotificationsScreen(),
        ),
      );

      Future<void> charger() async {
        await tester.pumpWidget(arbre());
        for (var i = 0; i < 12; i++) {
          await tester.pump(const Duration(milliseconds: 50));
        }
      }

      await charger();
      expect(tester.takeException(), isNull);

      final cartes =
          tester.widgetList<ListTile>(find.byType(ListTile)).toList();
      expect(cartes, isNotEmpty, reason: 'des notifications sont dérivées '
          'des dossiers et paiements du citoyen');
      final nonLuesAvant = cartes.where((t) => t.selected).length;
      expect(
        nonLuesAvant,
        cartes.length,
        reason: 'rien de lu à la connexion : tout est en non lue',
      );

      // 1. Ouverture : passage à lue (persistant) puis affichage du détail.
      await tester.tap(find.byType(ListTile).first);
      await charger();
      expect(
        find.byType(AlertDialog),
        findsOneWidget,
        reason: 'le détail de la notification ouverte s\'affiche',
      );

      await tester.tap(find.widgetWithText(TextButton, 'OK'));
      await charger();
      expect(find.byType(AlertDialog), findsNothing, reason: 'retour liste');

      final apres =
          tester.widgetList<ListTile>(find.byType(ListTile)).toList();
      expect(
        apres.where((t) => t.selected).length,
        nonLuesAvant - 1,
        reason: 'seule la notification ouverte est passée à lue',
      );
      expect(
        sl.secureStore.getSeenNotifications(tel),
        isNotEmpty,
        reason: 'le statut lu est persisté, pas seulement visuel',
      );

      // 2. Fermeture puis retour : l'écran est reconstruit de zéro.
      await tester.pumpWidget(const SizedBox());
      await charger();
      expect(find.byType(ListTile), findsWidgets);

      final retour =
          tester.widgetList<ListTile>(find.byType(ListTile)).toList();
      expect(
        retour.where((t) => t.selected).length,
        nonLuesAvant - 1,
        reason: 'fermeture puis retour : le statut lu est conservé',
      );
      expect(tester.takeException(), isNull);
    },
  );
}
