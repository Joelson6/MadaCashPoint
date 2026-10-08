import '../../../core/db/local_store.dart';
import '../../models/app_user.dart';

/// Accès aux comptes utilisateurs (RBAC, section 4).
class UserRepo {
  UserRepo(this._store);

  final LocalStore _store;

  Future<AppUser?> findByTelephone(String telephone) =>
      _store.userByTelephone(telephone);

  Future<AppUser?> findById(int id) => _store.userById(id);

  Future<void> put(AppUser user) => _store.putUser(user);

  Future<void> delete(int id) => _store.deleteUser(id);

  Future<List<AppUser>> all() => _store.allUsers();

  /// Authentification locale (failover offline) : téléphone + PIN haché.
  Future<AppUser?> login(String telephone, String pinHash) =>
      _store.userByTelephoneAndPin(telephone, pinHash);
}