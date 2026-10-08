import '../../../data/remote/cuf_backend.dart';

class AuthState {
  final bool loading;
  final SessionInfo? session;
  final String? error;
  final bool otpPending;
  final String? demoOtp;
  final bool registering;
  final bool loggedOut;

  const AuthState({
    this.loading = false,
    this.session,
    this.error,
    this.otpPending = false,
    this.demoOtp,
    this.registering = false,
    this.loggedOut = false,
  });

  bool get isAuthenticated => session != null;
  bool get isAgent => session?.estAgent ?? false;

  /// Copie l'état en permettant d'**effacer explicitement** la session.
  ///
  /// `copyWith(session: null)` ne peut pas fonctionner avec un paramètre
  /// nullable : `null` signifie « ne pas modifier ». Avant ce correctif, la
  /// seule façon de se déconnecter était de construire un `AuthState` neuf ;
  /// toute évolution de `logout()` oubliant de le faire laissait
  /// l'utilisateur sur un écran authentifié.
  ///
  /// Attention : `error` et `demoOtp` sont volontairement **réinitialisés**
  /// quand le paramètre est omis. Un message d'erreur doit disparaître dès
  /// qu'une nouvelle opération démarre, et le code OTP ne doit jamais
  /// survivre à un changement d'étape ; conserver l'ancienne valeur
  /// exposait un code déjà consommé.
  AuthState copyWith({
    bool? loading,
    SessionInfo? session,
    bool clearSession = false,
    String? error,
    bool? otpPending,
    String? demoOtp,
    bool? registering,
    bool? loggedOut,
  }) {
    return AuthState(
      loading: loading ?? this.loading,
      session: clearSession ? null : (session ?? this.session),
      error: error,
      otpPending: otpPending ?? this.otpPending,
      demoOtp: demoOtp,
      registering: registering ?? this.registering,
      loggedOut: loggedOut ?? this.loggedOut,
    );
  }
}
