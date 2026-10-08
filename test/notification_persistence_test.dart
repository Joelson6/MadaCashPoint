import 'package:cuf_recouvrement_mobile/core/db/local_store.dart';
import 'package:cuf_recouvrement_mobile/core/db/local_store_web.dart';
import 'package:cuf_recouvrement_mobile/core/security/auto_lock.dart';
import 'package:cuf_recouvrement_mobile/core/security/secure_store.dart';
import 'package:cuf_recouvrement_mobile/core/service/notification_service.dart';
import 'package:cuf_recouvrement_mobile/data/remote/embedded_backend.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Section 6.5 : une anomalie signalée par l'Agent Communal devient une
/// notification **persistante** du Demandeur concerné.
///
/// Le cycle démontré :
///  - signaler_anomalie écrit une ligne NotificationItem en base (Isar, ou
///    mémoire sur web) — elle ne dépend pas du réseau ;
///  - seule une anomalie dont on retrouve le propriétaire du kiosque est
///    notifiée (un kiosque non déclaré n'a pas de destinataire) ;
///  - l'état « lu » est conservé après redémarrage (ré-interrogation) ;
///  - le rejeu de la même anomalie ne duplique ni anomalie ni notification.
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late LocalStore store;
  late EmbeddedBackend backend;

  const citoyen = '340000002';
  const agent = '340000001';
  const kiosque = '2D001';

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    await SecureStore.instance.init();
    store = MemoryLocalStore();
    backend = EmbeddedBackend(store, SecureStore.instance);
    await backend.provisionCitoyenDemo();
  });

  tearDown(() {
    // Coupe le minuteur de verrouillage auto éventuellement armé par les
    // widgets construits dans un test — aucun timer résiduel.
    AutoLockService.instance.shutdown();
  });

  test('anomalie signalée => notification persistante du propriétaire',
      () async {
    final res = await backend.signalerAnomalie({
      'type_anomalie': 'NON_CONFORMITE',
      'code_kiosque': kiosque,
      'description': 'Kiosque plus grand que le dossier',
      'agent_telephone': agent,
      'session_token': 'session-de-test',
    });

    expect(res.reference, isNotEmpty);
    final notifs = await backend.getNotifications(citoyen);
    expect(notifs, hasLength(1));
    final n = notifs.single;
    expect(n['id_unique'], 'anomalie-${res.reference}');
    expect(n['type'], 'ANOMALIE_SIGNALLEE');
    expect(n['type_anomalie'], 'NON_CONFORMITE');
    expect(n['code_kiosque'], kiosque);
    expect(n['message_agent'], 'Kiosque plus grand que le dossier');
    expect(n['reference_anomalie'], res.reference);
    expect(n['lu'], isFalse);
  });

  test('le rejeu de la même anomalie ne duplique pas la notification', () async {
    const reference = 'AN-FIXE-001';
    Map<String, dynamic> payload() => {
      'reference': reference,
      'type_anomalie': 'DEPLACEMENT',
      'code_kiosque': kiosque,
      'description': 'GPS différent du dossier',
      'agent_telephone': agent,
      'session_token': 'session-de-test',
    };

    await backend.signalerAnomalie(payload());
    final resultat2 = await backend.signalerAnomalie(payload());

    expect(resultat2.reference, reference);
    final notifs = await backend.getNotifications(citoyen);
    expect(notifs, hasLength(1));
  });

  test('kiosque non déclaré (aucun propriétaire) => aucune notification',
      () async {
    await backend.signalerAnomalie({
      'type_anomalie': 'NON_DECLARE',
      'code_kiosque': '',
      'description': 'Kiosque sans QR ni contrat',
      'agent_telephone': agent,
      'session_token': 'session-de-test',
    });

    final notifs = await backend.getNotifications(citoyen);
    expect(notifs, isEmpty);
  });

  test("marquer lue persiste : état « lu » conservé après ré-interrogation",
      () async {
    final res = await backend.signalerAnomalie({
      'type_anomalie': 'NON_CONFORMITE',
      'code_kiosque': kiosque,
      'description': 'Vérifier l\'emplacement',
      'agent_telephone': agent,
      'session_token': 'session-de-test',
    });
    final id = (await backend.getNotifications(citoyen)).single['id_unique']!;

    await backend.markNotificationLu(id as String);

    final apres = await backend.getNotifications(citoyen);
    expect(apres.single['lu'], isTrue);
    expect(apres.single['id_unique'], 'anomalie-${res.reference}');
  });

  test('NotificationService fusionne dérivées + anomalie persistante '
      '(liste et badge de non-lus)', () async {
    final dossiers = await backend.getMesDossiers(citoyen);
    final paiements = await backend.getMesPaiements(citoyen);
    await backend.signalerAnomalie({
      'type_anomalie': 'NON_CONFORMITE',
      'code_kiosque': kiosque,
      'description': 'Débordement sur le trottoir',
      'agent_telephone': agent,
      'session_token': 'session-de-test',
    });
    final persistantes = await backend.getNotifications(citoyen);

    final service = NotificationService.instance;
    final liste = service.buildComplet(
      citoyen,
      dossiers,
      paiements,
      persistantes,
    );
    expect(liste.any((n) => n.type == 'ANOMALIE_SIGNALLEE'), isTrue);
    final nonLues = service.unreadCountComplet(citoyen, liste, persistantes);
    expect(nonLues, greaterThan(0));

    await backend.markNotificationLu(
      persistantes.single['id_unique'] as String,
    );
    final apres = await backend.getNotifications(citoyen);
    final nonLuesApres = service.unreadCountComplet(
      citoyen,
      service.buildComplet(citoyen, dossiers, paiements, apres),
      apres,
    );
    expect(nonLuesApres, nonLues - 1,
        reason: 'la marquée lue ne compte plus dans le badge');
  });
}