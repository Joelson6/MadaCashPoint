import 'dart:convert';

import '../../core/config/app_config.dart';
import '../../core/network/xml_rpc_client.dart';
import 'cuf_backend.dart';
import 'kiosque_mapper.dart';

/// Implémentation distante : dialogue avec le site web CUF existant via
/// XML-RPC (connectivité bidirectionnelle, section 8 du CDC).
/// Le site web reste la source de vérité ; le mobile ne fait que consommer
/// les procédures distantes et remonter les données (paiements, demandes).
class RemoteXmlRpcBackend implements CufBackend {
  final XmlRpcClient _client;

  RemoteXmlRpcBackend({XmlRpcClient? client})
    : _client = client ?? XmlRpcClient(url: AppConfig.serverUrl);

  Map<String, dynamic> _map(Object? v) {
    return v is Map ? Map<String, dynamic>.from(v) : <String, dynamic>{};
  }

  Object? _ok(Object? result) {
    // Les serveurs renvoient parfois {success, data} ou directement la valeur.
    final m = _map(result);
    if (m['success'] == false && m['error'] != null) {
      throw ArgumentError('${m['error']}');
    }
    return m['data'] ?? result;
  }

  @override
  Future<SessionInfo> userLogin(String telephone, String pin) async {
    final result = _ok(await _client.call('user_login', [telephone, pin]));
    final m = _map(result);
    return SessionInfo(
      telephone: m['telephone']?.toString() ?? telephone,
      nom: m['nom']?.toString() ?? '',
      role: m['role']?.toString() ?? 'demandeur',
      sessionToken: m['session_token']?.toString() ?? '',
    );
  }

  @override
  Future<String> requestOtp(String telephone) async {
    final result = _ok(await _client.call('request_otp', [telephone]));
    return _map(result)['otp']?.toString() ?? '';
  }

  @override
  Future<SessionInfo> verifyOtpAndRegister(Map<String, dynamic> payload) async {
    final result = _ok(await _client.call('verify_otp_register', [payload]));
    final m = _map(result);
    return SessionInfo(
      telephone: m['telephone']?.toString() ?? '',
      nom: m['nom']?.toString() ?? '',
      role: m['role']?.toString() ?? 'demandeur',
      sessionToken: m['session_token']?.toString() ?? '',
    );
  }

  @override
  Future<LocationAllowance> checkLocationAllowance(
    double latitude,
    double longitude,
  ) async {
    final result = _ok(
      await _client.call('check_location_allowance', [latitude, longitude]),
    );
    final m = _map(result);
    return LocationAllowance(
      allowed:
          m['allowed'] == true || '${m['allowed']}'.toLowerCase() == 'true',
      message: m['message']?.toString() ?? '',
      zoneDescription: m['zone']?.toString() ?? '',
    );
  }

  @override
  Future<DemandeResult> submitDemande(Map<String, dynamic> payload) async {
    final result = _ok(
      await _client.call('submit_demande_autorisation', [payload]),
    );
    final m = _map(result);
    return DemandeResult(
      codeDossier: m['code_dossier']?.toString() ?? '',
      statut: m['statut']?.toString() ?? 'EN_COURS_INSTRUCTION',
      montantDroitInstallation: intOf(m, 'montant_droit_installation'),
    );
  }

  @override
  Future<Map<String, dynamic>?> getKiosqueByQrcode(String code) async {
    final result = await _client.call('get_kiosque_by_qrcode', [code]);
    if (result == null) return null;
    return _map(result);
  }

  @override
  Future<Map<String, dynamic>?> getKiosqueById(String code) async {
    final result = await _client.call('get_kiosque_by_id', [code]);
    if (result == null) return null;
    return _map(result);
  }

  @override
  Future<EncaissementResult> registerEncaissement(
    Map<String, dynamic> payload,
  ) async {
    final result = _ok(await _client.call('register_encaissement', [payload]));
    final m = _map(result);
    return EncaissementResult(
      numeroQuittance: m['numero_quittance']?.toString() ?? '',
      numeroAvisPaiement: m['numero_avis_paiement']?.toString() ?? '',
      horodatage:
          DateTime.tryParse(m['horodatage']?.toString() ?? '') ??
          DateTime.now(),
      message: m['message']?.toString() ?? 'Encaissement enregistré.',
    );
  }

