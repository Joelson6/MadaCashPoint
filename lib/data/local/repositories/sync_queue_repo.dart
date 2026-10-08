import '../../../core/db/local_store.dart';
import '../../models/sync_queue_item.dart';

/// File d'attente de synchronisation offline-first (section 11).
class SyncQueueRepo {
  SyncQueueRepo(this._store);

  final LocalStore _store;

  Future<int> add(String methodName, Map<String, dynamic> payload) =>
      _store.addSyncQueueItem(methodName, payload);

  Future<List<SyncQueueItem>> pending() => _store.pendingSyncQueueItems();

  Future<int> pendingCount() => _store.pendingSyncQueueItemsCount();

  Future<void> markDone(int id) => _store.markSyncQueueItemDone(id);

  Future<void> markError(int id, String error) =>
      _store.markSyncQueueItemError(id, error);

  Future<void> remove(int id) => _store.removeSyncQueueItem(id);
}