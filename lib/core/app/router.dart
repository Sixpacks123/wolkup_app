import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wolkup_app/features/auth/auth.dart';
import 'package:wolkup_app/features/auth/presentation/pages/login_page.dart';
import 'package:wolkup_app/features/auth/presentation/pages/register_page.dart';
import 'package:wolkup_app/features/auth/presentation/states/auth.dart';
import 'package:wolkup_app/features/home/home.dart';
import 'package:wolkup_app/features/profile/profile.dart';
import 'package:wolkup_app/core/ui/ui.dart';
import 'router_notifier.dart';

part 'router.g.dart';

@riverpod
GoRouter router(RouterRef ref) {
  final auth = ref.watch(authProvider);

  return GoRouter(
    initialLocation: '/login',
    refreshListenable: RouterNotifier(ref),
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const AppLayout(),
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: '/register',
        builder: (context, state) => const RegisterPage(),
      ),
    ],
    redirect: (context, state) {
      final isAuthenticated = !auth.isEmpty;
      debugPrint('isAuth: $isAuthenticated, path: ${state.fullPath}');

      if (!isAuthenticated &&
          (state.fullPath == '/login' || state.fullPath == '/register')) {
        return null;
      }

      if (isAuthenticated &&
          (state.fullPath == '/login' || state.fullPath == '/register')) {
        return '/';
      }

      if (!isAuthenticated &&
          state.fullPath != '/login' &&
          state.fullPath != '/register') {
        return '/login';
      }

      return null;
    },
  );
}
