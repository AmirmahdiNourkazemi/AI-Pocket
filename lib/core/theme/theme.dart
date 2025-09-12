import "package:flutter/material.dart";

class AppTheme {
  static TextTheme textTheme = appTextTheme;

   static ColorScheme lightScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xFF7C4DFF), // بنفش مدرن
      surfaceTint: Color(0xFF7C4DFF),
      onPrimary: Colors.white,
      primaryContainer: Color(0xFFEDE7F6),
      onPrimaryContainer: Color(0xFF311B92),
      secondary: Color(0xFF00BCD4), // فیروزه‌ای
      onSecondary: Colors.white,
      secondaryContainer: Color(0xFFE0F7FA),
      onSecondaryContainer: Color(0xFF006064),
      tertiary: Color(0xFF4CAF50), // سبز موفقیت
      onTertiary: Colors.white,
      tertiaryContainer: Color(0xFFE8F5E9),
      onTertiaryContainer: Color(0xFF1B5E20),
      error: Color(0xFFF44336),
      onError: Colors.white,
      errorContainer: Color(0xFFFFCDD2),
      onErrorContainer: Color(0xFFB71C1C),
      surface: Color(0xFFFFFFFF),
      onSurface: Color(0xFF1E1E1E),
      onSurfaceVariant: Color(0xFF616161),
      outline: Color(0xFF9E9E9E),
      outlineVariant: Color(0xFFBDBDBD),
      shadow: Colors.black,
      scrim: Colors.black,
      inverseSurface: Color(0xFF303030),
      inversePrimary: Color(0xFFD1C4E9),
      primaryFixed: Color(0xFFD1C4E9),
      onPrimaryFixed: Color(0xFF311B92),
      primaryFixedDim: Color(0xFF9575CD),
      onPrimaryFixedVariant: Color(0xFF4527A0),
      secondaryFixed: Color(0xFFB2EBF2),
      onSecondaryFixed: Color(0xFF004D40),
      secondaryFixedDim: Color(0xFF4DD0E1),
      onSecondaryFixedVariant: Color(0xFF00796B),
      tertiaryFixed: Color(0xFFC8E6C9),
      onTertiaryFixed: Color(0xFF1B5E20),
      tertiaryFixedDim: Color(0xFF81C784),
      onTertiaryFixedVariant: Color(0xFF2E7D32),
      surfaceDim: Color(0xFFF5F5F5),
      surfaceBright: Color(0xFFFFFFFF),
      surfaceContainerLowest: Color(0xFFFFFFFF),
      surfaceContainerLow: Color(0xFFF9F9F9),
      surfaceContainer: Color(0xFFF2F2F2),
      surfaceContainerHigh: Color(0xFFEAEAEA),
      surfaceContainerHighest: Color(0xFFE0E0E0),
    );
  }

 static ColorScheme darkScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xFF7C4DFF),
      surfaceTint: Color(0xFF7C4DFF),
      onPrimary: Colors.white,
      primaryContainer: Color(0xFF311B92),
      onPrimaryContainer: Color(0xFFEDE7F6),
      secondary: Color(0xFF00BCD4),
      onSecondary: Colors.black,
      secondaryContainer: Color(0xFF004D40),
      onSecondaryContainer: Color(0xFFE0F7FA),
      tertiary: Color(0xFF4CAF50),
      onTertiary: Colors.black,
      tertiaryContainer: Color(0xFF1B5E20),
      onTertiaryContainer: Color(0xFFE8F5E9),
      error: Color(0xFFF44336),
      onError: Colors.black,
      errorContainer: Color(0xFFB71C1C),
      onErrorContainer: Color(0xFFFFCDD2),
      surface: Color(0xFF18181B),
      onSurface: Color(0xFFE0E0E0),
      onSurfaceVariant: Color(0xFFBDBDBD),
      outline: Color(0xFF9E9E9E),
      outlineVariant: Color(0xFF757575),
      shadow: Colors.black,
      scrim: Colors.black,
      inverseSurface: Color(0xFFE0E0E0),
      inversePrimary: Color(0xFFD1C4E9),
      primaryFixed: Color(0xFF4527A0),
      onPrimaryFixed: Color(0xFFEDE7F6),
      primaryFixedDim: Color(0xFF9575CD),
      onPrimaryFixedVariant: Color(0xFFD1C4E9),
      secondaryFixed: Color(0xFF00796B),
      onSecondaryFixed: Color(0xFFE0F7FA),
      secondaryFixedDim: Color(0xFF4DD0E1),
      onSecondaryFixedVariant: Color(0xFFB2EBF2),
      tertiaryFixed: Color(0xFF2E7D32),
      onTertiaryFixed: Color(0xFFE8F5E9),
      tertiaryFixedDim: Color(0xFF81C784),
      onTertiaryFixedVariant: Color(0xFFC8E6C9),
      surfaceDim: Color(0xFF121212),
      surfaceBright: Color(0xFF1F1F1F),
      surfaceContainerLowest: Color(0xFF0D0D0D),
      surfaceContainerLow: Color(0xFF18181B),
      surfaceContainer: Color(0xFF202020),
      surfaceContainerHigh: Color(0xFF2A2A2A),
      surfaceContainerHighest: Color(0xFF333333),
    );
  }

  static ThemeData light() {
    return theme(lightScheme());
  }

  static ThemeData dark() {
    return theme(darkScheme());
  }

  static ThemeData theme(ColorScheme colorScheme) => ThemeData(
        brightness: colorScheme.brightness,
        
        colorScheme: colorScheme,
        iconTheme: IconThemeData(
          color: colorScheme.inversePrimary,
        ),
        bottomSheetTheme: BottomSheetThemeData(
          backgroundColor: colorScheme.onPrimary,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(
          foregroundColor: WidgetStatePropertyAll<Color>(colorScheme.onPrimary),
          textStyle: WidgetStatePropertyAll<TextStyle>(textTheme.bodyMedium!),
          splashFactory: InkRipple.splashFactory,
          shadowColor:
              WidgetStatePropertyAll<Color>(colorScheme.inversePrimary),
          shape: WidgetStatePropertyAll<RoundedRectangleBorder>(
              RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Dimensions.cornerRadiusSmall),
          )),
          backgroundColor: WidgetStateProperty.all(colorScheme.primary),
        )),
        buttonTheme: ButtonThemeData(
          buttonColor: colorScheme.primary,
          textTheme: ButtonTextTheme.primary,
          colorScheme: colorScheme,
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: colorScheme.primary,
          foregroundColor: colorScheme.onPrimary,
        ),
        textTheme: textTheme.apply(
          fontSizeFactor: 1.0
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

final class Dimensions {
  // Padding
  static const spaceExtraSmall = 4.0;
  static const spaceSmall = 8.0;
  static const spaceMedium = 16.0;
  static const spaceLarge = 24.0;
  static const spaceExtraLarge = 32.0;
  // Padding
  static const paddingExtraSmall = 4.0;
  static const paddingSmall = 8.0;
  static const paddingMedium = 16.0;
  static const paddingLarge = 24.0;
  static const paddingExtraLarge = 32.0;

  // Margins
  static const marginExtraSmall = 4.0;
  static const marginSmall = 8.0;
  static const marginMedium = 16.0;
  static const marginLarge = 24.0;
  static const marginExtraLarge = 32.0;

  // Font sizes
  static const fontSizeSmall = 12.0;
  static const fontSizeNormal = 14.0;
  static const fontSizeMedium = 16.0;
  static const fontSizeLarge = 20.0;

  // Corner Radius
  static const cornerRadiusExtraSmall = 4.0;
  static const cornerRadiusSmall = 8.0;
  static const cornerRadiusMedium = 16.0;
  static const cornerRadiusLarge = 24.0;
  static const cornerRadiusExtraLarge = 32.0;

  // Other dimensions
  static const buttonHeight = 48.0;
  static const iconSize = 32.0;
  static const elevation = 4.0;
  static const profileImageSize = 160.0;
  static const cardImageHeight = 160.0;
  static const bannerImageHeight = 200.0;
  static const toolBarHeight = 56.0;
}

const TextTheme appTextTheme = TextTheme(
  displaySmall: TextStyle(
    fontFamily: 'IRANYekan',
    fontWeight: FontWeight.w300,
    fontSize: 12.0, // Replace with your small font size
  ),
  displayMedium: TextStyle(
    fontFamily: 'IRANYekan',
    fontWeight: FontWeight.w400,
    fontSize: 14.0, // Replace with your normal font size
  ),  
  displayLarge: TextStyle(
    fontFamily: 'IRANYekan',
    fontWeight: FontWeight.w600,
    fontSize: 20.0, // Replace with your large font size
  ),
  headlineSmall: TextStyle(
    fontFamily: 'IRANYekan',
    fontWeight: FontWeight.w600,
    fontSize: 12.0, // Replace with your small font size
  ),
  headlineMedium: TextStyle(
    fontFamily: 'IRANYekan',
    fontWeight: FontWeight.w700,
    fontSize: 16.0, // Replace with your medium font size
  ),
  headlineLarge: TextStyle(
    fontFamily: 'IRANYekan',
    fontWeight: FontWeight.w800,
    fontSize: 20.0, // Replace with your large font size
  ),
  titleSmall: TextStyle(
    fontFamily: 'IRANYekan',
    fontWeight: FontWeight.w600,
    fontSize: 12.0,
  ),
  titleMedium: TextStyle(
    fontFamily: 'IRANYekan',
    fontWeight: FontWeight.w600,
    fontSize: 16.0,
  ),
  titleLarge: TextStyle(
    fontFamily: 'IRANYekan',
    fontWeight: FontWeight.w700,
    fontSize: 20.0,
  ),
  bodySmall: TextStyle(
    fontFamily: 'IRANYekan',
    fontWeight: FontWeight.w400,
    fontSize: 12.0,
  ),
  bodyMedium: TextStyle(
    fontFamily: 'IRANYekan',
    fontWeight: FontWeight.w400,
    fontSize: Dimensions.fontSizeMedium,
  ),
  bodyLarge: TextStyle(
    fontFamily: 'IRANYekan',
    fontWeight: FontWeight.w500,
    fontSize: 20.0,
  ),
  labelSmall: TextStyle(
    fontFamily: 'IRANYekan',
    fontWeight: FontWeight.w100,
    fontSize: 12.0,
  ),
  labelMedium: TextStyle(
    fontFamily: 'IRANYekan',
    fontWeight: FontWeight.w300,
    fontSize: 16.0,
    letterSpacing: 0.5,
  ),
  labelLarge: TextStyle(
    fontFamily: 'IRANYekan',
    fontWeight: FontWeight.w400,
    fontSize: 20.0,
  ),
);
