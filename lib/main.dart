import 'package:flutter/material.dart';

import 'app.dart';
import 'core/di/service_locator.dart';
import 'core/theme/app_theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const CufRoot());
}

/// Racine réelle de l'application.
///
/// `runApp()` ne fournit que `View > MediaQuery > FocusTraversalGroup` :
/// **aucun** `Directionality`, `MaterialLocalizations` ni `Navigator` n'existe
/// au-dessus du widget passé à `runApp`. Passer directement un `Scaffold`
/// (ou appeler `Navigator.of(context)`) provoque donc un échec de build et
/// laisse la fenêtre Android entièrement blanche.
///
/// [CufRoot] porte l'initialisation et affiche un `MaterialApp` minimal le
/// temps du démarrage, puis bascule vers [CufApp] (qui construit son propre
/// `MaterialApp`) — sans dépendre d'un `Navigator` pour la transition.
class CufRoot extends StatefulWidget {
  const CufRoot({super.key});

  @override
  State<CufRoot> createState() => _CufRootState();
}

class _CufRootState extends State<CufRoot> {
  Object? _error;
  bool _booting = false;

  @override
  void initState() {
    super.initState();
    _bootstrap();
  }

  /// Démarrage unique et rejouable.
  ///
  /// Anti-réentrance : un second appel (double appui sur « Réessayer »,
  /// reconstruction de l'arbre) est ignoré tant que l'amorçage est en cours —
  /// `ServiceLocator.init()` est lui-même idempotent, mais inutile de
  /// déclencher une seconde chaîne.
  Future<void> _bootstrap() async {
    if (_booting) return;
    _booting = true;
    if (_error != null && mounted) setState(() => _error = null);
    try {
      // Initialisation de la base Isar (offline-first), du stockage sécurisé,
      // du back-end embarqué (serveur XML-RPC local) et du service de synchro.
      await ServiceLocator.instance.init();
      if (!mounted) return;
      setState(() => _error = null);
    } catch (e, s) {
      debugPrint('[BOOT] Échec d\'initialisation : $e\n$s');
      if (!mounted) return;
      setState(() => _error = e);
    } finally {
      _booting = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (ServiceLocator.instance.isInitialized) return const CufApp();
    return MaterialApp(
      title: 'MadaCash',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      home: BootScreen(error: _error, busy: _booting, onRetry: _bootstrap),
    );
  }
}

/// Démarrage sécurisé : toute exception d'initialisation (base Isar,
/// stockage sécurisé, back-end embarqué) est affichée à l'écran en rouge
/// au lieu de laisser un écran noir illisible sur le téléphone.
class BootScreen extends StatelessWidget {
  final Object? error;
  final Future<void> Function() onRetry;

  /// Amorçage en cours : le bouton « Réessayer » est neutralisé pour ne pas
  /// empiler des initialisations concurrentes.
  final bool busy;

  const BootScreen({
    super.key,
    this.error,
    required this.onRetry,
    this.busy = false,
  });

  @override
  Widget build(BuildContext context) {
    if (error != null) {
      return Scaffold(
        backgroundColor: Colors.deepOrange,
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.error_outline, color: Colors.white, size: 56),
                const SizedBox(height: 16),
                Text(
                  'Échec du démarrage',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                SelectableText(
                  '$error',
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white, fontSize: 14),
                ),
                const SizedBox(height: 24),
                FilledButton.icon(
                  onPressed: busy ? null : onRetry,
                  icon: const Icon(Icons.refresh),
                  label: const Text('Réessayer'),
                ),
              ],
            ),
          ),
        ),
      );
    }
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text('Démarrage de MadaCash…'),
          ],
        ),
      ),
    );
  }
}
