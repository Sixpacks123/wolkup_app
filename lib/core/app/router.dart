import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wolkup_app/features/auth/auth.dart';
import 'package:wolkup_app/features/auth/presentation/pages/auth_page.dart'; // Nouvelle page unique pour Auth
import 'package:wolkup_app/features/auth/presentation/states/auth.dart';
import 'package:wolkup_app/core/ui/ui.dart';
import 'router_notifier.dart';

part 'router.g.dart';

@riverpod
GoRouter router(RouterRef ref) {
  final auth = ref.watch(authProvider);

  return GoRouter(
    initialLocation: '/auth',
    refreshListenable: RouterNotifier(ref),
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const AppLayout(),
      ),
      GoRoute(
        path: '/auth',
        builder: (context, state) => const AuthPage(), // Affiche la page unique AuthPage
      ),
    ],
    redirect: (context, state) {
      final isAuthenticated = !auth.isEmpty;
      debugPrint('isAuth: $isAuthenticated, path: ${state.fullPath}');

      if (!isAuthenticated && state.fullPath == '/auth') {
        return null;
      }

      if (isAuthenticated && state.fullPath == '/auth') {
        return '/';
      }

      if (!isAuthenticated && state.fullPath != '/auth') {
        return '/auth';
      }

      return null;
    },
  );
}
