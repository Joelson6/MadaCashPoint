import 'package:cuf_recouvrement_mobile/core/db/local_store.dart';
import 'package:cuf_recouvrement_mobile/core/db/local_store_web.dart';
import 'package:cuf_recouvrement_mobile/core/security/secure_store.dart';
import 'package:cuf_recouvrement_mobile/data/local/repositories/demande_repo.dart';
import 'package:cuf_recouvrement_mobile/data/local/repositories/encaissement_repo.dart';
import 'package:cuf_recouvrement_mobile/data/local/repositories/kiosque_repo.dart';
import 'package:cuf_recouvrement_mobile/data/models/demande.dart';
import 'package:cuf_recouvrement_mobile/data/models/kiosque.dart';
import 'package:cuf_recouvrement_mobile/data/remote/embedded_backend.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Droit d'installation (section 7.2).
///
/// Régression : l'encaissement n'était écrit que sur le KIOSQUE. Du point de
/// vue du demandeur, rien ne changeait — « Suivi » restait sur « en attente »
/// et « Mes paiements » affichait les 150 000 Ar comme encore dus.
void main() {
  late LocalStore store;
  late EmbeddedBackend backend;

  const tel = '340000002';
  const dossierCible = 'CUF2026-30001';

  Map<String, dynamic> dossier(List<Map<String, dynamic>> dossiers) =>
      dossiers.firstWhere((d) => d['code_dossier'] == dossierCible);

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    await SecureStore.instance.init();
    store = MemoryLocalStore();
    backend = EmbeddedBackend(store, SecureStore.instance);
    await backend.provisionCitoyenDemo();

    // Scénario : dossier approuvé, kiosque ouvert, droit pas encore réglé.
    await DemandeRepo(store).put(
      Demande(telephone: tel, codeDossier: dossierCible)
        ..nomPrenoms = 'RASOANANDRASANA Claire'
        ..nomCommercial = 'Kiosque des tests'
        ..statut = 'APPROUVE'
        ..montantDroitInstallation = 150000
        ..statutDroitInstallation = 'EN_ATTENTE',
    );
    await KiosqueRepo(store).put(
      Kiosque(codeKiosque: '2D009')
        ..proprietaireTelephone = tel
        ..proprietaireNom = 'RASOANANDRASANA Claire'
        ..dossierEncoursNumero = dossierCible
        ..statutDroitInstallation = 'EN_ATTENTE',
    );
  });

  test("encaisser le droit d'installation met à jour le suivi ET l'historique "
      'du demandeur', () async {
    // 1. Avant paiement : le suivi réclame bien les 150 000 Ar.
    expect(
      dossier(await backend.getMesDossiers(tel))['statut_droit_installation'],
      'EN_ATTENTE',
    );

    // 2. L'agent encaisse au guichet.
    final quittance = await backend.registerEncaissement({
      'code_kiosque': '2D009',
      'montant': 150000,
      'nature_taxe': 'INSTALLATION',
      'agent_telephone': '340000001',
    });

    // 3. L'écriture est propagée au dossier, pas seulement au kiosque.
    expect(
      (await DemandeRepo(store).byCode(dossierCible))?.statutDroitInstallation,
      'PAYE',
      reason: 'le dossier du demandeur passe lui aussi à PAYE',
    );

    // 4. « Suivi » : plus aucun droit à régler.
    expect(
      dossier(await backend.getMesDossiers(tel))['statut_droit_installation'],
      'PAYE',
    );

    // 5. « Mes paiements » : ligne soldée, avec la quittance réelle.
    final ligne = (await backend.getMesPaiements(tel)).firstWhere(
      (p) =>
          p['type'] == 'DROIT_INSTALLATION' &&
          p['code_dossier'] == dossierCible,
    );
    expect(ligne['statut'], 'PAYE');
    expect(ligne['montant_paye'], 150000);
    expect(ligne['montant_du'], 0, reason: 'plus rien de dû');
    expect(ligne['numero_quittance'], quittance.numeroQuittance);
    expect(ligne['date_paiement'], isNot(isEmpty));

    // 6. Cloisonnement : l'autre dossier du citoyen, sans kiosque, reste dû.
    expect(
      (await backend.getMesDossiers(tel)).firstWhere(
        (d) => d['code_dossier'] == 'CUF2026-22189',
      )['statut_droit_installation'],
      'EN_ATTENTE',
      reason: "un paiement sur un kiosque ne solde pas l'autre dossier",
    );
  });

  test('le rejeu d\'une quittance déjà encaissée ne duplique rien', () async {
    Future<int> nbEncaissements() async =>
        (await EncaissementRepo(store).all()).length;
    Future<int> nbLignesInstallation() async =>
        (await backend.getMesPaiements(tel))
            .where((p) => p['type'] == 'DROIT_INSTALLATION')
            .length;

    final avant = await nbEncaissements();

    final premier = await backend.registerEncaissement({
      'code_kiosque': '2D001',
      'montant': 150000,
      'nature_taxe': 'INSTALLATION',
      'agent_telephone': '340000001',
    });
    expect(await nbEncaissements(), avant + 1);
    final lignesApresPremier = await nbLignesInstallation();

    // Même quittance rejouée (file de synchro purgée deux fois).
    final second = await backend.registerEncaissement({
      'code_kiosque': '2D001',
      'montant': 150000,
      'nature_taxe': 'INSTALLATION',
      'agent_telephone': '340000001',
      'numero_quittance': premier.numeroQuittance,
    });

    expect(
      second.numeroQuittance,
      premier.numeroQuittance,
      reason: 'aucune seconde quittance émise',
    );
    expect(
      await nbEncaissements(),
      avant + 1,
      reason: 'un seul encaissement persisté',
    );
    expect(
      await nbLignesInstallation(),
      lignesApresPremier,
      reason: 'le rejeu ne crée aucune ligne de paiement supplémentaire',
    );
  });
}
