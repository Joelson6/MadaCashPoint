import 'package:flutter/foundation.dart';
import 'package:blue_thermal_printer/blue_thermal_printer.dart';

/// Imprimante thermique abstraite — Bluetooth réel ou simulation (démo).
abstract class ReceiptPrinter {
  Future<bool> isAvailable();
  Future<bool> printText(String text);
}

/// Implémentation réelle via blue_thermal_printer (section 2.1 : impression
/// Bluetooth de poche des quittances).
class BluetoothReceiptPrinter implements ReceiptPrinter {
  static final BluetoothReceiptPrinter instance = BluetoothReceiptPrinter._();
  BluetoothReceiptPrinter._();

  final BlueThermalPrinter _bt = BlueThermalPrinter.instance;

  @override
  Future<bool> isAvailable() async {
    try {
      final connected = await _bt.isConnected;
      return connected == true;
    } catch (e) {
      debugPrint('[ReceiptPrinter] isAvailable() failed: $e');
      return false;
    }
  }

  @override
  Future<bool> printText(String text) async {
    try {
      final connected = await _bt.isConnected;
      if (connected != true) return false;
      for (final line in text.split('\n')) {
        if (line.trim().isEmpty) {
          await _bt.printNewLine();
        } else if (line.startsWith('===') || line.startsWith('---')) {
          await _bt.printCustom(line, 1, 1);
        } else if (line.startsWith('*')) {
          await _bt.printCustom(line.substring(1), 2, 1);
        } else {
          await _bt.write('$line\r\n');
        }
      }
      await _bt.printNewLine();
      await _bt.paperCut();
      return true;
    } catch (e) {
      debugPrint('[ReceiptPrinter] Impression échouée: $e');
      return false;
    }
  }
}

/// Repli : sans imprimante connectée, l'impression est simulée (log local).
class SimulatedReceiptPrinter implements ReceiptPrinter {
  static final SimulatedReceiptPrinter instance = SimulatedReceiptPrinter._();
  SimulatedReceiptPrinter._();

  @override
  Future<bool> isAvailable() async => true;

  @override
  Future<bool> printText(String text) async {
    // ignore: avoid_print
    debugPrint('[ReceiptPrinter][SIMULATION]\n$text');
    return true;
  }
}

/// Générateur du texte thermique de la quittance (section 7.3 du CDC) :
/// numéro + date, kiosque + propriétaire, montant + nature de taxe,
/// identifiant de l'agent et numéro de session.
class QuittanceRenderer {
  static String render({
    required String numeroQuittance,
    required DateTime date,
    required String nomKiosque,
    required String proprietaire,
    required int montant,
    required String natureTaxe,
    required String codeKiosque,
    required String agentTelephone,
    required String agentSession,
  }) {
    return [
      '  COMMUNE URBAINE DE FIANARANTSOA',
      '  SERVICE RECOUVREMENT MOBILE MONEY',
      '========================================',
      '*QUITTANCE DE PAIEMENT*',
      '----------------------------------------',
      'N Quittance : $numeroQuittance',
      'Date : ${_dd(date)}',
      '----------------------------------------',
      'Kiosque : $nomKiosque ($codeKiosque)',
      'Proprietaire : $proprietaire',
      '----------------------------------------',
      'Taxe : $natureTaxe',
      'Montant : $montant Ar',
      '----------------------------------------',
      'Encaisseur : $agentTelephone',
      'Session : $agentSession',
      '========================================',
      '  *Aza very ity tsitapaka ity*',
    ].join('\n');
  }

  static String _dd(DateTime d) {
    String p(int v) => v.toString().padLeft(2, '0');
    return '${d.year}-${p(d.month)}-${p(d.day)} ${p(d.hour)}:${p(d.minute)}';
  }
}