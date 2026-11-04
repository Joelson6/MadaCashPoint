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

  @override
  Future<Object?> call(String method, List<Object?> params) async {
    lastMethod = method;
    lastParams = params;
    if (nextFault != null) throw nextFault!;
    return nextResult;
  }
}

void main() {
  group('RemoteBackend - synchronisation différée (section 11)', () {
    late _FakeXmlRpcClient client;
    late RemoteXmlRpcBackend backend;

    setUp(() {
      client = _FakeXmlRpcClient(url: 'https://test.example.com/xmlrpc');
      backend = RemoteXmlRpcBackend(client: client);
    });

    test('envoie la liste complète des payloads dans l\'ordre', () async {
      final payloadList = [
        {'kind': 'encaissement', 'id': 1},
        {'kind': 'demande', 'id': 2},
        {'kind': 'anomalie', 'id': 3},
      ];
      client.nextResult = {
        'total': 3,
        'success': 3,
        'erreurs': 0,
        'echec_ids': <int>[],
        'messages': <String>['ok', 'ok', 'ok'],
      };

      final res = await backend.syncOfflineQueue(payloadList);

      expect(client.lastMethod, 'sync_offline_queue');
      final sent = (client.lastParams!.first as List).cast<Map<String, dynamic>>();
      expect(sent.length, 3);
      expect(sent[0]['kind'], 'encaissement');
      expect(sent[1]['kind'], 'demande');
      expect(sent[2]['kind'], 'anomalie');
      expect(res.total, 3);
      expect(res.success, 3);
      expect(res.echecIds, isEmpty);
    });

    test('lot partiel : echecIds précis pour éléments rejetés', () async {
      client.nextResult = {
        'total': 3,
        'success': 2,
        'erreurs': 1,
        'echec_ids': [2],
        'messages': ['ok', 'ok', 'CIN invalide'],
      };

      final res = await backend.syncOfflineQueue([
        {'id': 1},
        {'id': 2},
        {'id': 3},
      ]);

      expect(res.total, 3);
      expect(res.success, 2);
      expect(res.erreurs, 1);
      // L'élément 2 reste en attente côté client (file conservée).
      expect(res.echecIds, [2]);
      expect(res.messages.last, 'CIN invalide');
    });

    test('echec_ids vides / absents -> liste vide (pas de plantage)', () async {
      client.nextResult = {
        'total': 1,
        'success': 1,
        'erreurs': 0,
      };

      final res = await backend.syncOfflineQueue([{'id': 1}]);

      expect(res.echecIds, isEmpty);
      expect(res.messages, isEmpty);
    });

    test('echec_ids contient valeurs invalides -> filtrées (>=0)', () async {
      client.nextResult = {
        'total': 3,
        'success': 0,
        'erreurs': 3,
        'echec_ids': ['1', 'x', -5, '3'],
        'messages': ['e1', 'e2', 'e3'],
      };

      final res = await backend.syncOfflineQueue([{'id': 1}, {'id': 2}, {'id': 3}]);

      expect(res.echecIds, [1, 3]);
    });

    test('refus métier global (success:false) -> ArgumentError, pas de repli local',
        () async {
      client.nextResult = {'success': false, 'error': 'Session invalide'};

      expect(
        () => backend.syncOfflineQueue([{'id': 1}]),
        throwsA(isA<ArgumentError>()),
      );
    });

    test('erreur transport -> XmlRpcFault transport (repli offline autorisé)',
        () async {
      client.nextFault = XmlRpcFault(XmlRpcFault.codeTransport, 'connexion');

      expect(
        () => backend.syncOfflineQueue([{'id': 1}]),
        throwsA(isA<XmlRpcFault>().having((f) => f.isTransport, 'isTransport', true)),
      );
    });
  });
}
