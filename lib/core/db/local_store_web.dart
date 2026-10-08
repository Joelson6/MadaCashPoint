import 'dart:convert';
import 'dart:math';

import 'package:isar/isar.dart';

import '../../data/models/anomalie.dart';
import '../../data/models/app_user.dart';
import '../../data/models/demande.dart';
import '../../data/models/encaissement.dart';
import '../../data/models/kiosque.dart';
import '../../data/models/notification_item.dart';
import '../../data/models/sync_queue_item.dart';
import 'local_store.dart';

/// Implémentation web (navigateur).
///
/// Isar 3.x n'étant pas disponible sur navigateur (open() lève une erreur),
/// la persistance est simulée en mémoire pendant la session. Les données sont
/// réarmorcées à chaque chargement (démo de soutenance). Les identifiants
/// suivent la sémantique `@Index(unique, replace)` d'Isar.
Future<LocalStore> createLocalStore() => Future.value(MemoryLocalStore());

class MemoryLocalStore implements LocalStore {
  final List<Kiosque> _kiosques = <Kiosque>[];
  final List<AppUser> _users = <AppUser>[];
  final List<Demande> _demandes = <Demande>[];
  final List<Encaissement> _encaissements = <Encaissement>[];
  final List<Anomalie> _anomalies = <Anomalie>[];
  final List<NotificationItem> _notifications = <NotificationItem>[];
  final List<SyncQueueItem> _queue = <SyncQueueItem>[];

  int _nextId = 1;

  @override
  Future<void> init() async {}

  @override
  Future<void> close() async {}

  @override
  Future<T> writeTxn<T>(Future<T> Function() action) => action();

  int _assignId(int id) => id == Isar.autoIncrement ? _nextId++ : id;

  // --------------------------------------------------------------------------
  // Kiosque
  // --------------------------------------------------------------------------
  @override
  Future<Kiosque?> kiosqueByCode(String code) async {
    for (final k in _kiosques) {
      if (k.codeKiosque == code) return k;
    }
    return null;
  }

  @override
  Future<void> putKiosque(Kiosque kiosque) async {
    kiosque.id = _assignId(kiosque.id);
    final i = _kiosques.indexWhere(
      (k) => k.codeKiosque.toUpperCase() == kiosque.codeKiosque.toUpperCase(),
    );
    if (i >= 0) {
      _kiosques[i] = kiosque;
    } else {
      _kiosques.add(kiosque);
    }
  }

  @override
  Future<void> putKiosques(List<Kiosque> kiosques) async {
    for (final k in kiosques) {
      await putKiosque(k);
    }
  }

  @override
  Future<List<Kiosque>> recentKiosques({int limit = 20}) async {
    final list = [..._kiosques]
      ..sort((a, b) {
        final x = (a.lastSeenAt ?? DateTime(1970)).millisecondsSinceEpoch;
        final y = (b.lastSeenAt ?? DateTime(1970)).millisecondsSinceEpoch;
        return y.compareTo(x);
      });
    return list.take(limit).toList();
  }

  @override
  Future<List<Kiosque>> allKiosques() async => [..._kiosques];

  @override
  Future<int> kiosqueCount() async => _kiosques.length;

  @override
  Future<void> removeKiosque(String code) async {
    _kiosques.removeWhere(
      (k) => k.codeKiosque.toUpperCase() == code.toUpperCase(),
    );
  }

  // --------------------------------------------------------------------------
  // AppUser
  // --------------------------------------------------------------------------
  @override
  Future<AppUser?> userByTelephone(String telephone) async {
    for (final u in _users) {
      if (u.telephone == telephone) return u;
    }
    return null;
  }

  @override
  Future<AppUser?> userById(int id) async {
    for (final u in _users) {
      if (u.id == id) return u;
    }
    return null;
  }

  @override
  Future<void> putUser(AppUser user) async {
    user.id = _assignId(user.id);
    final i = _users.indexWhere((u) => u.telephone == user.telephone);
    if (i >= 0) {
      _users[i] = user;
    } else {
      _users.add(user);
    }
  }

  @override
  Future<void> deleteUser(int id) async {
    _users.removeWhere((u) => u.id == id);
  }

  @override
  Future<List<AppUser>> allUsers() async => [..._users];

  @override
  Future<AppUser?> userByTelephoneAndPin(
    String telephone,
    String pinHash,
  ) async {
    for (final u in _users) {
      if (u.telephone == telephone && u.pinCode == pinHash) return u;
    }
    return null;
  }

  // --------------------------------------------------------------------------
  // Demande
  // --------------------------------------------------------------------------
  /// Écrit un dossier **sans jamais dupliquer sa ligne ni son numéro**.
  ///
  /// Deux recherches, dans l'ordre de la base native (Isar) :
  ///  1. par `id` — une mise à jour (promotion d'un dossier `OFFLINE-…` vers
  ///     un numéro officiel) remplace sa ligne au lieu d'en ajouter une ;
  ///  2. par `codeDossier` — un objet neuf portant un numéro déjà présent
  ///     fusionne avec la ligne existante (le magasin natif fait de même).
  @override
  Future<void> putDemande(Demande demande) async {
    demande.id = _assignId(demande.id);
    var i = _demandes.indexWhere((d) => d.id == demande.id);
    if (i < 0) {
      i = _demandes.indexWhere((d) => d.codeDossier == demande.codeDossier);
    }
    if (i >= 0) {
      _demandes[i] = demande;
    } else {
      _demandes.add(demande);
    }
  }

