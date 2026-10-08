import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/theme/app_theme.dart';
import '../bloc/agent_cubit.dart';

/// Écouteur unique des messages transitoires d'[AgentCubit].
///
/// Le tableau de bord agent reste monté **sous** toutes les routes poussées
/// (dossiers, fiche kiosque, encaissement, anomalie…). S'il traitait
/// `infoMessage` / `error` même quand il n'est plus la route courante, il
/// effacerait les messages avant que l'écran empilé ne puisse les afficher :
/// l'utilisateur voyait alors un état vide au lieu de l'erreur + « Réessayer ».
///
/// Règle : seul l'écran **courant** consomme le message ; les autres laissent
/// l'état intact pour qu'il soit rendu (widget d'erreur) ou effacé au retour.
bool agentRouteCourante(BuildContext context) =>
    ModalRoute.of(context)?.isCurrent ?? false;

/// Conditions d'écoute : une seule notification par changement de message.
bool agentEcouteMessages(AgentState avant, AgentState apres) =>
    (apres.infoMessage != null && apres.infoMessage != avant.infoMessage) ||
    (apres.error != null && apres.error != avant.error);

/// Affiche les messages transitoires de [state] si [context] porte la route
/// courante, puis les efface du Cubit.
void agentAfficherMessages(BuildContext context, AgentState state) {
  if (!agentRouteCourante(context)) return;
  final messenger = ScaffoldMessenger.of(context);
  final info = state.infoMessage;
  final erreur = state.error;
  if (info != null) {
    messenger.showSnackBar(
      SnackBar(content: Text(info), backgroundColor: AppTheme.statutVert),
    );
  } else if (erreur != null) {
    messenger.showSnackBar(
      SnackBar(content: Text(erreur), backgroundColor: Colors.red.shade700),
    );
  }
  if (!context.mounted) return;
  context.read<AgentCubit>().clearTransient();
}
