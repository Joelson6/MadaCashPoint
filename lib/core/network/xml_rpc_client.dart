import 'dart:convert';

import 'package:http/http.dart' as http;

import 'xml_rpc_codec.dart';

/// Client XML-RPC minimaliste : envoie une requête HTTP POST XML-RPC
/// vers l'endpoint du site web CUF (section 8 du CDC).
class XmlRpcClient {
  final http.Client _http;
  final String url;
  final Duration timeout;

  XmlRpcClient({
    http.Client? httpClient,
    required this.url,
    this.timeout = const Duration(seconds: 15),
  }) : _http = httpClient ?? http.Client();

  /// Exécute une méthode XML-RPC distante (ex: user_login(phone, pin)).
  Future<Object?> call(String method, List<Object?> params) async {
    final body = XmlRpcCodec.encodeCall(method, params);
    late http.Response response;
    try {
      response = await _http
          .post(
            Uri.parse(url),
            headers: const {'Content-Type': 'text/xml; charset=utf-8'},
            body: body,
          )
          .timeout(timeout);
    } catch (e) {
      throw XmlRpcFault(XmlRpcFault.codeTransport, 'Erreur réseau XML-RPC: $e');
    }
    if (response.statusCode != 200) {
      throw XmlRpcFault(
        XmlRpcFault.codeTransport,
        'HTTP ${response.statusCode} du serveur XML-RPC',
      );
    }
    final text = utf8.decode(response.bodyBytes, allowMalformed: true);
    return XmlRpcCodec.decodeResponse(text);
  }

  void dispose() => _http.close();
}
