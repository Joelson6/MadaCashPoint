import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/security/auto_lock.dart';
import '../../../core/security/secure_store.dart';
import '../../../core/service/sync_service.dart';
import '../../../core/utils/formatters.dart';
import '../../../data/remote/cuf_backend.dart';
import 'auth_state.dart';

/// Gestion de la connexion universelle, de l'inscription OTP et des sessions
/// (section 4 du CDC). RBAC : le rôle renvoyé par le serveur oriente l'UI.
///
/// Cycle de vie de session appliqué à **toutes** les issues possibles
/// (connexion, inscription, restauration au démarrage, déconnexion) :
///   startsServices() → session persistée + services utilisateur démarrés
///   stopServices()   → file de synchro purgée avant fermeture, watcher
///                      de connectivité arrêté, verrouillage auto remis à zéro
/// Sans cela, un utilisateur déconnecté continuait de déclencher des
/// synchronisations et le nouvel arrivant héritait du verrouillage de
/// l'ancien (exigence prompt §5 : « services utilisateur arrêtés »).
class AuthCubit extends Cubit<AuthState> {
  final CufBackend _backend;
  final SecureStore _store;
  final SyncService? _sync;

  AuthCubit(this._backend, this._store, [this._sync])
    : super(const AuthState());

  /// Restaure la session persistée au lancement.
  /// Blindé : une session corrompue/incomplète est ignorée (retour à
  /// l'écran de connexion) au lieu de lever une exception synchrone dans
  /// le `create:` du BlocProvider (cause d'écran noir au démarrage).
  void restoreSession() {
    try {
      final s = _store.loadSession();
      if (s == null) {
        emit(const AuthState());
        return;
      }
      final tel = s['telephone'];
      final nom = s['nom'];
      final role = s['role'];
      final token = s['sessionToken'];
      if (tel is! String ||
          nom is! String ||
          role is! String ||
          token is! String ||
          tel.trim().isEmpty ||
          token.trim().isEmpty ||
          role.trim().isEmpty) {
        // Session incomplète : on ne devine pas le rôle, on invalide.
        unawaited(_store.clearSession());
        emit(const AuthState());
        return;
      }
      emit(
        AuthState(
          session: SessionInfo(
            telephone: tel,
            nom: nom,
            role: role,
            sessionToken: token,
          ),
        ),
      );
      startServices();
    } catch (e, s) {
      debugPrint('[AUTH] session illisible, retour connexion : $e\n$s');
      unawaited(_store.clearSession());
      emit(const AuthState());
    }
  }

  bool hasStoredSession() => _store.isLoggedIn();

  /// user_login(phone_number, pin_code)
  Future<void> login(String phone, String pin) async {
    emit(state.copyWith(loading: true, error: null));
    try {
      final session = await _backend.userLogin(phone, pin);
      await _store.prefs.setString(
        'session.pin_hash',
        Crypto.sha256(pin.trim()),
      );
      emit(
        state.copyWith(
          loading: false,
          session: session,
          clearSession: false,
          loggedOut: false,
        ),
      );
      startServices();
    } catch (e) {
      emit(state.copyWith(loading: false, error: _msg(e)));
    }
  }

  /// Envoi du code OTP SMS (auto-inscription demandeur, section 4.2).
  Future<void> requestOtp(String phone) async {
    emit(state.copyWith(loading: true, error: null));
    try {
      final otp = await _backend.requestOtp(phone);
      emit(
        state.copyWith(
          loading: false,
          otpPending: true,
          demoOtp: otp.isEmpty ? null : otp,
        ),
      );
    } catch (e) {
      emit(state.copyWith(loading: false, error: _msg(e)));
    }
  }

  /// verify_otp + création du compte demandeur.
  Future<void> registerCitoyen(Map<String, dynamic> payload) async {
    emit(state.copyWith(loading: true, error: null, registering: true));
    try {
      final session = await _backend.verifyOtpAndRegister(payload);
      await _store.prefs.setString(
        'session.pin_hash',
        Crypto.sha256('${payload['pin'] ?? ''}'.trim()),
      );
      emit(
        state.copyWith(
          loading: false,
          registering: false,
          session: session,
          clearSession: false,
          loggedOut: false,
          otpPending: false,
          demoOtp: null,
        ),
      );
      startServices();
    } catch (e) {
      emit(state.copyWith(loading: false, error: _msg(e), registering: false));
    }
  }

  /// Déconnexion : session supprimée, services utilisateur arrêtés, retour
  /// Login. L'état est réémis même si l'arrêt des services échoue : sans cela
  /// une erreur d'écriture en preferences laissait l'utilisateur sur un écran
  /// authentifié avec une session que le stockage ne contient plus.
  Future<void> logout() async {
    try {
      await stopServices();
    } catch (e) {
      debugPrint('[AUTH] arrêt des services incomplet à la déconnexion : $e');
    }
    emit(
      state.copyWith(
        loading: false,
        clearSession: true,
        error: null,
        otpPending: false,
        demoOtp: null,
        registering: false,
        loggedOut: true,
      ),
    );
  }

  /// Démarre les services liés à une session ouverte (file de synchronisation,
  /// surveillance de la connectivité). Idempotent.
  void startServices() {
    AutoLockService.instance.reset();
    _sync?.startWatcher();
  }

  /// Arrête les services liés à une session et conserve les données locales.
  Future<void> stopServices() async {
    await _sync?.stopWatcher();
    AutoLockService.instance.shutdown();
    try {
      // Purge finale : rien ne doit rester en file à la déconnexion.
      await _sync?.flush();
    } catch (e) {
      debugPrint('[AUTH] purge de la file impossible à la déconnexion : $e');
    }
    await _store.clearSession();
    await _store.prefs.remove('session.pin_hash');
  }

  String _msg(Object e) => e is ArgumentError
      ? e.message?.toString() ?? 'Identifiants invalides'
      : e.toString().replaceFirst('Bad state: ', '');
}
