import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

import '../../data/models/anomalie.dart';
import '../../data/models/app_user.dart';
import '../../data/models/demande.dart';
import '../../data/models/encaissement.dart';
import '../../data/models/kiosque.dart';
import '../../data/models/notification_item.dart';
import '../../data/models/sync_queue_item.dart';
import 'local_store.dart';

/// Implémentation native (Android/Windows) : base Isar.
Future<LocalStore> createLocalStore() => IsarLocalStore.open();

/// Accès à la base Isar unique de l'application.
///
/// Isar 3.x interdit d'ouvrir deux fois la même instance : `Isar.open()`
/// appelle `Isar._checkOpen()` qui lève
/// `IsarError('Instance has already been opened.')` dès que le nom est déjà
/// présent dans le registre `Isar._instances`. Or cet enregistrement se fait
/// dans le **constructeur** `Isar`, appelé par `openIsar()` *avant*
/// l'attachement des collections : une ouverture qui échoue laisse donc une
/// instance fantôme enregistrée, et toute tentative ultérieure échoue avec
/// « Instance has already been opened » au lieu de l'erreur d'origine.
///
/// [IsarLocalStore.openInstance] est donc le SEUL point d'entrée autorisé et
/// garantit : une seule ouverture, réutilisation de l'instance existante,
/// attente mutuelle des appels concurrents et rejouabilité après un échec.
class IsarLocalStore implements LocalStore {
  /// Nom de l'instance : une seule base Isar pour toute l'application.
  static const String instanceName = 'cuf_recouvrement';

  /// Schémas de la base, identiques à chaque ouverture.
  static final List<CollectionSchema<dynamic>> schemas = [
    AnomalieSchema,
    AppUserSchema,
    KiosqueSchema,
    DemandeSchema,
    EncaissementSchema,
    SyncQueueItemSchema,
    NotificationItemSchema,
  ];

  /// Ouverture en cours : un seul `Isar.open` est exécuté à la fois et tous
  /// les appelants concurrents observent le même résultat.
  static Future<Isar>? _opening;

  final Isar _isar;

  IsarLocalStore(this._isar);

  /// Ouverture idempotente et sûre en concurrence de l'instance Isar.
  ///
  /// - instance déjà ouverte et exploitable  -> réutilisation ;
  /// - ouverture déjà en cours              -> attente du même Future ;
  /// - instance fantôme (ouverture échouée)-> libération puis réouverture.
  static Future<Isar> openInstance() async {
    final registered = Isar.getInstance(instanceName);
    if (registered != null) {
      if (_isUsable(registered)) {
        debugPrint(
          '[ISAR] instance "$instanceName" déjà ouverte -> réutilisée',
        );
        return registered;
      }
      // Ouverture précédente interrompue : l'instance est enregistrée mais
      // ses collections ne sont pas attachées. Elle est libérée pour
      // permettre une réouverture propre (et non un message trompeur).
      debugPrint('[ISAR] instance "$instanceName" inexploitable -> libération');
      await registered.close();
    }

    final pending = _opening;
    if (pending != null) {
      debugPrint('[ISAR] ouverture déjà en cours -> attente du même Future');
      return pending;
    }

    final opening = _open();
    _opening = opening;
    try {
      return await opening;
    } finally {
      // Libère le verrou « en vol » : un échec doit rester rejouable.
      _opening = null;
    }
  }

  static Future<Isar> _open() async {
    final dir = await getApplicationDocumentsDirectory();
    debugPrint('[ISAR] ouverture de l\'instance "$instanceName" (${dir.path})');
    final isar = await Isar.open(
      schemas,
      directory: dir.path,
      name: instanceName,
    );
    debugPrint('[ISAR] instance ouverte');
    return isar;
  }

