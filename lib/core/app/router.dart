import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:wolkup_app/features/auth/domain/app_user.dart';
import 'package:wolkup_app/features/auth/presentation/pages/login_page.dart';
import 'package:wolkup_app/features/auth/presentation/pages/register_page.dart';
import 'package:wolkup_app/features/auth/presentation/states/auth.dart';
import '../../features/profile/presentation/pages/personal_info_page.dart';
import '../../features/profile/presentation/pages/settings_page.dart';
import '../../features/profile/presentation/pages/user_profile_page.dart';
import '../ui/app_layout.dart';
import 'router_notifier.dart';

part 'router.g.dart';

@riverpod
GoRouter router(RouterRef ref) {
  final auth = ref.watch(authProvider);

  return GoRouter(
    initialLocation: '/auth/login', // Change the initial route
    refreshListenable: RouterNotifier(ref),
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const AppLayout(),
      ),
      GoRoute(
        path: '/auth/login',
        builder: (context, state) => const LoginPage(), // Login page
      ),
      GoRoute(
        path: '/auth/register',
        builder: (context, state) => const RegisterPage(), // Register page
      ),
      GoRoute(
        path: '/settings',
        builder: (context, state) => const SettingsPage(), // Settings page
      ),
      GoRoute(
        path: '/settings/personal_info',
        builder: (context, state) => const PersonalInfoPage(), // Personal info page
      ),
      GoRoute(
        path: '/profile',
        builder: (context, state)=>   const UserProfilePage(),
      )
    ],
    redirect: (context, state) {
      final isAuthenticated = !auth.isEmpty;
      debugPrint('isAuth: $isAuthenticated, path: ${state.fullPath}');

      if (!isAuthenticated && state.fullPath == '/auth') {
        return null;
      }

      if (isAuthenticated && state.fullPath!.startsWith('/auth')) {
        return '/';
      }

      if (!isAuthenticated && !state.fullPath!.startsWith('/auth')) {
        return '/auth/login'; // Redirect to login if not authenticated
      }

      return null;
    },
  );
}
