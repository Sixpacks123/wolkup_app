// lib/themes/theme_provider.dart

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'material_theme.dart';

class ThemeNotifier extends StateNotifier<ThemeData> {
  ThemeNotifier() : super(MaterialTheme.lightTheme());

  // Basculer entre les thèmes clair et sombre
  void toggleTheme() {
    state = state.brightness == Brightness.light
        ? MaterialTheme.darkTheme()
        : MaterialTheme.lightTheme();
  }
}

// Provider pour accéder au thème actuel
final themeProvider = StateNotifierProvider<ThemeNotifier, ThemeData>((ref) {
  return ThemeNotifier();
});