  /// Une instance n'est réutilisable que si elle est ouverte ET que ses
  /// collections sont attachées : `collection<T>()` lève sinon
  /// `LateInitializationError` ou `IsarError`.
  static bool _isUsable(Isar isar) {
    if (!isar.isOpen) return false;
    try {
      isar.collection<Kiosque>();
      return true;
    } catch (_) {
      return false;
    }
  }

  static Future<LocalStore> open() async =>
      IsarLocalStore(await openInstance());

  @override
  Future<void> init() async {}

  @override
  Future<void> close() async => _isar.close();

  @override
  Future<T> writeTxn<T>(Future<T> Function() action) => _isar.writeTxn(action);

  @override
  Future<Kiosque?> kiosqueByCode(String code) =>
      _isar.kiosques.where().codeKiosqueEqualTo(code).findFirst();

  @override
  Future<void> putKiosque(Kiosque kiosque) =>
      _isar.writeTxn(() => _isar.kiosques.put(kiosque));

  @override
  Future<void> putKiosques(List<Kiosque> kiosques) =>
      _isar.writeTxn(() => _isar.kiosques.putAll(kiosques));

  @override
  Future<List<Kiosque>> recentKiosques({int limit = 20}) =>
      _isar.kiosques.where().sortByLastSeenAtDesc().limit(limit).findAll();

  @override
  Future<List<Kiosque>> allKiosques() => _isar.kiosques.where().findAll();

  @override
  Future<int> kiosqueCount() => _isar.kiosques.count();

  @override
  Future<void> removeKiosque(String code) => _isar.writeTxn(
    () => _isar.kiosques.where().codeKiosqueEqualTo(code).deleteAll(),
  );

  @override
  Future<AppUser?> userByTelephone(String telephone) =>
      _isar.appUsers.where().telephoneEqualTo(telephone).findFirst();

  @override
  Future<AppUser?> userById(int id) => _isar.appUsers.get(id);

  @override
  Future<void> putUser(AppUser user) =>
      _isar.writeTxn(() => _isar.appUsers.put(user));

  @override
  Future<void> deleteUser(int id) =>
      _isar.writeTxn(() => _isar.appUsers.delete(id));

  @override
  Future<List<AppUser>> allUsers() => _isar.appUsers.where().findAll();

  @override
  Future<AppUser?> userByTelephoneAndPin(String telephone, String pinHash) =>
      _isar.appUsers
          .where()
          .telephoneEqualTo(telephone)
          .filter()
          .pinCodeEqualTo(pinHash)
          .findFirst();

  /// Écrit un dossier **sans jamais dupliquer son numéro**.
  ///
  /// Un objet neuf porte `id = Isar.autoIncrement` : `put()` insère alors une
  /// NOUVELLE ligne, même si un dossier porte déjà ce `codeDossier`. C'était
  /// la cause des doublons affichés dans le suivi (une même soumission
  /// produisait jusqu'à trois lignes). Le magasin mémoire (web) fusionnait
  /// déjà par code ; les deux implémentations sont donc maintenant cohérentes.
  @override
  Future<void> putDemande(Demande demande) => _isar.writeTxn(() async {
    if (demande.id == Isar.autoIncrement) {
      final existante = await _isar.demandes
          .filter()
          .codeDossierEqualTo(demande.codeDossier)
          .findFirst();
      if (existante != null) demande.id = existante.id;
    }
    await _isar.demandes.put(demande);
  });

  @override
  Future<List<Demande>> demandesByTelephone(String telephone) => _isar.demandes
      .filter()
      .telephoneEqualTo(telephone)
      .sortByDateCreationDesc()
      .findAll();

  @override
  Future<Demande?> demandeByCode(String codeDossier) =>
      _isar.demandes.filter().codeDossierEqualTo(codeDossier).findFirst();

  @override
  Future<List<Demande>> demandesNonSynchronisees() =>
      _isar.demandes.filter().synchroniseEqualTo(false).findAll();

  @override
  Future<List<Demande>> allDemandes() => _isar.demandes.where().findAll();

