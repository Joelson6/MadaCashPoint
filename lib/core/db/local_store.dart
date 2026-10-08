import '../../data/models/anomalie.dart';
import '../../data/models/app_user.dart';
import '../../data/models/demande.dart';
import '../../data/models/encaissement.dart';
import '../../data/models/kiosque.dart';
import '../../data/models/notification_item.dart';
import '../../data/models/sync_queue_item.dart';

/// Abstraction de la persistance locale (offline-first, section 11).
///
/// Deux implémentations :
///  - [IsarLocalStore] sur mobile/desktop (Isar, natif).
///  - [MemoryLocalStore] sur web (en mémoire, car Isar 3.x n'est pas
///    disponible sur navigateur — remplacé par un cas de démonstration).
abstract class LocalStore {
  Future<void> init();
  Future<void> close();

  Future<T> writeTxn<T>(Future<T> Function() action);

  // --------------------------------------------------------------------------
  // Kiosque
  // --------------------------------------------------------------------------
  Future<Kiosque?> kiosqueByCode(String code);
  Future<void> putKiosque(Kiosque kiosque);
  Future<void> putKiosques(List<Kiosque> kiosques);
  Future<List<Kiosque>> recentKiosques({int limit});
  Future<List<Kiosque>> allKiosques();
  Future<int> kiosqueCount();
  Future<void> removeKiosque(String code);

  // --------------------------------------------------------------------------
  // AppUser
  // --------------------------------------------------------------------------
  Future<AppUser?> userByTelephone(String telephone);
  Future<AppUser?> userById(int id);
  Future<void> putUser(AppUser user);
  Future<void> deleteUser(int id);
  Future<List<AppUser>> allUsers();
  Future<AppUser?> userByTelephoneAndPin(String telephone, String pinHash);

  // --------------------------------------------------------------------------
  // Demande
  // --------------------------------------------------------------------------
  Future<void> putDemande(Demande demande);
  Future<List<Demande>> demandesByTelephone(String telephone);
  Future<Demande?> demandeByCode(String codeDossier);
  Future<List<Demande>> demandesNonSynchronisees();
  Future<List<Demande>> allDemandes();

  // --------------------------------------------------------------------------
  // Encaissement
  // --------------------------------------------------------------------------
  Future<void> putEncaissement(Encaissement encaissement);
  Future<List<Encaissement>> allEncaissements();
  Future<List<Encaissement>> encaissementsForKiosque(String codeKiosque);
  Future<List<Encaissement>> encaissementsEnAttente();
  Future<int> encaissementsEnAttenteCount();
  Future<void> marquerEncaissementSynchronise(int id);

  // --------------------------------------------------------------------------
  // Anomalie
  // --------------------------------------------------------------------------
  Future<void> putAnomalie(Anomalie anomalie);
  Future<List<Anomalie>> allAnomalies();
  Future<int> anomaliesEnAttenteCount();

  // --------------------------------------------------------------------------
  // Notification (sections 6.5 / 7 : anomalie -> notification Demandeur)
  // --------------------------------------------------------------------------
  Future<void> putNotification(NotificationItem notification);
  Future<List<NotificationItem>> notificationsFor(String telephone);
  Future<int> unreadNotificationsCount(String telephone);
  Future<void> markNotificationLu(String idUnique);

  // --------------------------------------------------------------------------
  // SyncQueue
  // --------------------------------------------------------------------------
  Future<int> addSyncQueueItem(String methodName, Map<String, dynamic> payload);
  Future<List<SyncQueueItem>> pendingSyncQueueItems();
  Future<int> pendingSyncQueueItemsCount();
  Future<void> markSyncQueueItemDone(int id);
  Future<void> markSyncQueueItemError(int id, String error);
  Future<void> removeSyncQueueItem(int id);
}