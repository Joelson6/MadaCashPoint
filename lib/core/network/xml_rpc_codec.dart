import 'package:xml/xml.dart';

/// Erreur XML-RPC remontée par un serveur (struct <fault>).
class XmlRpcFault implements Exception {
  /// Code utilisé pour les incidents de **transport** (connexion impossible,
  /// timeout, HTTP non 200) — et uniquement ceux-là.
  ///
  /// C'est le seul code qui autorise un repli hors-ligne (§ 11) : un refus
  /// métier du serveur ne doit jamais être transformé en succès local. Les
  /// codes applicatifs (unknownMethod, invalidParams…) restent des refus.
  static const codeTransport = -32300;

  final int code;
  final String message;
  XmlRpcFault(this.code, this.message);

  /// Vrai si l'erreur provient du transport et non du serveur.
  bool get isTransport => code == codeTransport;

  @override
  String toString() => 'XmlRpcFault($code): $message';
}

/// Encodeur / décodeur XML-RPC conforme à la spécification XML-RPC 1.0.
/// Les charges utiles suivent les schémas JSON de la section 8 du CDC.
class XmlRpcCodec {
  XmlRpcCodec._();

  /// Construit le corps XML d'un appel de méthode.
  static String encodeCall(String method, List<Object?> params) {
    final buffer = StringBuffer();
    buffer.write('<?xml version="1.0" encoding="UTF-8"?>');
    buffer.write('<methodCall>');
    buffer.write('<methodName>${_escape(method)}</methodName>');
    buffer.write('<params>');
    for (final p in params) {
      buffer.write('<param>');
      _encodeValue(buffer, p);
      buffer.write('</param>');
    }
    buffer.write('</params>');
    buffer.write('</methodCall>');
    return buffer.toString();
  }

  static void _encodeValue(StringBuffer buf, Object? value) {
    buf.write('<value>');
    if (value == null) {
      buf.write('<nil/>');
    } else if (value is bool) {
      buf.write('<boolean>${value ? 1 : 0}</boolean>');
    } else if (value is int) {
      buf.write('<int>$value</int>');
    } else if (value is double) {
      buf.write('<double>$value</double>');
    } else if (value is String) {
      buf.write('<string>${_escape(value)}</string>');
    } else if (value is DateTime) {
      String p(int v) => v.toString().padLeft(2, '0');
      buf.write(
        '<dateTime.iso8601>${value.year}${p(value.month)}${p(value.day)}T${p(value.hour)}:${p(value.minute)}:${p(value.second)}</dateTime.iso8601>',
      );
    } else if (value is List) {
      buf.write('<array><data>');
      for (final item in value) {
        _encodeValue(buf, item);
      }
      buf.write('</data></array>');
    } else if (value is Map) {
      buf.write('<struct>');
      value.forEach((k, v) {
        buf.write('<member><name>${_escape('$k')}</name>');
        _encodeValue(buf, v);
        buf.write('</member>');
      });
      buf.write('</struct>');
    } else {
      buf.write('<string>${_escape('$value')}</string>');
    }
    buf.write('</value>');
  }

  /// Décode la réponse XML en objet Dart (int, double, bool, String,
  /// DateTime, List, Map) ou lève [XmlRpcFault].
  static Object? decodeResponse(String body) {
    final doc = XmlDocument.parse(body);
    final response = doc.findAllElements('methodResponse').firstOrNull;
    if (response == null) {
      throw XmlRpcFault(-32700, 'Réponse XML-RPC invalide');
    }
    final value = response.childElements
        .expand((e) => e.childElements)
        .where((e) => e.name.local == 'value')
        .firstOrNull;
    if (value == null) {
      throw XmlRpcFault(-32600, 'Réponse sans valeur');
    }
    if (response.childElements.any((e) => e.name.local == 'fault')) {
      final fault = _decodeValue(value) as Map;
      final code = fault['faultCode'] is num
          ? (fault['faultCode'] as num).toInt()
          : -1;
      final msg = fault['faultString']?.toString() ?? 'Erreur inconnue';
      throw XmlRpcFault(code, msg);
    }
    return _decodeValue(value);
  }

  static Object? _decodeValue(XmlElement value) {
    final children = value.childElements.toList();
    if (children.isEmpty) {
      final txt = value.innerText.trim();
      return txt.isEmpty ? '' : txt;
    }
    final tag = children.first.name.local;
    final text = children.first.innerText;
    switch (tag) {
      case 'int':
      case 'i4':
        return int.tryParse(text.trim()) ?? 0;
      case 'boolean':
        final t = text.trim().toLowerCase();
        return t == '1' || t == 'true';
      case 'double':
        return double.tryParse(text.trim()) ?? 0.0;
      case 'string':
        return text;
      case 'dateTime.iso8601':
        final t = text.trim().replaceFirst('T', ' ');
        return DateTime.tryParse(t) ?? DateTime.now();
      case 'base64':
        return base64DecodeSafe(text.trim());
      case 'array':
        final data = value.findAllElements('data').first;
        return data.childElements
            .where((e) => e.name.local == 'value')
            .map(_decodeValue)
            .toList();
      case 'struct':
        final map = <String, dynamic>{};
        for (final member in value.childElements.where(
          (e) => e.name.local == 'member',
        )) {
          final name = member.getElement('name')?.innerText ?? '';
          final v = member.getElement('value');
          if (v != null) map[name] = _decodeValue(v);
        }
        return map;
      case 'nil':
        return null;
      default:
        return text;
    }
  }

  static String _escape(String input) {
    return input
        .replaceAll('&', '&amp;')
        .replaceAll('<', '&lt;')
        .replaceAll('>', '&gt;')
        .replaceAll('"', '&quot;')
        .replaceAll("'", '&apos;');
  }
}

List<int> base64DecodeSafe(String data) {
  const Alphabet =
      'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/';
  final buffer = <int>[];
  final cleaned = data
      .replaceAll(' ', '')
      .replaceAll('\n', '')
      .replaceAll('\r', '');
  var pad = cleaned.endsWith('==') ? 2 : (cleaned.endsWith('=') ? 1 : 0);
  var acc = 0;
  var bits = 0;
  for (var i = 0; i < cleaned.length; i++) {
    final c = cleaned[i];
    if (c == '=') break;
    final v = Alphabet.indexOf(c);
    if (v < 0) continue;
    acc = (acc << 6) | v;
    bits += 6;
    if (bits >= 8) {
      bits -= 8;
      buffer.add((acc >> bits) & 0xff);
    }
  }
  if (pad > 0) {
    buffer.removeRange(buffer.length - pad, buffer.length);
  }
  return buffer;
}

extension FirstOrNullExt<T> on Iterable<T> {
  T? get firstOrNull {
    final it = iterator;
    if (it.moveNext()) return it.current;
    return null;
  }
}
