import '../../../core/db/local_store.dart';
import '../../models/encaissement.dart';

/// Encaissements enregistrés sur le terrain (traçabilité, section 6.4).
class EncaissementRepo {
  EncaissementRepo(this._store);

  final LocalStore _store;

  Future<void> put(Encaissement e) => _store.putEncaissement(e);

  Future<List<Encaissement>> all() => _store.allEncaissements();

  Future<List<Encaissement>> forKiosque(String codeKiosque) =>
      _store.encaissementsForKiosque(codeKiosque);

  Future<List<Encaissement>> enAttente() => _store.encaissementsEnAttente();

  Future<int> compteEnAttente() => _store.encaissementsEnAttenteCount();

  Future<void> marquerSynchronise(int id) =>
      _store.marquerEncaissementSynchronise(id);
}