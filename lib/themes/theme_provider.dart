import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'theme.dart';

class ThemeNotifier extends StateNotifier<ThemeData> {
  ThemeNotifier() : super(MaterialTheme.lightTheme());

  // Basculer entre les thèmes clair et sombre
  void toggleTheme() {
    state = state.brightness == Brightness.light
        ? MaterialTheme.darkTheme()
        : MaterialTheme.lightTheme();
  }
}

// Fournisseur de thème
final themeProvider = StateNotifierProvider<ThemeNotifier, ThemeData>((ref) {
  return ThemeNotifier();
});
