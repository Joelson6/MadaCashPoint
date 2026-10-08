import 'package:isar/isar.dart';

part 'sync_queue_item.g.dart';

/// File d'attente de synchronisation offline-first (section 11 du CDC).
/// Chaque opération non transmise est stockée ici avec sa méthode XML-RPC.
@collection
class SyncQueueItem {
  Id id = Isar.autoIncrement;

  /// Méthode XML-RPC : sync_offline_queue, register_encaissement,
  /// submit_demande_autorisation, signaler_anomalie...
  late String methodName;

  /// Payload JSON (schéma d'échange section 8).
  late String payloadJson;

  DateTime createdAt = DateTime.now();
  int attempts = 0;
  bool done = false;
  String? error;
  DateTime? syncedAt;

  SyncQueueItem({required this.methodName, required this.payloadJson});
}