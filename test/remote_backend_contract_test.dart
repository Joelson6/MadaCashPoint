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
  group('RemoteBackend - contrat XML-RPC', () {
    late _FakeXmlRpcClient client;
    late RemoteXmlRpcBackend backend;

    setUp(() {
      client = _FakeXmlRpcClient(url: 'https://test.example.com/xmlrpc');
      backend = RemoteXmlRpcBackend(client: client);
    });

    test('userLogin - mapping SessionInfo depuis Map', () async {
      client.nextResult = {
        'telephone': '0321234567',
        'nom': 'RAKOTO',
        'role': 'demandeur',
        'session_token': 'tok123',
      };
      
      final session = await backend.userLogin('0321234567', '1234');
      
      expect(client.lastMethod, 'user_login');
      expect(session.telephone, '0321234567');
      expect(session.nom, 'RAKOTO');
      expect(session.role, 'demandeur');
    });

    test('userLogin - erreur métier remonte ArgumentError', () async {
      client.nextResult = {'success': false, 'error': 'PIN invalide'};
      
      expect(
        () => backend.userLogin('0321234567', '0000'),
        throwsA(isA<ArgumentError>()),
      );
    });

    test('userLogin - erreur transport remonte XmlRpcFault', () async {
      client.nextFault = XmlRpcFault(XmlRpcFault.codeTransport, 'timeout');
      
      expect(
        () => backend.userLogin('0321234567', '0000'),
        throwsA(isA<XmlRpcFault>()),
      );
    });

    test('checkLocationAllowance - allowed true', () async {
      client.nextResult = {'allowed': true, 'message': 'OK', 'zone': 'Zone autorisée'};
      
      final res = await backend.checkLocationAllowance(-18.914, 47.531);
      
      expect(client.lastMethod, 'check_location_allowance');
      expect(res.allowed, true);
      expect(res.message, 'OK');
      expect(res.zoneDescription, 'Zone autorisée');
    });

    test('submitDemande - mapping DemandeResult', () async {
      client.nextResult = {
        'code_dossier': 'DOS-2026-001',
        'statut': 'SOUMIS',
        'montant_droit_installation': 150000,
      };
      
      final res = await backend.submitDemande({'test': 'data'});
      
      expect(client.lastMethod, 'submit_demande_autorisation');
      expect(res.codeDossier, 'DOS-2026-001');
      expect(res.statut, 'SOUMIS');
      expect(res.montantDroitInstallation, 150000);
    });

    test('registerEncaissement - mapping EncaissementResult', () async {
      client.nextResult = {
        'numero_quittance': 'Q-123456',
        'numero_avis_paiement': 'AP-789',
        'horodatage': '2026-10-20T10:30:00',
        'message': 'Encaissement enregistré',
      };
      
      final res = await backend.registerEncaissement({'codeKiosque': 'K001'});
      
      expect(client.lastMethod, 'register_encaissement');
      expect(res.numeroQuittance, 'Q-123456');
      expect(res.numeroAvisPaiement, 'AP-789');
    });

    test('syncOfflineQueue - mapping SyncResult avec echecIds', () async {
      client.nextResult = {
        'total': 3,
        'success': 2,
        'erreurs': 1,
        'echec_ids': [5],
        'messages': ['OK', 'OK', 'Échec validation'],
      };
      
      final res = await backend.syncOfflineQueue([{}, {}, {}]);
      
      expect(client.lastMethod, 'sync_offline_queue');
      expect(res.total, 3);
      expect(res.success, 2);
      expect(res.erreurs, 1);
      expect(res.echecIds, [5]);
    });

    test('signalerAnomalie - mapping ResultatAnomalie', () async {
      client.nextResult = {
        'reference': 'ANO-2026-045',
        'statut': 'EN_ATTENTE',
        'message': 'Anomalie enregistrée',
      };
      
      final res = await backend.signalerAnomalie({'codeKiosque': 'K001'});
      
      expect(client.lastMethod, 'signaler_anomalie');
      expect(res.reference, 'ANO-2026-045');
      expect(res.statut, 'EN_ATTENTE');
    });

    test('deciderDemande - mapping DemandeDecision', () async {
      client.nextResult = {
        'code_dossier': 'DOS-2026-001',
        'statut': 'APPROUVE',
        'note': 'Conforme',
        'code_kiosque': 'K-NEW-001',
        'autorisation_numero': 'AUT-2026-100',
        'message': 'Approuvé',
      };
      
      final res = await backend.deciderDemande({'code_dossier': 'DOS-001', 'decision': 'APPROUVE'});
      
      expect(client.lastMethod, 'decider_demande');
      expect(res.statut, 'APPROUVE');
      expect(res.codeKiosque, 'K-NEW-001');
      expect(res.autorisationNumero, 'AUT-2026-100');
    });

    test('getNotifications - liste vide tolérée', () async {
      client.nextResult = [];
      
      final res = await backend.getNotifications('0321234567');
      
      expect(client.lastMethod, 'get_notifications');
      expect(res, isEmpty);
    });

    test('markNotificationLu - succès sans retour', () async {
      client.nextResult = null;
      
      await backend.markNotificationLu('id-123');
      
      expect(client.lastMethod, 'mark_notification_lu');
    });
  });
}
