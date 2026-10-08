import '../../../core/db/local_store.dart';
import '../../models/demande.dart';

/// Dossiers de demande d'autorisation (module Citoyen, section 5).
class DemandeRepo {
  DemandeRepo(this._store);

  final LocalStore _store;

  Future<void> put(Demande d) => _store.putDemande(d);

  Future<List<Demande>> byTelephone(String telephone) =>
      _store.demandesByTelephone(telephone);

  Future<Demande?> byCode(String codeDossier) =>
      _store.demandeByCode(codeDossier);

  Future<List<Demande>> nonSynchronisees() =>
      _store.demandesNonSynchronisees();

  Future<List<Demande>> all() => _store.allDemandes();
}