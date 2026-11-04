import 'package:cuf_recouvrement_mobile/core/db/local_store.dart';
import 'package:cuf_recouvrement_mobile/core/db/local_store_web.dart';
import 'package:cuf_recouvrement_mobile/core/security/secure_store.dart';
import 'package:cuf_recouvrement_mobile/data/local/repositories/demande_repo.dart';
import 'package:cuf_recouvrement_mobile/data/local/repositories/kiosque_repo.dart';
import 'package:cuf_recouvrement_mobile/data/models/demande.dart';
import 'package:cuf_recouvrement_mobile/data/remote/embedded_backend.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Instruction des dossiers par l'agent communal (section 4.4).
///
/// Couvre les trois décisions du guichet (approuver / corriger / rejeter),
/// la création automatique de la fiche kiosque à l'approbation (§ 5 → § 6) et
/// l'idempotence des rejeux de la file de synchronisation.
void main() {
  late LocalStore store;
  late EmbeddedBackend backend;
  late KiosqueRepo kiosques;
  late DemandeRepo demandes;

  const tel = '0340000002';
  const dossier = 'CUF2026-22189';

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    await SecureStore.instance.init();
    store = MemoryLocalStore();
    backend = EmbeddedBackend(store, SecureStore.instance);
    kiosques = KiosqueRepo(store);
    demandes = DemandeRepo(store);
    await backend.provisionCitoyenDemo();
  });

  Future<int> nbKiosques() async => (await kiosques.all()).length;

  Future<Map<String, dynamic>> ligne(String code) => backend
      .getDemandesAgent()
      .then((l) => l.firstWhere((d) => d['code_dossier'] == code));

  Future<void> resetDossier() async {
    final d = await demandes.byCode(dossier);
    d!
      ..statut = 'EN_COURS_INSTRUCTION'
      ..noteRejet = '';
    await demandes.put(d);
    for (final k in await kiosques.all()) {
      if (k.dossierEncoursNumero == dossier) {
        await kiosques.remove(k.codeKiosque);
      }
    }
  }

  group('get_demandes_agent', () {
    test('couvre toute la commune, du plus récent au plus ancien', () async {
      final lignes = await backend.getDemandesAgent();

      expect(
        lignes.map((l) => l['code_dossier']),
        containsAll(['CUF2026-22145', dossier]),
        reason: "l'agent voit tous les dossiers de la commune",
      );

      final dates = lignes
          .map((l) => l['date_soumission']?.toString() ?? '')
          .toList();
      final tries = [...dates]..sort((a, b) => b.compareTo(a));
      expect(dates, tries, reason: 'tri par date de soumission décroissante');

      final enCours = lignes.firstWhere((l) => l['code_dossier'] == dossier);
      expect(enCours['statut'], 'EN_COURS_INSTRUCTION');
      expect(enCours['nom_prenoms'], isNotEmpty);
      expect(enCours['fokontany'], isNotEmpty);
      expect(enCours['montant_droit_installation'], 150000);
      expect(enCours['statut_droit_installation'], 'EN_ATTENTE');
      expect(enCours['code_kiosque'], '', reason: 'pas encore de kiosque');
      expect(enCours['date_soumission'], isNotEmpty);
    });

    test("exclut les brouillons hors-ligne (numéro provisoire)", () async {
      await demandes.put(
        Demande(telephone: tel, codeDossier: 'OFFLINE-1700000000')
          ..nomPrenoms = 'Brouillon sans numéro officiel'
          ..statut = 'EN_COURS_INSTRUCTION',
      );

      final codes = (await backend.getDemandesAgent())
          .map((l) => l['code_dossier'])
          .toList();

      expect(
        codes,
        isNot(contains('OFFLINE-1700000000')),
        reason: "un dossier sans numéro officiel n'est pas instruisable",
      );
      expect(codes.toSet().length, codes.length, reason: 'pas de doublon');
    });
  });

  group('decider_demande — approbation', () {
    test("l'approbation crée la fiche kiosque et la rend scannable", () async {
      final avant = await nbKiosques();

      final resultat = await backend.deciderDemande({
        'code_dossier': dossier,
        'decision': 'APPROUVE',
        'note': '',
        'agent_telephone': '0340000001',
        'session_token': 'session-de-test',
      });

      expect(resultat.statut, 'APPROUVE');
      expect(resultat.codeKiosque, isNotEmpty, reason: 'code kiosque émis');
      expect(resultat.autorisationNumero, isNotEmpty);
      expect(resultat.message, contains(resultat.codeKiosque));

      expect(await nbKiosques(), avant + 1, reason: 'un seul kiosque créé');

      final kiosque = (await kiosques.all())
          .firstWhere((k) => k.codeKiosque == resultat.codeKiosque);
      expect(kiosque.dossierEncoursNumero, dossier);
      expect(kiosque.proprietaireTelephone, tel);
      expect(
        kiosque.statutDroitInstallation,
        'EN_ATTENTE',
        reason: "l'approbation n'acquitte pas le droit (§ 7.2)",
      );

      // Côté agent : le dossier approuvé expose son kiosque.
      final l = await ligne(dossier);
      expect(l['statut'], 'APPROUVE');
      expect(l['code_kiosque'], resultat.codeKiosque);
      expect(l['autorisation_numero'], resultat.autorisationNumero);

      // Côté demandeur : le suivi suit la décision.
      final suivi = (await backend.getMesDossiers(tel))
          .firstWhere((d) => d['code_dossier'] == dossier);
      expect(suivi['statut'], 'APPROUVE');
    });

    test('le rejeu de la même approbation ne crée pas un second kiosque',
        () async {
      final premier = await backend.deciderDemande({
        'code_dossier': dossier,
        'decision': 'APPROUVE',
        'note': '',
        'agent_telephone': '0340000001',
        'session_token': 'session-de-test',
      });
      final nombre = await nbKiosques();

      final second = await backend.deciderDemande({
        'code_dossier': dossier,
        'decision': 'APPROUVE',
        'note': '',
        'agent_telephone': '0340000001',
        'session_token': 'session-de-test',
      });

      expect(
        second.message,
        contains('déjà enregistrée'),
        reason: 'réception dupliquée de la file de synchronisation',
      );
      expect(second.codeKiosque, premier.codeKiosque);
      expect(await nbKiosques(), nombre, reason: 'aucun kiosque supplémentaire');
    });

    test('une approbation rejouée sur un dossier déjà doté de son kiosque '
        'ne duplique rien', () async {
      final nombre = await nbKiosques();

      final resultat = await backend.deciderDemande({
        'code_dossier': 'CUF2026-22145',
        'decision': 'APPROUVE',
        'note': '',
        'agent_telephone': '0340000001',
        'session_token': 'session-de-test',
      });

      expect(resultat.statut, 'APPROUVE');
      expect(
        resultat.codeKiosque,
        '2D001',
        reason: "le kiosque existant est réutilisé, jamais recréé",
      );
      expect(await nbKiosques(), nombre);
    });
  });

  group('decider_demande — rejet', () {
    test('le motif est obligatoire et rien n\'est écrit sans lui', () async {
      await expectLater(
        backend.deciderDemande({
          'code_dossier': dossier,
          'decision': 'REJETE',
          'note': '   ',
          'agent_telephone': '0340000001',
          'session_token': 'session-de-test',
        }),
        throwsA(
          isA<ArgumentError>().having(
            (e) => e.message,
            'message',
            contains('motif'),
          ),
        ),
      );

      expect(
        (await demandes.byCode(dossier))?.statut,
        'EN_COURS_INSTRUCTION',
        reason: 'aucune décision partiellement appliquée',
      );
    });

    test('le motif est conservé et transmis au demandeur', () async {
      const motif = 'Emplacement en zone inondable';
      final avant = await nbKiosques();

      final resultat = await backend.deciderDemande({
        'code_dossier': dossier,
        'decision': 'REJETE',
        'note': motif,
        'agent_telephone': '0340000001',
        'session_token': 'session-de-test',
      });

      expect(resultat.statut, 'REJETE');
      expect(resultat.note, motif);
      expect(resultat.message, contains(motif));
      expect(
        await nbKiosques(),
        avant,
        reason: 'un rejet ne crée aucun kiosque',
      );

      final l = await ligne(dossier);
      expect(l['statut'], 'REJETE');
      expect(l['note_rejet'], motif);

      final suivi = (await backend.getMesDossiers(tel))
          .firstWhere((d) => d['code_dossier'] == dossier);
      expect(suivi['statut'], 'REJETE');
      expect(suivi['note_rejet'], motif);
    });
  });

  group('decider_demande — corrections', () {
    test("la consigne est obligatoire et fait revenir le dossier en "
        'instruction', () async {
      await expectLater(
        backend.deciderDemande({
          'code_dossier': dossier,
          'decision': 'EN_COURS_INSTRUCTION',
          'note': '',
          'agent_telephone': '0340000001',
          'session_token': 'session-de-test',
        }),
        throwsA(
          isA<ArgumentError>().having(
            (e) => e.message,
            'message',
            contains('consigne'),
          ),
        ),
      );

      const consigne = 'Compléter la photo de l\'emplacement';
      final avant = await nbKiosques();
      final resultat = await backend.deciderDemande({
        'code_dossier': dossier,
        'decision': 'EN_COURS_INSTRUCTION',
        'note': consigne,
        'agent_telephone': '0340000001',
        'session_token': 'session-de-test',
      });

      expect(resultat.statut, 'EN_COURS_INSTRUCTION');
      expect(resultat.note, consigne);
      expect(
        await nbKiosques(),
        avant,
        reason: 'des corrections ne créent aucun kiosque',
      );

      final suivi = (await backend.getMesDossiers(tel))
          .firstWhere((d) => d['code_dossier'] == dossier);
      expect(suivi['statut'], 'EN_COURS_INSTRUCTION');
      expect(suivi['note_rejet'], consigne);
    });

    test('une décision peut être reprise (rejet puis corrections)', () async {
      await backend.deciderDemande({
        'code_dossier': dossier,
        'decision': 'REJETE',
        'note': 'Motif du premier passage',
        'agent_telephone': '0340000001',
        'session_token': 'session-de-test',
      });
      await resetDossier();

      final resultat = await backend.deciderDemande({
        'code_dossier': dossier,
        'decision': 'EN_COURS_INSTRUCTION',
        'note': 'Dossier repris après complément',
        'agent_telephone': '0340000001',
        'session_token': 'session-de-test',
      });

      expect(resultat.statut, 'EN_COURS_INSTRUCTION');
      expect(
        (await demandes.byCode(dossier))?.noteRejet,
        'Dossier repris après complément',
      );
    });
  });

  group('decider_demande — refus', () {
    test('dossier hors-ligne provisoire', () async {
      await demandes.put(
        Demande(telephone: tel, codeDossier: 'OFFLINE-1700000001')
          ..nomPrenoms = 'Brouillon'
          ..statut = 'EN_COURS_INSTRUCTION',
      );

      await expectLater(
        backend.deciderDemande({
          'code_dossier': 'OFFLINE-1700000001',
          'decision': 'APPROUVE',
          'note': '',
          'agent_telephone': '0340000001',
          'session_token': 'session-de-test',
        }),
        throwsA(isA<ArgumentError>()),
      );
    });

    test('dossier inconnu', () async {
      await expectLater(
        backend.deciderDemande({
          'code_dossier': 'CUF2026-99999',
          'decision': 'APPROUVE',
          'note': '',
          'agent_telephone': '0340000001',
          'session_token': 'session-de-test',
        }),
        throwsA(
          isA<ArgumentError>().having(
            (e) => e.message,
            'message',
            contains('introuvable'),
          ),
        ),
      );
    });

    test('décision inconnue', () async {
      await expectLater(
        backend.deciderDemande({
          'code_dossier': dossier,
          'decision': 'VALIDE',
          'note': '',
          'agent_telephone': '0340000001',
          'session_token': 'session-de-test',
        }),
        throwsA(isA<ArgumentError>()),
      );
    });
  });
}
