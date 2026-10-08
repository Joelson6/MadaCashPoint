import 'dart:async';

import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';

import '../../core/config/app_config.dart';
import '../localization/app_localizations.dart';
import '../security/secure_store.dart';
import '../utils/formatters.dart' show Crypto;

/// Clé de navigation globale : permet de pousser l'overlay de verrouillage
/// au-dessus de n'importe quelle route.
final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();

/// Résultat d'une tentative de déverrouillage par PIN.
enum UnlockResult {
  /// PIN correct : l'application est déverrouillée.
  success,

  /// PIN incorrect.
  wrongPin,

  /// Aucun hash de PIN en session : impossible de vérifier le code saisi.
  /// On refuse le déverrouillage au lieu d'accepter n'importe quel code.
  noPinConfigured,
}

/// Verrouillage automatique de l'application agent après 5 minutes
/// d'inactivité (sections 4.3 / 10 du CDC).
/// Le déverrouillage nécessite le PIN (4-6 chiffres) ou la biométrie.
class AutoLockService {
  AutoLockService._();

  static final AutoLockService instance = AutoLockService._();

  /// Délai avant verrouillage : plus long que 10 s pour ne pas compter les
  /// hésitations de saisie comme une absence d'activité.
  static const _tick = Duration(seconds: 10);

  Timer? _timer;
  DateTime _lastActivity = DateTime.now();
  VoidCallback? _onLock;
  bool _locked = false;

  /// Nombre d'écrans [AutoLockScaffold] actuellement montés.
  ///
  /// Le timer était arrêté par le `dispose` de chaque écran : en revenant
  /// d'un écran empilé vers l'écran précédent, le timer du nouvel écran
  /// était annulé et le verrouillage automatique ne se déclenchait plus
  /// du tout. Le compteur évite ce trou de sécurité.
  int _owners = 0;

  bool get isLocked => _locked;

  void recordActivity() {
    _lastActivity = DateTime.now();
  }

  /// Enregistre un propriétaire d'écran et (re)démarre la surveillance.
  void startTimer({VoidCallback? onLock}) {
    if (onLock != null) _onLock = onLock;
    _owners++;
    recordActivity();
    _timer ??= Timer.periodic(_tick, (_) {
      if (!_locked &&
          DateTime.now().difference(_lastActivity) > AppConfig.autoLockDelay) {
        _locked = true;
        _onLock?.call();
      }
    });
  }

  /// Libère un propriétaire d'écran ; le timer s'arrête quand le dernier
  /// propriétaire disparaît.
  void stopTimer() {
    if (_owners > 0) _owners--;
    if (_owners > 0) return;
    _timer?.cancel();
    _timer = null;
  }

  /// Verrouille et pousse l'écran de déverrouillage via le navigateur racine.
  void lockNow() {
    if (_locked) return;
    _locked = true;
    _onLock?.call();
  }

  /// Déverrouillage avec code PIN (hash SHA-256 conservé en session).
  ///
  /// Refuse tout code si le hash n'est pas disponible : accepter un PIN
  /// quelconque en l'absence de référence neutralisait le contrôle d'accès.
  UnlockResult unlock(String pin) {
    final pinHashSession = SecureStore.instance.prefs.getString(
      'session.pin_hash',
    );
    if (pinHashSession == null) return UnlockResult.noPinConfigured;
    if (Crypto.sha256(pin.trim()) != pinHashSession) {
      return UnlockResult.wrongPin;
    }
    _locked = false;
    recordActivity();
    return UnlockResult.success;
  }

  /// Déverrouillage biométrique (empreinte digitale).
  Future<bool> unlockBiometric() async {
    final localAuth = LocalAuthentication();
    try {
      final available = await localAuth.isDeviceSupported();
      if (!available) return false;
      final ok = await localAuth.authenticate(
        localizedReason: 'Veuillez vous authentifier avec votre empreinte.',
        options: const AuthenticationOptions(biometricOnly: true),
      );
      if (ok) {
        _locked = false;
        recordActivity();
        return true;
      }
    } catch (e, s) {
      debugPrint('[AutoLockService] biométrie indisponible : $e\n$s');
    }
    return false;
  }

  /// Déverrouille sans PIN. Réservé aux transitions de cycle de vie où le
  /// verrouillage n'a jamais été armé (démarrage, retour de session).
  void reset() {
    _locked = false;
    recordActivity();
  }

