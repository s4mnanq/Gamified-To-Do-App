import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static const Color neonGreen = Color(0xFF00FF41);
  static const Color darkGreen = Color(0xFF00B234);
  static const Color pureBlack = Color(0xFF000000);
  static const Color darkGray = Color(0xFF2D2D2D);
  static const Color mediumGray = Color(0xFF3D3D3D);
  static const Color textWhite = Color(0xFFFFFFFF);
  static const Color textGray = Color(0xFFB0B0B0);
  static const Color errorRed = Color(0xFFFF4444);

  static const double _inputRadius = 16;
  static const double _buttonRadius = 30;
  static const double _borderWidth = 2;
  static const double _borderWidthFocused = 2.5;
  static const double _borderWidthDefault = 1.5;

  static final ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.dark(
      primary: neonGreen,
      secondary: darkGreen,
      surface: darkGray,
      onSurface: textWhite,
      // background: pureBlack,
      error: errorRed,
    ),
    scaffoldBackgroundColor: pureBlack,

    appBarTheme: const AppBarTheme(
      backgroundColor: pureBlack,
      foregroundColor: textWhite,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: TextStyle(
        color: textWhite,
        fontSize: 22,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.5,
      ),
      iconTheme: IconThemeData(color: textWhite, size: 24),
    ),

    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: neonGreen,
      foregroundColor: pureBlack,
      elevation: 6,
      shape: CircleBorder(),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: neonGreen,
        foregroundColor: pureBlack,
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 18),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(_buttonRadius),
        ),
        textStyle: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.5,
        ),
      ),
    ),

    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: neonGreen,
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      ),
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: darkGray,

      border: _outlineBorder(color: mediumGray, width: _borderWidthDefault),
      enabledBorder: _outlineBorder(color: neonGreen, width: _borderWidth),
      focusedBorder: _outlineBorder(
        color: neonGreen,
        width: _borderWidthFocused,
      ),
      errorBorder: _outlineBorder(color: errorRed, width: _borderWidth),
      focusedErrorBorder: _outlineBorder(
        color: errorRed,
        width: _borderWidthFocused,
      ),

      hintStyle: const TextStyle(
        color: textGray,
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),

      labelStyle: const TextStyle(
        color: textGray,
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),

      errorStyle: const TextStyle(
        color: errorRed,
        fontSize: 13,
        fontWeight: FontWeight.w500,
      ),

      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),

      prefixIconColor: neonGreen,
      suffixIconColor: textGray,
    ),

    textTheme: const TextTheme(
      // Headings
      displayLarge: TextStyle(
        color: textWhite,
        fontSize: 32,
        fontWeight: FontWeight.bold,
      ),
      displayMedium: TextStyle(
        color: textWhite,
        fontSize: 28,
        fontWeight: FontWeight.bold,
      ),

      // Titles
      titleLarge: TextStyle(
        color: textWhite,
        fontSize: 22,
        fontWeight: FontWeight.w600,
      ),
      titleMedium: TextStyle(
        color: textWhite,
        fontSize: 18,
        fontWeight: FontWeight.w600,
      ),
      titleSmall: TextStyle(
        color: textWhite,
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),

      // Body text
      bodyLarge: TextStyle(
        color: textWhite,
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
      bodyMedium: TextStyle(
        color: textGray,
        fontSize: 14,
        fontWeight: FontWeight.w400,
      ),
      bodySmall: TextStyle(
        color: textGray,
        fontSize: 12,
        fontWeight: FontWeight.w400,
      ),

      // Labels
      labelLarge: TextStyle(
        color: textWhite,
        fontSize: 14,
        fontWeight: FontWeight.w600,
      ),
      labelMedium: TextStyle(
        color: textGray,
        fontSize: 12,
        fontWeight: FontWeight.w500,
      ),
      labelSmall: TextStyle(
        color: textGray,
        fontSize: 11,
        fontWeight: FontWeight.w500,
      ),
    ),

    iconTheme: const IconThemeData(color: neonGreen, size: 24),

    dividerTheme: DividerThemeData(color: mediumGray, thickness: 1, space: 1),

    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: pureBlack,
      selectedItemColor: neonGreen,
      unselectedItemColor: textGray,
      type: BottomNavigationBarType.fixed,
      elevation: 8,
    ),
  );

  static OutlineInputBorder _outlineBorder({
    required Color color,
    required double width,
  }) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(_inputRadius),
      borderSide: BorderSide(color: color, width: width),
    );
  }
}
