import '../../../core/db/local_store.dart';
import '../../models/kiosque.dart';

/// Cache local des fiches kiosques (volumétrie <= 10 000 fiches, section 9).
class KiosqueRepo {
  KiosqueRepo(this._store);

  final LocalStore _store;

  Future<Kiosque?> byCode(String code) => _store.kiosqueByCode(code);

  Future<void> put(Kiosque k) => _store.putKiosque(k);

  Future<void> putAll(List<Kiosque> list) => _store.putKiosques(list);

  Future<List<Kiosque>> recent({int limit = 20}) =>
      _store.recentKiosques(limit: limit);

  Future<List<Kiosque>> all() => _store.allKiosques();

  Future<int> count() => _store.kiosqueCount();

  Future<void> remove(String code) => _store.removeKiosque(code);
}