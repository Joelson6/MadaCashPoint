import '../../../core/db/local_store.dart';
import '../../models/notification_item.dart';

/// Notifications persistantes destinées aux demandeurs (section 6.5).
class NotificationRepo {
  NotificationRepo(this._store);

  final LocalStore _store;

  Future<void> put(NotificationItem n) => _store.putNotification(n);

  Future<List<NotificationItem>> forTelephone(String telephone) =>
      _store.notificationsFor(telephone);

  Future<int> unreadCount(String telephone) =>
      _store.unreadNotificationsCount(telephone);

  Future<void> markLu(String idUnique) => _store.markNotificationLu(idUnique);
}