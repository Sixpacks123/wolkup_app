import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wolkup_app/features/auth/auth.dart';

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
