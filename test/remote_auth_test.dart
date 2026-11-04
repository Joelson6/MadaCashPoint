import 'package:cuf_recouvrement_mobile/core/network/xml_rpc_client.dart';
import 'package:cuf_recouvrement_mobile/core/network/xml_rpc_codec.dart';
import 'package:cuf_recouvrement_mobile/data/remote/cuf_backend.dart';
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
  group('RemoteBackend - authentification (section 4.1)', () {
    late _FakeXmlRpcClient client;
    late RemoteXmlRpcBackend backend;

    setUp(() {
      client = _FakeXmlRpcClient(url: 'https://test.example.com/xmlrpc');
      backend = RemoteXmlRpcBackend(client: client);
    });

    test('userLogin envoie (telephone, pin) dans cet ordre', () async {
      client.nextResult = {
        'telephone': '0321234567',
        'nom': 'Rakoto',
        'role': 'agent',
        'session_token': 'tok',
      };

      await backend.userLogin('0321234567', '1234');

      expect(client.lastMethod, 'user_login');
      expect(client.lastParams, ['0321234567', '1234']);
    });

    test('userLogin normalise le rôle brut (RBAC robuste)', () async {
      client.nextResult = {
        'telephone': '0321234567',
        'nom': 'Agent',
        'role': 'Agent Communal',
        'session_token': 'tok',
      };

      final session = await backend.userLogin('0321234567', '1234');

      expect(session.role, Roles.agent);
      expect(session.roleBrut, 'Agent Communal');
      expect(session.estAgent, true);
    });

    test('userLogin rôle inconnu -> demandeur (rôle canonique)', () async {
      client.nextResult = {
        'telephone': '0341111111',
        'nom': 'Citoyen',
        'role': 'satisfait',
        'session_token': 't',
      };

      final session = await backend.userLogin('0341111111', '5678');

      expect(session.role, Roles.demandeur);
      expect(session.estAgent, false);
    });

    test('refus métier PIN invalide -> ArgumentError (rien n\'est enregistré)',
        () async {
      client.nextResult = {'success': false, 'error': 'PIN invalide'};

      expect(
        () => backend.userLogin('0321234567', '0000'),
        throwsA(isA<ArgumentError>()),
      );
    });

    test('erreur réseau -> XmlRpcFault transport (rejeu différé possible)',
        () async {
      client.nextFault = XmlRpcFault(XmlRpcFault.codeTransport, 'timeout');

      expect(
        () => backend.userLogin('0321234567', '1234'),
        throwsA(isA<XmlRpcFault>().having((f) => f.isTransport, 'isTransport', true)),
      );
    });

    test('requestOtp renvoie le code OTP (mode démo)', () async {
      client.nextResult = {'otp': '482913'};

      final otp = await backend.requestOtp('0321234567');

      expect(client.lastMethod, 'request_otp');
      expect(client.lastParams, ['0321234567']);
      expect(otp, '482913');
    });

    test('verifyOtpAndRegister envoie le payload complet', () async {
      client.nextResult = {
        'telephone': '0321234567',
        'nom': 'Rakoto',
        'role': 'demandeur',
        'session_token': 'tok2',
      };
      final payload = {
        'telephone': '0321234567',
        'otp': '482913',
        'pin': '1234',
        'nom': 'RAKOTO',
        'prenom': 'Jean',
      };

      final session = await backend.verifyOtpAndRegister(payload);

      expect(client.lastMethod, 'verify_otp_register');
      expect((client.lastParams!.first as Map)['otp'], '482913');
      expect(session.telephone, '0321234567');
      expect(session.role, Roles.demandeur);
      expect(session.sessionToken, 'tok2');
    });
  });
}
