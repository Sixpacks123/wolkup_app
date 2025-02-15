import 'package:flutter/material.dart';

class AppColors {
  // Schéma de couleurs clair
  static const lightScheme = ColorScheme.light(
    primary: Color(0xff4F4898),
    onPrimary: Color(0xFF6D65BE),
    secondary: Color(0xff6CC0A8),
    onSecondary: Colors.white,
    surface: Color(0xFFF1F1F1),
    onSurface: Colors.black,
    primaryContainer: Color(0xFFF1F1F1),
    error: Colors.red,
    onError: Colors.white,
    tertiary: Color(0xffe5e2e1),
    shadow: Color(0xFF6D65BE),
  );

  // Schéma de couleurs sombre
  static const darkScheme = ColorScheme.dark(
    primary: Color(0xffc6c0ff),
    onPrimary: Color(0xff2c2373),
    secondary: Color(0xff8fe3c9),
    onSecondary: Color(0xff00382c),
    surface: Color(0xff141313),
    onSurface: Color(0xFFF1F1F1),
    background: Color(0xff1c1b1b),
    onBackground: Color(0xffe5e2e1),
    error: Color(0xffffb4ab),
    onError: Color(0xff690005),
    shadow: Color(0xFF6D65BE),

  );
}

class MaterialTheme {
  // Thème clair
  static ThemeData lightTheme() {
    return ThemeData(
      useMaterial3: true,
      colorScheme: AppColors.lightScheme,
      textTheme: _buildTextTheme(AppColors.lightScheme),
      scaffoldBackgroundColor: AppColors.lightScheme.background,
      elevatedButtonTheme: _buildElevatedButtonTheme(AppColors.lightScheme),
      outlinedButtonTheme: _buildOutlinedButtonTheme(AppColors.lightScheme),
      textButtonTheme: _buildTextButtonTheme(AppColors.lightScheme),
      inputDecorationTheme: _buildInputDecorationTheme(AppColors.lightScheme),
    );
  }

  // Thème sombre
  static ThemeData darkTheme() {
    return ThemeData(
      useMaterial3: true,
      colorScheme: AppColors.darkScheme,
      textTheme: _buildTextTheme(AppColors.darkScheme),
      scaffoldBackgroundColor: AppColors.darkScheme.background,
      elevatedButtonTheme: _buildElevatedButtonTheme(AppColors.darkScheme),
      outlinedButtonTheme: _buildOutlinedButtonTheme(AppColors.darkScheme),
      textButtonTheme: _buildTextButtonTheme(AppColors.darkScheme),
      inputDecorationTheme: _buildInputDecorationTheme(AppColors.darkScheme),
    );
  }

  // TextTheme dynamique
    static TextTheme _buildTextTheme(ColorScheme colorScheme) {
      return TextTheme(
        bodyLarge: const TextStyle(fontSize: 16, fontFamily: 'Clash'),
        bodyMedium: const TextStyle(fontSize: 14, fontFamily: 'Clash'),
        titleLarge: TextStyle(
          fontSize: 48,
          fontFamily: 'Longreach',
          fontWeight: FontWeight.bold,
          color: colorScheme.primary,
        ),
        titleSmall: TextStyle(
          fontSize: 24,
          fontFamily: 'Longreach',
          color: colorScheme.onPrimary,
        ),
        titleMedium: TextStyle(
          fontSize: 40,
          fontFamily: 'Longreach',
          color: colorScheme.onPrimary,
        ),
      ).apply(
        bodyColor: colorScheme.onSurface,
        displayColor: colorScheme.onSurface,
      );
    }


  // Thème des ElevatedButton
  static ElevatedButtonThemeData _buildElevatedButtonTheme(ColorScheme colorScheme) {
    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: colorScheme.primary,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        textStyle: const TextStyle(fontSize: 24, fontFamily: 'Longreach'),
      ),
    );
  }

  // Thème des OutlinedButton
  static OutlinedButtonThemeData _buildOutlinedButtonTheme(ColorScheme colorScheme) {
    return OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: colorScheme.secondary,
        side: BorderSide(color: colorScheme.secondary),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
    );
  }

  // Thème des TextButton
  static TextButtonThemeData _buildTextButtonTheme(ColorScheme colorScheme) {
    return TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: colorScheme.primary,
      ),
    );
  }

  // Thème des InputDecoration
  static InputDecorationTheme _buildInputDecorationTheme(ColorScheme colorScheme) {
    return InputDecorationTheme(
      filled: false,
      fillColor: colorScheme.surface,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: colorScheme.primary),
      ),
      hintStyle: TextStyle(color: colorScheme.onSurface, fontSize: 16, fontFamily: 'Roboto'),
      labelStyle: TextStyle(color: colorScheme.onSurface),
    );
  }
}
