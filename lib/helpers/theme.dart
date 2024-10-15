import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";

TextTheme createTextTheme(
    BuildContext context, String bodyFontString, String displayFontString) {
  TextTheme baseTextTheme = Theme.of(context).textTheme;
  TextTheme bodyTextTheme =
      GoogleFonts.getTextTheme(bodyFontString, baseTextTheme);
  TextTheme displayTextTheme =
      GoogleFonts.getTextTheme(displayFontString, baseTextTheme);
  TextTheme textTheme = displayTextTheme.copyWith(
    bodyLarge: bodyTextTheme.bodyLarge,
    bodyMedium: bodyTextTheme.bodyMedium,
    bodySmall: bodyTextTheme.bodySmall,
    labelLarge: bodyTextTheme.labelLarge,
    labelMedium: bodyTextTheme.labelMedium,
    labelSmall: bodyTextTheme.labelSmall,
  );
  return textTheme;
}

class MaterialTheme {
  final TextTheme textTheme;

  const MaterialTheme(this.textTheme);

  static ColorScheme lightScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff006a65),
      surfaceTint: Color(0xff006a65),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff9df2ea),
      onPrimaryContainer: Color(0xff00201e),
      secondary: Color(0xff4a6361),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xffcce8e5),
      onSecondaryContainer: Color(0xff051f1e),
      tertiary: Color(0xff006a62),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff9df2e7),
      onTertiaryContainer: Color(0xff00201d),
      error: Color(0xff904b3b),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffffdad2),
      onErrorContainer: Color(0xff3a0a02),
      surface: Color(0xfff4fbf9),
      onSurface: Color(0xff161d1c),
      onSurfaceVariant: Color(0xff3f4947),
      outline: Color(0xff6f7978),
      outlineVariant: Color(0xffbec9c7),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2b3231),
      inversePrimary: Color(0xff81d5ce),
      primaryFixed: Color(0xff9df2ea),
      onPrimaryFixed: Color(0xff00201e),
      primaryFixedDim: Color(0xff81d5ce),
      onPrimaryFixedVariant: Color(0xff00504c),
      secondaryFixed: Color(0xffcce8e5),
      onSecondaryFixed: Color(0xff051f1e),
      secondaryFixedDim: Color(0xffb0ccc9),
      onSecondaryFixedVariant: Color(0xff324b49),
      tertiaryFixed: Color(0xff9df2e7),
      onTertiaryFixed: Color(0xff00201d),
      tertiaryFixedDim: Color(0xff81d5cb),
      onTertiaryFixedVariant: Color(0xff00504a),
      surfaceDim: Color(0xffd5dbda),
      surfaceBright: Color(0xfff4fbf9),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xffeff5f3),
      surfaceContainer: Color(0xffe9efed),
      surfaceContainerHigh: Color(0xffe3e9e8),
      surfaceContainerHighest: Color(0xffdde4e2),
    );
  }

  ThemeData light() {
    return theme(lightScheme());
  }

  static ColorScheme lightMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff004b48),
      surfaceTint: Color(0xff006a65),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff25817c),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff2e4745),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff607a77),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff004c46),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff278179),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff6e3123),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffaa6050),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfff4fbf9),
      onSurface: Color(0xff161d1c),
      onSurfaceVariant: Color(0xff3b4544),
      outline: Color(0xff576160),
      outlineVariant: Color(0xff737d7b),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2b3231),
      inversePrimary: Color(0xff81d5ce),
      primaryFixed: Color(0xff25817c),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff006762),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff607a77),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff47615e),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff278179),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff006860),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffd5dbda),
      surfaceBright: Color(0xfff4fbf9),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xffeff5f3),
      surfaceContainer: Color(0xffe9efed),
      surfaceContainerHigh: Color(0xffe3e9e8),
      surfaceContainerHighest: Color(0xffdde4e2),
    );
  }

  ThemeData lightMediumContrast() {
    return theme(lightMediumContrastScheme());
  }

  static ColorScheme lightHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff002725),
      surfaceTint: Color(0xff006a65),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff004b48),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff0c2624),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff2e4745),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff002724),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff004c46),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff431106),
      onError: Color(0xffffffff),
      errorContainer: Color(0xff6e3123),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfff4fbf9),
      onSurface: Color(0xff000000),
      onSurfaceVariant: Color(0xff1c2625),
      outline: Color(0xff3b4544),
      outlineVariant: Color(0xff3b4544),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff2b3231),
      inversePrimary: Color(0xffa6fbf4),
      primaryFixed: Color(0xff004b48),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff003330),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff2e4745),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff18312f),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff004c46),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff00332f),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffd5dbda),
      surfaceBright: Color(0xfff4fbf9),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xffeff5f3),
      surfaceContainer: Color(0xffe9efed),
      surfaceContainerHigh: Color(0xffe3e9e8),
      surfaceContainerHighest: Color(0xffdde4e2),
    );
  }

  ThemeData lightHighContrast() {
    return theme(lightHighContrastScheme());
  }

  static ColorScheme darkScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xff81d5ce),
      surfaceTint: Color(0xff81d5ce),
      onPrimary: Color(0xff003734),
      primaryContainer: Color(0xff00504c),
      onPrimaryContainer: Color(0xff9df2ea),
      secondary: Color(0xffb0ccc9),
      onSecondary: Color(0xff1c3533),
      secondaryContainer: Color(0xff324b49),
      onSecondaryContainer: Color(0xffcce8e5),
      tertiary: Color(0xff81d5cb),
      onTertiary: Color(0xff003733),
      tertiaryContainer: Color(0xff00504a),
      onTertiaryContainer: Color(0xff9df2e7),
      error: Color(0xffffb4a3),
      onError: Color(0xff561f12),
      errorContainer: Color(0xff733426),
      onErrorContainer: Color(0xffffdad2),
      surface: Color(0xff0e1514),
      onSurface: Color(0xffdde4e2),
      onSurfaceVariant: Color(0xffbec9c7),
      outline: Color(0xff889391),
      outlineVariant: Color(0xff3f4947),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffdde4e2),
      inversePrimary: Color(0xff006a65),
      primaryFixed: Color(0xff9df2ea),
      onPrimaryFixed: Color(0xff00201e),
      primaryFixedDim: Color(0xff81d5ce),
      onPrimaryFixedVariant: Color(0xff00504c),
      secondaryFixed: Color(0xffcce8e5),
      onSecondaryFixed: Color(0xff051f1e),
      secondaryFixedDim: Color(0xffb0ccc9),
      onSecondaryFixedVariant: Color(0xff324b49),
      tertiaryFixed: Color(0xff9df2e7),
      onTertiaryFixed: Color(0xff00201d),
      tertiaryFixedDim: Color(0xff81d5cb),
      onTertiaryFixedVariant: Color(0xff00504a),
      surfaceDim: Color(0xff0e1514),
      surfaceBright: Color(0xff343a3a),
      surfaceContainerLowest: Color(0xff090f0f),
      surfaceContainerLow: Color(0xff161d1c),
      surfaceContainer: Color(0xff1a2120),
      surfaceContainerHigh: Color(0xff252b2a),
      surfaceContainerHighest: Color(0xff2f3635),
    );
  }

  ThemeData dark() {
    return theme(darkScheme());
  }

  static ColorScheme darkMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xff85d9d2),
      surfaceTint: Color(0xff81d5ce),
      onPrimary: Color(0xff001a18),
      primaryContainer: Color(0xff489e98),
      onPrimaryContainer: Color(0xff000000),
      secondary: Color(0xffb5d0cd),
      onSecondary: Color(0xff011a18),
      secondaryContainer: Color(0xff7b9693),
      onSecondaryContainer: Color(0xff000000),
      tertiary: Color(0xff86dacf),
      onTertiary: Color(0xff001a18),
      tertiaryContainer: Color(0xff499e95),
      onTertiaryContainer: Color(0xff000000),
      error: Color(0xffffbaab),
      onError: Color(0xff330501),
      errorContainer: Color(0xffcb7c69),
      onErrorContainer: Color(0xff000000),
      surface: Color(0xff0e1514),
      onSurface: Color(0xfff6fcfa),
      onSurfaceVariant: Color(0xffc2cdcb),
      outline: Color(0xff9ba5a3),
      outlineVariant: Color(0xff7b8584),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffdde4e2),
      inversePrimary: Color(0xff00514d),
      primaryFixed: Color(0xff9df2ea),
      onPrimaryFixed: Color(0xff001413),
      primaryFixedDim: Color(0xff81d5ce),
      onPrimaryFixedVariant: Color(0xff003d3a),
      secondaryFixed: Color(0xffcce8e5),
      onSecondaryFixed: Color(0xff001413),
      secondaryFixedDim: Color(0xffb0ccc9),
      onSecondaryFixedVariant: Color(0xff213a38),
      tertiaryFixed: Color(0xff9df2e7),
      onTertiaryFixed: Color(0xff001512),
      tertiaryFixedDim: Color(0xff81d5cb),
      onTertiaryFixedVariant: Color(0xff003e39),
      surfaceDim: Color(0xff0e1514),
      surfaceBright: Color(0xff343a3a),
      surfaceContainerLowest: Color(0xff090f0f),
      surfaceContainerLow: Color(0xff161d1c),
      surfaceContainer: Color(0xff1a2120),
      surfaceContainerHigh: Color(0xff252b2a),
      surfaceContainerHighest: Color(0xff2f3635),
    );
  }

  ThemeData darkMediumContrast() {
    return theme(darkMediumContrastScheme());
  }

  static ColorScheme darkHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffeafffc),
      surfaceTint: Color(0xff81d5ce),
      onPrimary: Color(0xff000000),
      primaryContainer: Color(0xff85d9d2),
      onPrimaryContainer: Color(0xff000000),
      secondary: Color(0xffeafffc),
      onSecondary: Color(0xff000000),
      secondaryContainer: Color(0xffb5d0cd),
      onSecondaryContainer: Color(0xff000000),
      tertiary: Color(0xffebfffb),
      onTertiary: Color(0xff000000),
      tertiaryContainer: Color(0xff86dacf),
      onTertiaryContainer: Color(0xff000000),
      error: Color(0xfffff9f8),
      onError: Color(0xff000000),
      errorContainer: Color(0xffffbaab),
      onErrorContainer: Color(0xff000000),
      surface: Color(0xff0e1514),
      onSurface: Color(0xffffffff),
      onSurfaceVariant: Color(0xfff3fdfb),
      outline: Color(0xffc2cdcb),
      outlineVariant: Color(0xffc2cdcb),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffdde4e2),
      inversePrimary: Color(0xff00302d),
      primaryFixed: Color(0xffa1f6ef),
      onPrimaryFixed: Color(0xff000000),
      primaryFixedDim: Color(0xff85d9d2),
      onPrimaryFixedVariant: Color(0xff001a18),
      secondaryFixed: Color(0xffd0ede9),
      onSecondaryFixed: Color(0xff000000),
      secondaryFixedDim: Color(0xffb5d0cd),
      onSecondaryFixedVariant: Color(0xff011a18),
      tertiaryFixed: Color(0xffa2f6eb),
      onTertiaryFixed: Color(0xff000000),
      tertiaryFixedDim: Color(0xff86dacf),
      onTertiaryFixedVariant: Color(0xff001a18),
      surfaceDim: Color(0xff0e1514),
      surfaceBright: Color(0xff343a3a),
      surfaceContainerLowest: Color(0xff090f0f),
      surfaceContainerLow: Color(0xff161d1c),
      surfaceContainer: Color(0xff1a2120),
      surfaceContainerHigh: Color(0xff252b2a),
      surfaceContainerHighest: Color(0xff2f3635),
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
        scaffoldBackgroundColor: colorScheme.surface,
        canvasColor: colorScheme.surface,
      );

  List<ExtendedColor> get extendedColors => [];
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
