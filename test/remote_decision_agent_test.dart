import 'package:cuf_recouvrement_mobile/core/network/xml_rpc_client.dart';
import 'package:cuf_recouvrement_mobile/core/network/xml_rpc_codec.dart';
import 'package:cuf_recouvrement_mobile/data/remote/remote_backend.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;

class _FakeXmlRpcClient extends XmlRpcClient {
  _FakeXmlRpcClient({required String url}) : super(url: url, httpClient: http.Client());

  Object? nextResult;
  XmlRpcFault? nextFault;
  String? lastMethod;
  List<Object?>? lastParams;
  int calls = 0;

  @override
  Future<Object?> call(String method, List<Object?> params) async {
    lastMethod = method;
    lastParams = params;
    calls++;
    if (nextFault != null) throw nextFault!;
    return nextResult;
  }
}

void main() {
  group('RemoteBackend - instruction des dossiers (section 4.4)', () {
    late _FakeXmlRpcClient client;
    late RemoteXmlRpcBackend backend;

    setUp(() {
      client = _FakeXmlRpcClient(url: 'https://test.example.com/xmlrpc');
      backend = RemoteXmlRpcBackend(client: client);
    });

    test('getDemandesAgent n\'appelle aucun paramètre et renvoie la liste',
        () async {
      client.nextResult = [
        {'code_dossier': 'DOS-1', 'statut': 'SOUMIS'},
        {'code_dossier': 'DOS-2', 'statut': 'SOUMIS'},
      ];

      final dossiers = await backend.getDemandesAgent();

      expect(client.lastMethod, 'get_demandes_agent');
      expect(client.lastParams, isEmpty);
      expect(dossiers.length, 2);
      expect(dossiers.first['code_dossier'], 'DOS-1');
    });

    test('deciderDemande APPROUVE : kiosque + autorisation créés', () async {
      client.nextResult = {
        'code_dossier': 'DOS-1',
        'statut': 'APPROUVE',
        'note': '',
        'code_kiosque': 'K-NEW-1',
        'autorisation_numero': 'AUT-2026-1',
        'message': 'Approuvé',
      };

      final res = await backend.deciderDemande({
        'code_dossier': 'DOS-1',
        'decision': 'APPROUVE',
        'note': '',
        'agent_telephone': '0321111111',
        'session_token': 'tok',
      });

      expect(client.lastMethod, 'decider_demande');
      expect(res.statut, 'APPROUVE');
      expect(res.codeKiosque, 'K-NEW-1');
      expect(res.autorisationNumero, 'AUT-2026-1');
      expect(res.note, '');
    });

    test('deciderDemande REJETE : note conservée, aucun kiosque', () async {
      client.nextResult = {
        'code_dossier': 'DOS-2',
        'statut': 'REJETE',
        'note': 'Emplacement interdit',
        'code_kiosque': '',
        'autorisation_numero': '',
        'message': 'Rejeté',
      };

      final res = await backend.deciderDemande({
        'code_dossier': 'DOS-2',
        'decision': 'REJETE',
        'note': 'Emplacement interdit',
        'agent_telephone': '0321111111',
        'session_token': 'tok',
      });

      expect(res.statut, 'REJETE');
      expect(res.note, 'Emplacement interdit');
      expect(res.codeKiosque, isEmpty);
    });

    test('refus métier décision -> ArgumentError (pas d\'écriture locale)',
        () async {
      client.nextResult = {'success': false, 'error': 'Dossier déjà statué'};

      expect(
        () => backend.deciderDemande({'code_dossier': 'DOS-1'}),
        throwsA(isA<ArgumentError>()),
      );
    });

    test('getKiosquesRedevables renvoie les lignes de recouvrement', () async {
      client.nextResult = [
        {
          'code_kiosque': 'K01',
          'proprietaire_nom': 'Rakoto',
          'total_dette_ariary': 45000,
          'mois_retard_calcules': 3,
        },
      ];

      final liste = await backend.getKiosquesRedevables();

      expect(client.lastMethod, 'get_kiosques_redevables');
      expect(liste.single['total_dette_ariary'], 45000);
      expect(liste.single['mois_retard_calcules'], 3);
    });
  });

  group('RemoteBackend - encaissement (section 6.4)', () {
    late _FakeXmlRpcClient client;
    late RemoteXmlRpcBackend backend;

    setUp(() {
      client = _FakeXmlRpcClient(url: 'https://test.example.com/xmlrpc');
      backend = RemoteXmlRpcBackend(client: client);
    });

    test('registerEncaissement horodatage ISO8601 parsé', () async {
      client.nextResult = {
        'numero_quittance': 'Q-2026-001',
        'numero_avis_paiement': 'AP-2026-001',
        'horodatage': '2026-10-20T14:30:00',
        'message': 'Encaissement enregistré',
      };

      final res = await backend.registerEncaissement({
        'codeKiosque': 'K01',
        'montant': 25000,
        'agentTelephone': '0321111111',
      });

      expect(res.numeroQuittance, 'Q-2026-001');
      expect(res.numeroAvisPaiement, 'AP-2026-001');
      expect(res.horodatage.year, 2026);
      expect(res.horodatage.month, 10);
      expect(res.horodatage.day, 20);
    });

    test('horodatage absent -> DateTime.now() (jamais null)', () async {
      client.nextResult = {
        'numero_quittance': 'Q-2',
        'numero_avis_paiement': 'AP-2',
      };

      final res = await backend.registerEncaissement({'codeKiosque': 'K01'});

      expect(res.horodatage.isBefore(DateTime.now().add(const Duration(minutes: 1))),
          isTrue);
    });

    test('refus métier encaissement -> ArgumentError', () async {
      client.nextResult = {'success': false, 'error': 'Déjà encaissé'};

      expect(
        () => backend.registerEncaissement({'codeKiosque': 'K01'}),
        throwsA(isA<ArgumentError>()),
      );
    });

    test('signalerAnomalie renvoie reference/statut/message', () async {
      client.nextResult = {
        'reference': 'ANO-2026-001',
        'statut': 'EN_ATTENTE',
        'message': 'Enregistrée',
      };

      final res = await backend.signalerAnomalie({
        'codeKiosque': 'K01',
        'type': 'KIOSQUE_NON_DECLARE',
        'agentTelephone': '0321111111',
      });

      expect(client.lastMethod, 'signaler_anomalie');
      expect(res.reference, 'ANO-2026-001');
      expect(res.statut, 'EN_ATTENTE');
    });
  });
}
