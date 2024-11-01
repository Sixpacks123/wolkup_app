import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../features/auth/domain/app_user.dart';
import '../../features/auth/presentation/states/auth.dart';

class RouterNotifier extends ChangeNotifier {
  final Ref _ref;

  RouterNotifier(this._ref) {
    // Écoute les changements d'état d'authentification
    _ref.listen<AppUser>(
      authProvider,
      (_, __) => notifyListeners(), // Notifie les changements
    );
  }
}
