import "package:flutter/material.dart";

class MaterialTheme {
  final TextTheme textTheme;

  const MaterialTheme(this.textTheme);

  static ColorScheme lightScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff3b3382),
      surfaceTint: Color(0xff5b54a5),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff5e58a9),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0x006dc0a8),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff78cbb2),
      onSecondaryContainer: Color(0xff00352a),
      tertiary: Color(0xff5d5f5f),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xfff3f3f3),
      onTertiaryContainer: Color(0xff505252),
      error: Color(0xffba1a1a),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffffdad6),
      onErrorContainer: Color(0xff410002),
      surface: Color(0xfffcf8f8),
      onSurface: Color(0xff1c1b1b),
      onSurfaceVariant: Color(0xff424846),
      outline: Color(0xff727876),
      outlineVariant: Color(0xffc1c8c5),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff313030),
      inversePrimary: Color(0xffc6c0ff),
      primaryFixed: Color(0xffe4dfff),
      onPrimaryFixed: Color(0xff16065f),
      primaryFixedDim: Color(0xffc6c0ff),
      onPrimaryFixedVariant: Color(0xff433c8b),
      secondaryFixed: Color(0xff9ff3d9),
      onSecondaryFixed: Color(0xff002019),
      secondaryFixedDim: Color(0xff83d6bd),
      onSecondaryFixedVariant: Color(0xff005141),
      tertiaryFixed: Color(0xffe2e2e2),
      onTertiaryFixed: Color(0xff1a1c1c),
      tertiaryFixedDim: Color(0xffc6c6c7),
      onTertiaryFixedVariant: Color(0xff454747),
      surfaceDim: Color(0xffddd9d9),
      surfaceBright: Color(0xfffcf8f8),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff6f3f2),
      surfaceContainer: Color(0xfff1edec),
      surfaceContainerHigh: Color(0xffebe7e7),
      surfaceContainerHighest: Color(0xffe5e2e1),
    );
  }

  ThemeData light() {
    return theme(lightScheme());
  }

  static ColorScheme lightMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff3b3382),
      surfaceTint: Color(0xff5b54a5),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff5e58a9),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff004c3d),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff2b826d),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff414343),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff737575),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff8c0009),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffda342e),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfffcf8f8),
      onSurface: Color(0xff1c1b1b),
      onSurfaceVariant: Color(0xff3e4442),
      outline: Color(0xff5a605e),
      outlineVariant: Color(0xff757c7a),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff313030),
      inversePrimary: Color(0xffc6c0ff),
      primaryFixed: Color(0xff716abd),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff5851a2),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff2b826d),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff006955),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff737575),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff5b5c5c),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffddd9d9),
      surfaceBright: Color(0xfffcf8f8),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff6f3f2),
      surfaceContainer: Color(0xfff1edec),
      surfaceContainerHigh: Color(0xffebe7e7),
      surfaceContainerHighest: Color(0xffe5e2e1),
    );
  }

  ThemeData lightMediumContrast() {
    return theme(lightMediumContrastScheme());
  }

  static ColorScheme lightHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff1d1165),
      surfaceTint: Color(0xff5b54a5),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff3f3787),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff00281f),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff004c3d),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff212323),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff414343),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff4e0002),
      onError: Color(0xffffffff),
      errorContainer: Color(0xff8c0009),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfffcf8f8),
      onSurface: Color(0xff000000),
      onSurfaceVariant: Color(0xff1f2523),
      outline: Color(0xff3e4442),
      outlineVariant: Color(0xff3e4442),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff313030),
      inversePrimary: Color(0xffeee9ff),
      primaryFixed: Color(0xff3f3787),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff281f6f),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff004c3d),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff003429),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff414343),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff2b2d2d),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffddd9d9),
      surfaceBright: Color(0xfffcf8f8),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff6f3f2),
      surfaceContainer: Color(0xfff1edec),
      surfaceContainerHigh: Color(0xffebe7e7),
      surfaceContainerHighest: Color(0xffe5e2e1),
    );
  }

  ThemeData lightHighContrast() {
    return theme(lightHighContrastScheme());
  }

  static ColorScheme darkScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffc6c0ff),
      surfaceTint: Color(0xffc6c0ff),
      onPrimary: Color(0xff2c2373),
      primaryContainer: Color(0xff453e8e),
      onPrimaryContainer: Color(0xffe6e1ff),
      secondary: Color(0xff8fe3c9),
      onSecondary: Color(0xff00382c),
      secondaryContainer: Color(0xff66b9a1),
      onSecondaryContainer: Color(0xff00241c),
      tertiary: Color(0xffffffff),
      onTertiary: Color(0xff2f3131),
      tertiaryContainer: Color(0xffd4d4d4),
      onTertiaryContainer: Color(0xff3e4040),
      error: Color(0xffffb4ab),
      onError: Color(0xff690005),
      errorContainer: Color(0xff93000a),
      onErrorContainer: Color(0xffffdad6),
      surface: Color(0xff141313),
      onSurface: Color(0xffe5e2e1),
      onSurfaceVariant: Color(0xffc1c8c5),
      outline: Color(0xff8b928f),
      outlineVariant: Color(0xff424846),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe5e2e1),
      inversePrimary: Color(0xff5b54a5),
      primaryFixed: Color(0xffe4dfff),
      onPrimaryFixed: Color(0xff16065f),
      primaryFixedDim: Color(0xffc6c0ff),
      onPrimaryFixedVariant: Color(0xff433c8b),
      secondaryFixed: Color(0xff9ff3d9),
      onSecondaryFixed: Color(0xff002019),
      secondaryFixedDim: Color(0xff83d6bd),
      onSecondaryFixedVariant: Color(0xff005141),
      tertiaryFixed: Color(0xffe2e2e2),
      onTertiaryFixed: Color(0xff1a1c1c),
      tertiaryFixedDim: Color(0xffc6c6c7),
      onTertiaryFixedVariant: Color(0xff454747),
      surfaceDim: Color(0xff141313),
      surfaceBright: Color(0xff3a3939),
      surfaceContainerLowest: Color(0xff0e0e0e),
      surfaceContainerLow: Color(0xff1c1b1b),
      surfaceContainer: Color(0xff201f1f),
      surfaceContainerHigh: Color(0xff2a2a2a),
      surfaceContainerHighest: Color(0xff353434),
    );
  }

  ThemeData dark() {
    return theme(darkScheme());
  }

  static ColorScheme darkMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffcac4ff),
      surfaceTint: Color(0xffc6c0ff),
      onPrimary: Color(0xff100058),
      primaryContainer: Color(0xff8e87dc),
      onPrimaryContainer: Color(0xff000000),
      secondary: Color(0xff8fe3c9),
      onSecondary: Color(0xff00231b),
      secondaryContainer: Color(0xff66b9a1),
      onSecondaryContainer: Color(0xff000000),
      tertiary: Color(0xffffffff),
      onTertiary: Color(0xff2f3131),
      tertiaryContainer: Color(0xffd4d4d4),
      onTertiaryContainer: Color(0xff1e2020),
      error: Color(0xffffbab1),
      onError: Color(0xff370001),
      errorContainer: Color(0xffff5449),
      onErrorContainer: Color(0xff000000),
      surface: Color(0xff141313),
      onSurface: Color(0xfffefaf9),
      onSurfaceVariant: Color(0xffc6ccc9),
      outline: Color(0xff9ea4a1),
      outlineVariant: Color(0xff7e8582),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe5e2e1),
      inversePrimary: Color(0xff443d8c),
      primaryFixed: Color(0xffe4dfff),
      onPrimaryFixed: Color(0xff0c0049),
      primaryFixedDim: Color(0xffc6c0ff),
      onPrimaryFixedVariant: Color(0xff322a79),
      secondaryFixed: Color(0xff9ff3d9),
      onSecondaryFixed: Color(0xff00150f),
      secondaryFixedDim: Color(0xff83d6bd),
      onSecondaryFixedVariant: Color(0xff003e32),
      tertiaryFixed: Color(0xffe2e2e2),
      onTertiaryFixed: Color(0xff0f1112),
      tertiaryFixedDim: Color(0xffc6c6c7),
      onTertiaryFixedVariant: Color(0xff353637),
      surfaceDim: Color(0xff141313),
      surfaceBright: Color(0xff3a3939),
      surfaceContainerLowest: Color(0xff0e0e0e),
      surfaceContainerLow: Color(0xff1c1b1b),
      surfaceContainer: Color(0xff201f1f),
      surfaceContainerHigh: Color(0xff2a2a2a),
      surfaceContainerHighest: Color(0xff353434),
    );
  }

  ThemeData darkMediumContrast() {
    return theme(darkMediumContrastScheme());
  }

  static ColorScheme darkHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xfffef9ff),
      surfaceTint: Color(0xffc6c0ff),
      onPrimary: Color(0xff000000),
      primaryContainer: Color(0xffcac4ff),
      onPrimaryContainer: Color(0xff000000),
      secondary: Color(0xffecfff7),
      onSecondary: Color(0xff000000),
      secondaryContainer: Color(0xff87dac1),
      onSecondaryContainer: Color(0xff000000),
      tertiary: Color(0xffffffff),
      onTertiary: Color(0xff000000),
      tertiaryContainer: Color(0xffd4d4d4),
      onTertiaryContainer: Color(0xff000000),
      error: Color(0xfffff9f9),
      onError: Color(0xff000000),
      errorContainer: Color(0xffffbab1),
      onErrorContainer: Color(0xff000000),
      surface: Color(0xff141313),
      onSurface: Color(0xffffffff),
      onSurfaceVariant: Color(0xfff6fcf9),
      outline: Color(0xffc6ccc9),
      outlineVariant: Color(0xffc6ccc9),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe5e2e1),
      inversePrimary: Color(0xff251c6d),
      primaryFixed: Color(0xffe8e4ff),
      onPrimaryFixed: Color(0xff000000),
      primaryFixedDim: Color(0xffcac4ff),
      onPrimaryFixedVariant: Color(0xff100058),
      secondaryFixed: Color(0xffa3f7dd),
      onSecondaryFixed: Color(0xff000000),
      secondaryFixedDim: Color(0xff87dac1),
      onSecondaryFixedVariant: Color(0xff001b14),
      tertiaryFixed: Color(0xffe7e7e7),
      onTertiaryFixed: Color(0xff000000),
      tertiaryFixedDim: Color(0xffcacbcb),
      onTertiaryFixedVariant: Color(0xff151717),
      surfaceDim: Color(0xff141313),
      surfaceBright: Color(0xff3a3939),
      surfaceContainerLowest: Color(0xff0e0e0e),
      surfaceContainerLow: Color(0xff1c1b1b),
      surfaceContainer: Color(0xff201f1f),
      surfaceContainerHigh: Color(0xff2a2a2a),
      surfaceContainerHighest: Color(0xff353434),
    );
  }

  ThemeData darkHighContrast() {
    return theme(darkHighContrastScheme());
  }


  ThemeData theme(ColorScheme colorScheme) => ThemeData(
    useMaterial3: true,
    brightness: colorScheme.brightness,
    colorScheme: colorScheme,
    textTheme: textTheme.apply(
      bodyColor: colorScheme.onSurface,
      displayColor: colorScheme.onSurface,
    ),
    scaffoldBackgroundColor: colorScheme.background,
    canvasColor: colorScheme.surface,
  );



  List<ExtendedColor> get extendedColors => [
  ];
}

class ExtendedColor {
  final Color seed, value;
  final ColorFamily light;
  final ColorFamily lightHighContrast;
  final ColorFamily lightMediumContrast;
  final ColorFamily dark;
  final ColorFamily darkHighContrast;
  final ColorFamily darkMediumContrast;

  const ExtendedColor({
    required this.seed,
    required this.value,
    required this.light,
    required this.lightHighContrast,
    required this.lightMediumContrast,
    required this.dark,
    required this.darkHighContrast,
    required this.darkMediumContrast,
  });
}

class ColorFamily {
  const ColorFamily({
    required this.color,
    required this.onColor,
    required this.colorContainer,
    required this.onColorContainer,
  });

  final Color color;
  final Color onColor;
  final Color colorContainer;
  final Color onColorContainer;
}