  @override
  Future<void> putEncaissement(Encaissement encaissement) =>
      _isar.writeTxn(() => _isar.encaissements.put(encaissement));

  @override
  Future<List<Encaissement>> allEncaissements() =>
      _isar.encaissements.where().sortByHorodatageDesc().findAll();

  @override
  Future<List<Encaissement>> encaissementsForKiosque(String codeKiosque) =>
      _isar.encaissements
          .filter()
          .codeKiosqueEqualTo(codeKiosque)
          .sortByHorodatageDesc()
          .findAll();

  @override
  Future<List<Encaissement>> encaissementsEnAttente() =>
      _isar.encaissements.filter().enAttenteSynchroEqualTo(true).findAll();

  @override
  Future<int> encaissementsEnAttenteCount() =>
      _isar.encaissements.filter().enAttenteSynchroEqualTo(true).count();

  @override
  Future<void> marquerEncaissementSynchronise(int id) =>
      _isar.writeTxn(() async {
        final e = await _isar.encaissements.get(id);
        if (e != null) {
          e.enAttenteSynchro = false;
          e.synchroniseAt = DateTime.now();
          await _isar.encaissements.put(e);
        }
      });

  @override
  Future<void> putAnomalie(Anomalie anomalie) =>
      _isar.writeTxn(() => _isar.anomalies.put(anomalie));

  @override
  Future<List<Anomalie>> allAnomalies() =>
      _isar.anomalies.where().sortByDateSignalementDesc().findAll();

  @override
  Future<int> anomaliesEnAttenteCount() =>
      _isar.anomalies.filter().enAttenteSynchroEqualTo(true).count();

  @override
  Future<void> putNotification(NotificationItem notification) => _isar
      .writeTxn(() => _isar.notificationItems.put(notification));

  @override
  Future<List<NotificationItem>> notificationsFor(String telephone) => _isar
      .notificationItems
      .where()
      .destinataireEqualTo(telephone)
      .sortByDateDesc()
      .findAll();

  @override
  Future<int> unreadNotificationsCount(String telephone) => _isar
      .notificationItems
      .where()
      .destinataireEqualTo(telephone)
      .filter()
      .luEqualTo(false)
      .count();

  @override
  Future<void> markNotificationLu(String idUnique) => _isar.writeTxn(() async {
    final item = await _isar.notificationItems
        .where()
        .idUniqueEqualTo(idUnique)
        .findFirst();
    if (item != null && !item.lu) {
      item.lu = true;
      await _isar.notificationItems.put(item);
    }
  });

  @override
  Future<int> addSyncQueueItem(
    String methodName,
    Map<String, dynamic> payload,
  ) => _isar.writeTxn(
    () => _isar.syncQueueItems.put(
      SyncQueueItem(methodName: methodName, payloadJson: jsonEncode(payload)),
    ),
  );

  @override
  Future<List<SyncQueueItem>> pendingSyncQueueItems() => _isar.syncQueueItems
      .filter()
      .doneEqualTo(false)
      .sortByCreatedAt()
      .findAll();

  @override
  Future<int> pendingSyncQueueItemsCount() =>
      _isar.syncQueueItems.filter().doneEqualTo(false).count();

  @override
  Future<void> markSyncQueueItemDone(int id) => _isar.writeTxn(() async {
    final item = await _isar.syncQueueItems.get(id);
    if (item != null) {
      item.done = true;
      item.syncedAt = DateTime.now();
      await _isar.syncQueueItems.put(item);
    }
  });

  @override
  Future<void> markSyncQueueItemError(int id, String error) =>
      _isar.writeTxn(() async {
        final item = await _isar.syncQueueItems.get(id);
        if (item != null) {
          item.attempts += 1;
          item.error = error;
          await _isar.syncQueueItems.put(item);
        }
      });

  @override
  Future<void> removeSyncQueueItem(int id) =>
      _isar.writeTxn(() => _isar.syncQueueItems.delete(id));
}