  /// Réinitialisation complète à la déconnexion : plus aucun écran surveillé,
  /// plus aucun owner, verrouillage désarmé.
  void shutdown() {
    _owners = 0;
    _timer?.cancel();
    _timer = null;
    _onLock = null;
    _locked = false;
  }
}

/// Cadre des écrans agent : détecte l'inactivité et verrouille l'application
/// au-dessus de toutes les routes (via [rootNavigatorKey]).
class AutoLockScaffold extends StatefulWidget {
  final Widget child;
  final String title;
  final List<Widget>? actions;
  const AutoLockScaffold({
    super.key,
    required this.child,
    required this.title,
    this.actions,
  });

  @override
  State<AutoLockScaffold> createState() => _AutoLockScaffoldState();
}

class _AutoLockScaffoldState extends State<AutoLockScaffold> {
  @override
  void initState() {
    super.initState();
    AutoLockService.instance.startTimer(
      onLock: () {
        final nav = rootNavigatorKey.currentState;
        if (nav != null) {
          nav.push(
            MaterialPageRoute(
              fullscreenDialog: true,
              builder: (_) => const LockOverlayScreen(),
            ),
          );
        }
      },
    );
  }

  @override
  void dispose() {
    AutoLockService.instance.stopTimer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final auth = AutoLockService.instance;
    return Listener(
      behavior: HitTestBehavior.opaque,
      onPointerDown: (_) => auth.recordActivity(),
      child: Scaffold(
        appBar: AppBar(title: Text(widget.title), actions: widget.actions),
        body: widget.child,
      ),
    );
  }
}

/// Écran plein écran de verrouillage obligatoire (PIN ou empreinte).
class LockOverlayScreen extends StatefulWidget {
  const LockOverlayScreen({super.key});

  @override
  State<LockOverlayScreen> createState() => _LockOverlayScreenState();
}

class _LockOverlayScreenState extends State<LockOverlayScreen> {
  final _pinCtrl = TextEditingController();
  String? _error;

  @override
  void dispose() {
    _pinCtrl.dispose();
    super.dispose();
  }

  Future<void> _biometric() async {
    final ok = await AutoLockService.instance.unlockBiometric();
    if (ok && mounted) Navigator.of(context).pop(true);
  }

  void _unlock() {
    final res = AutoLockService.instance.unlock(_pinCtrl.text);
    if (res == UnlockResult.success) {
      Navigator.of(context).pop(true);
      return;
    }
    setState(() {
      _error = res == UnlockResult.noPinConfigured
          // Aucun hash de PIN en session : le code saisi ne peut pas être
          // vérifié. On ne déverrouille pas, et on ne laisse pas croire à une
          // simple erreur de frappe.
          ? 'Aucun code PIN enregistré pour cette session. Déconnectez-vous et reconnectez-vous.'
          : 'Code PIN incorrect';
    });
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: Colors.grey.shade900,
        appBar: AppBar(
          backgroundColor: Colors.grey.shade900,
          foregroundColor: Colors.white,
          title: Text(
            l.t('locked_title'),
            style: const TextStyle(color: Colors.white),
          ),
          automaticallyImplyLeading: false,
        ),
        body: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(32),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.lock, color: Colors.white70, size: 80),
                const SizedBox(height: 24),
                Text(
                  l.t('unlock_pin'),
                  style: const TextStyle(color: Colors.white70, fontSize: 14),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                TextField(
                  controller: _pinCtrl,
                  obscureText: true,
                  keyboardType: TextInputType.number,
                  maxLength: 6,
                  autofocus: true,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    letterSpacing: 8,
                  ),
                  decoration: InputDecoration(
                    hintText: '••••',
                    hintStyle: const TextStyle(
                      color: Colors.white30,
                      letterSpacing: 8,
                    ),
                    counterText: '',
                    border: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white24),
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white24),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    errorText: _error,
                  ),
                  onSubmitted: (_) => _unlock(),
                ),
                const SizedBox(height: 16),
                ElevatedButton.icon(
                  onPressed: _unlock,
                  icon: const Icon(Icons.lock_open),
                  label: Text(l.t('ok')),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white24,
                  ),
                ),
                const SizedBox(height: 12),
                TextButton.icon(
                  onPressed: _biometric,
                  icon: const Icon(Icons.fingerprint, color: Colors.white60),
                  label: Text(
                    l.t('biometric'),
                    style: const TextStyle(color: Colors.white60),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