  @override
  Future<SyncResult> syncOfflineQueue(
    List<Map<String, dynamic>> payloadList,
  ) async {
    final result = _ok(await _client.call('sync_offline_queue', [payloadList]));
    final m = _map(result);
    final echecIds = (m['echec_ids'] is List)
        ? (m['echec_ids'] as List)
              .map((e) => int.tryParse('$e') ?? -1)
              .where((i) => i >= 0)
              .toList()
        : const <int>[];
    return SyncResult(
      total: intOf(m, 'total'),
      success: intOf(m, 'success'),
      erreurs: intOf(m, 'erreurs'),
      messages: (m['messages'] is List)
          ? (m['messages'] as List).map((e) => '$e').toList()
          : const [],
      echecIds: echecIds,
    );
  }

  @override
  Future<List<Map<String, dynamic>>> getMesDossiers(String telephone) async {
    final result = _ok(await _client.call('get_mes_dossiers', [telephone]));
    if (result is List) {
      return result.map((e) => _map(e)).toList();
    }
    return const [];
  }

  @override
  Future<List<Map<String, dynamic>>> getMesPaiements(String telephone) async {
    final result = _ok(await _client.call('get_mes_paiements', [telephone]));
    if (result is List) {
      return result.map((e) => _map(e)).toList();
    }
    return const [];
  }

  @override
  Future<List<Map<String, dynamic>>> getZonesInterdites() async {
    final result = _ok(await _client.call('get_zones_interdites', const []));
    if (result is List) {
      return result.map((e) => _map(e)).toList();
    }
    return const [];
  }

  @override
  Future<List<Map<String, dynamic>>> getGrilleTarifaire() async {
    final result = _ok(await _client.call('get_grille_tarifaire', const []));
    if (result is List) {
      return result.map((e) => _map(e)).toList();
    }
    return const [];
  }

  @override
  Future<ResultatAnomalie> signalerAnomalie(
    Map<String, dynamic> payload,
  ) async {
    final result = _ok(await _client.call('signaler_anomalie', [payload]));
    final m = _map(result);
    return ResultatAnomalie(
      reference: m['reference']?.toString() ?? '',
      statut: m['statut']?.toString() ?? 'EN_ATTENTE',
      message: m['message']?.toString() ?? '',
    );
  }

  @override
  Future<List<Map<String, dynamic>>> getNotifications(
    String telephone,
  ) async {
    try {
      final result = _ok(
        await _client.call('get_notifications', [telephone]),
      );
      if (result is List) {
        return result.map((e) => _map(e)).toList();
      }
    } catch (_) {
      // Site web CUF sans endpoint notifications : repli silencieux.
      // Le back-end embarqué, lui, conserve l'historique complet des
      // notifications d'anomalie (section 6.5).
    }
    return const [];
  }

  @override
  Future<void> markNotificationLu(String idUnique) async {
    try {
      _ok(await _client.call('mark_notification_lu', [idUnique]));
    } catch (_) {
      // Repli silencieux (voir getNotifications).
    }
  }

  @override
  Future<List<Map<String, dynamic>>> getKiosquesVoisins(String code) async {
    final result = await _client.call('get_kiosques_voisins', [code]);
    if (result is List) {
      return result.map((e) => _map(e)).toList();
    }
    return const [];
  }

  @override
  Future<List<Map<String, dynamic>>> getKiosquesRedevables() async {
    final result = _ok(await _client.call('get_kiosques_redevables', const []));
    if (result is List) {
      return result.map((e) => _map(e)).toList();
    }
    return const [];
  }

  @override
  Future<List<Map<String, dynamic>>> getDemandesAgent() async {
    final result = _ok(await _client.call('get_demandes_agent', const []));
    if (result is List) {
      return result.map((e) => _map(e)).toList();
    }
    return const [];
  }

  @override
  Future<DemandeDecision> deciderDemande(
    Map<String, dynamic> payload,
  ) async {
    final result = _ok(await _client.call('decider_demande', [payload]));
    final m = _map(result);
    return DemandeDecision(
      codeDossier: m['code_dossier']?.toString() ?? '',
      statut: m['statut']?.toString() ?? 'EN_COURS_INSTRUCTION',
      note: m['note']?.toString() ?? '',
      codeKiosque: m['code_kiosque']?.toString() ?? '',
      autorisationNumero: m['autorisation_numero']?.toString() ?? '',
      message: m['message']?.toString() ?? '',
    );
  }

  /// Utilitaires souvent utiles côté serveur réel : payload en JSON string.
  static String jsonEncodePayload(Map<String, dynamic> payload) =>
      jsonEncode(payload);
}
