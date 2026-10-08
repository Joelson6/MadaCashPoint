import 'dart:async';
import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';

import '../../data/local/repositories/sync_queue_repo.dart';
import '../../data/models/sync_queue_item.dart';
import '../../data/remote/cuf_backend.dart';

/// Gestionnaire de synchronisation offline-first (section 11 du CDC).
///
/// - Toute opération est d'abord stockée localement (Isar) + mise en file.
/// - Dès que la connectivité revient, la file `sync_offline_queue` est
///   vidée automatiquement.
/// - Le serveur fait autorité en cas de conflit ; l'agent est notifié.
class SyncService {
  final SyncQueueRepo _queue;
  final CufBackend _backend;
  final StreamController<int> _pendingController =
      StreamController<int>.broadcast();

  StreamSubscription<List<ConnectivityResult>>? _sub;
  bool _flushing = false;

  SyncService(this._queue, this._backend);

  Stream<int> get pendingStream => _pendingController.stream;

  /// Observer la connectivité et déclencher la synchronisation au retour réseau.
  ///
  /// Idempotent : [startServices] peut être appelé à la restauration de session
  /// puis à chaque connexion. Sans annulation préalable, l'écoute précédente
  /// restait active et chaque reconnexion déclenchait une purge superflue
  /// (et laissait fuiter un abonnement).
  void startWatcher() {
    if (_sub != null) {
      refreshCount();
      return;
    }
    _sub = Connectivity().onConnectivityChanged.listen((results) {
      final connected = results.any(
        (r) =>
            r == ConnectivityResult.ethernet ||
            r == ConnectivityResult.mobile ||
            r == ConnectivityResult.wifi,
      );
      if (connected) {
        flush();
      }
    });
    refreshCount();
  }

  Future<void> stopWatcher() async {
    await _sub?.cancel();
    _sub = null;
  }

  /// Mise en file d'une opération à payer plus tard (mode dégradé).
  Future<int> enqueue(String methodName, Map<String, dynamic> payload) async {
    final id = await _queue.add(methodName, payload);
    await refreshCount();
    return id;
  }

  /// Purge de la file : appelle sync_offline_queue du serveur (ou du
  /// back-end embarqué) puis marque les éléments réellement transmis.
  ///
  /// Règles de cohérence (section 11) :
  ///  - si le réseau est indisponible, tout reste en file (aucune perte) ;
  ///  - seul un élément confirmé transmis par le serveur est marqué « fait » ;
  ///  - les éléments rejetés restent en attente (retry automatique au retour
  ///    du réseau) et sont conservés pour relecture/vérification manuelle.
  Future<int> flush() async {
    if (_flushing) return 0;
    _flushing = true;
    try {
      final pending = await _queue.pending();
      if (pending.isEmpty) {
        await refreshCount();
        return 0;
      }
      final payloadList = pending
          .map(
            (item) => {
              'id': item.id,
              'method': item.methodName,
              'payload': _decode(item.payloadJson),
            },
          )
          .toList();

      SyncResult result;
      try {
        result = await _backend.syncOfflineQueue(payloadList);
      } catch (e) {
        // Réseau injoignable : les éléments restent en attente (retry).
        debugPrint('[SyncService] Synchronisation impossible: $e');
        await refreshCount();
        return 0;
      }

      // Le serveur fait autorité : on marque uniquement les transmissions
      // confirmées ; les échecs restent dans la file.
      final echecs = result.echecIds.toSet();
      var done = 0;
      for (final item in pending) {
        if (echecs.contains(item.id)) {
          await _queue.markError(
            item.id,
            'Rejet serveur lors de la synchronisation',
          );
        } else {
          await _queue.markDone(item.id);
          done++;
        }
      }
      if (result.messages.isNotEmpty) {
        debugPrint(
          '[SyncService] Conflits/erreurs détectés: ${result.messages}',
        );
      }
      await refreshCount();
      return done;
    } finally {
      _flushing = false;
    }
  }

  Future<int> pendingCount() => _queue.pendingCount();

  Future<void> refreshCount() async {
    final n = await _queue.pendingCount();
    if (!_pendingController.isClosed) {
      _pendingController.add(n);
    }
  }

  Map<String, dynamic>? _decode(String json) {
    try {
      final decoded = jsonDecode(json);
      return decoded is Map<String, dynamic> ? decoded : null;
    } catch (e) {
      return null;
    }
  }

  Future<List<SyncQueueItem>> pendingItems() => _queue.pending();

  void dispose() {
    stopWatcher();
    _pendingController.close();
  }
}
