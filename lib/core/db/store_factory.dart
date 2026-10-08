import 'local_store.dart';
import 'local_store_io.dart' if (dart.library.js_interop) 'local_store_web.dart';

export 'local_store.dart' show LocalStore;

/// Crée le store local adapté à la plateforme :
/// Isar sur mobile/desktop, mémoire simulée sur navigateur (démo web).
// ignore: avoid_classes_with_only_static_members
class LocalStoreFactory {
  LocalStoreFactory._();

  static Future<LocalStore> create() => createLocalStore();
}