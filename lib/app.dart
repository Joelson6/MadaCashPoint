import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../core/di/service_locator.dart';
import 'features/auth/bloc/auth_cubit.dart';
import 'features/auth/presentation/auth_gate.dart';

/// Racine de l'application : fournit le [AuthCubit] au-dessus du Navigator
/// (accessible dans toutes les routes) puis délégué la construction du
/// MaterialApp à [AuthGate] (qui choisit les providers du domaine RBAC).
class CufApp extends StatelessWidget {
  const CufApp({super.key});

  @override
  Widget build(BuildContext context) {
    final sl = ServiceLocator.instance;
    return BlocProvider(
      // Le Cubit reçoit le SyncService : il démarre/arrête la surveillance de
      // la connectivité exactement sur le cycle de vie de la session.
      create: (_) =>
          AuthCubit(sl.backend, sl.secureStore, sl.syncService)
            ..restoreSession(),
      child: const AuthGate(),
    );
  }
}
