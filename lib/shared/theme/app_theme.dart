import 'package:flutter/material.dart';

ThemeData getAppTheme() {
  final colorScheme = ColorScheme.fromSeed(
    seedColor: const Color(0xFF4A90E2),
    primary: const Color(0xFF1E3A8A),
    secondary: const Color(0xFF3B82F6),
    surface: Colors.white,
    onSurface: const Color(0xFF2563EB),
    onSurfaceVariant: const Color(0xFF9CA3AF),
    outline: const Color(0xFFE5E7EB),
    tertiary: const Color(0xFF6B7280),
    error: const Color(0xFFE11D48),
    primaryContainer: const Color(0xFFF3F4F6),
    secondaryContainer: const Color(0xFFEFF6FF),
    primaryFixed: const Color(0xFF1E40AF),
    primaryFixedDim: const Color(0xFF1D4ED8),
    tertiaryContainer: const Color(0xFF22C55E),
    onSecondaryContainer: const Color(0xFFF59E0B),
  );

  return ThemeData(
    colorScheme: colorScheme,
    dividerColor: const Color(0xFFE5E7EB),
    fontFamily: null,
    textTheme: _getTextTheme(colorScheme),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: colorScheme.secondary),
      ),
      filled: true,
      fillColor: colorScheme.secondaryContainer,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: colorScheme.secondary,
        foregroundColor: Colors.white,
        textStyle: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 16,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: colorScheme.primary,
      foregroundColor: Colors.white,
      elevation: 0,
      titleTextStyle: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
    ),
  );
}

TextTheme _getTextTheme(ColorScheme colorScheme) {
  return TextTheme(
    bodyLarge: TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: 16,
      height: 1.5,
      letterSpacing: 0.2,
      color: colorScheme.secondary,
    ),
    bodyMedium: TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 15,
      height: 1.5,
      color: colorScheme.secondary,
    ),
    titleLarge: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 28,
      color: colorScheme.primary,
    ),
    titleMedium: TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: 18,
      color: colorScheme.tertiary,
    ),
    titleSmall: TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 16,
      color: colorScheme.primary,
    ),
    labelSmall: TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: 13,
      color: colorScheme.onSurface,
    ),
    labelMedium: TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 14,
      color: colorScheme.tertiary,
    ),
    labelLarge: TextStyle(
      fontWeight: FontWeight.w700,
      fontSize: 16,
      color: Colors.white,
    ),
    bodySmall: TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 13,
      color: colorScheme.onSurface,
    ),
    displaySmall: TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: 12,
      color: colorScheme.primary,
    ),
    headlineMedium: TextStyle(
      fontWeight: FontWeight.w700,
      fontSize: 22,
      color: colorScheme.onSurfaceVariant,
    ),
    displayLarge: TextStyle(
      fontWeight: FontWeight.w700,
      fontSize: 18,
      color: colorScheme.primary,
    ),
  );
}
