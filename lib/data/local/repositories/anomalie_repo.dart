import '../../../core/db/local_store.dart';
import '../../models/anomalie.dart';

/// Anomalies signalées sur le terrain (section 6.5).
class AnomalieRepo {
  AnomalieRepo(this._store);

  final LocalStore _store;

  Future<void> put(Anomalie a) => _store.putAnomalie(a);

  Future<List<Anomalie>> all() => _store.allAnomalies();

  Future<int> enAttenteCount() => _store.anomaliesEnAttenteCount();
}