  @override
  Future<List<Demande>> demandesByTelephone(String telephone) async {
    final list = _demandes.where((d) => d.telephone == telephone).toList()
      ..sort((a, b) => b.dateCreation.compareTo(a.dateCreation));
    return list;
  }

  @override
  Future<Demande?> demandeByCode(String codeDossier) async {
    for (final d in _demandes) {
      if (d.codeDossier == codeDossier) return d;
    }
    return null;
  }

  @override
  Future<List<Demande>> demandesNonSynchronisees() async =>
      _demandes.where((d) => !d.synchronise).toList();

  @override
  Future<List<Demande>> allDemandes() async => [..._demandes];

  // --------------------------------------------------------------------------
  // Encaissement
  // --------------------------------------------------------------------------
  @override
  Future<void> putEncaissement(Encaissement encaissement) async {
    encaissement.id = _assignId(encaissement.id);
    if (encaissement.numeroQuittance.isEmpty) {
      encaissement.numeroQuittance =
          'QUIT-WEB-${DateTime.now().millisecondsSinceEpoch}-${Random().nextInt(9999)}';
    }
    final i = _encaissements.indexWhere(
      (e) => e.numeroQuittance == encaissement.numeroQuittance,
    );
    if (i >= 0) {
      _encaissements[i] = encaissement;
    } else {
      _encaissements.add(encaissement);
    }
  }

  @override
  Future<List<Encaissement>> allEncaissements() async {
    final list = [..._encaissements]
      ..sort((a, b) => b.horodatage.compareTo(a.horodatage));
    return list;
  }

  @override
  Future<List<Encaissement>> encaissementsForKiosque(String codeKiosque) async {
    final list =
        _encaissements
            .where(
              (e) => e.codeKiosque.toUpperCase() == codeKiosque.toUpperCase(),
            )
            .toList()
          ..sort((a, b) => b.horodatage.compareTo(a.horodatage));
    return list;
  }

  @override
  Future<List<Encaissement>> encaissementsEnAttente() async =>
      _encaissements.where((e) => e.enAttenteSynchro).toList();

  @override
  Future<int> encaissementsEnAttenteCount() async =>
      _encaissements.where((e) => e.enAttenteSynchro).length;

  @override
  Future<void> marquerEncaissementSynchronise(int id) async {
    for (final e in _encaissements) {
      if (e.id == id) {
        e.enAttenteSynchro = false;
        e.synchroniseAt = DateTime.now();
        break;
      }
    }
  }

  // --------------------------------------------------------------------------
  // Anomalie
  // --------------------------------------------------------------------------
  @override
  Future<void> putAnomalie(Anomalie anomalie) async {
    anomalie.id = _assignId(anomalie.id);
    if (anomalie.reference.isEmpty) {
      anomalie.reference = 'AN-WEB-${Random().nextInt(90000) + 10000}';
    }
    _anomalies.add(anomalie);
  }

  @override
  Future<List<Anomalie>> allAnomalies() async {
    final list = [..._anomalies]
      ..sort((a, b) => b.dateSignalement.compareTo(a.dateSignalement));
    return list;
  }

  @override
  Future<int> anomaliesEnAttenteCount() async =>
      _anomalies.where((a) => a.enAttenteSynchro).length;

  // --------------------------------------------------------------------------
  // Notification
  // --------------------------------------------------------------------------
  @override
  Future<void> putNotification(NotificationItem notification) async {
    notification.id = _assignId(notification.id);
    final i = _notifications.indexWhere(
      (n) => n.idUnique == notification.idUnique,
    );
    if (i >= 0) {
      _notifications[i] = notification;
    } else {
      _notifications.add(notification);
    }
  }

  @override
  Future<List<NotificationItem>> notificationsFor(String telephone) async {
    final list =
        _notifications.where((n) => n.destinataire == telephone).toList()
          ..sort((a, b) => b.date.compareTo(a.date));
    return list;
  }

  @override
  Future<int> unreadNotificationsCount(String telephone) async =>
      _notifications.where((n) => n.destinataire == telephone && !n.lu).length;

  @override
  Future<void> markNotificationLu(String idUnique) async {
    for (final n in _notifications) {
      if (n.idUnique == idUnique) {
        n.lu = true;
        break;
      }
    }
  }

  // --------------------------------------------------------------------------
  // SyncQueue
  // --------------------------------------------------------------------------
  @override
  Future<int> addSyncQueueItem(
    String methodName,
    Map<String, dynamic> payload,
  ) async {
    final item = SyncQueueItem(
      methodName: methodName,
      payloadJson: jsonEncode(payload),
    );
    item.id = _assignId(item.id);
    _queue.add(item);
    return item.id;
  }

  @override
  Future<List<SyncQueueItem>> pendingSyncQueueItems() async {
    final list = _queue.where((i) => !i.done).toList()
      ..sort((a, b) => a.createdAt.compareTo(b.createdAt));
    return list;
  }

  @override
  Future<int> pendingSyncQueueItemsCount() async =>
      _queue.where((i) => !i.done).length;

  @override
  Future<void> markSyncQueueItemDone(int id) async {
    for (final i in _queue) {
      if (i.id == id) {
        i.done = true;
        i.syncedAt = DateTime.now();
        break;
      }
    }
  }

  @override
  Future<void> markSyncQueueItemError(int id, String error) async {
    for (final i in _queue) {
      if (i.id == id) {
        i.attempts += 1;
        i.error = error;
        break;
      }
    }
  }

  @override
  Future<void> removeSyncQueueItem(int id) async {
    _queue.removeWhere((i) => i.id == id);
  }
}
