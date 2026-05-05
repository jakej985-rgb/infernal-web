/// Infernal theme data for Flutter Material 3
library;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'tokens.dart';

/// Creates the dark Infernal theme matching the legacy C# app
ThemeData createInfernalTheme() {
  final textTheme = _createTextTheme();

  return ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,

    // Color scheme
    colorScheme: const ColorScheme.dark(
      primary: InfernalColors.blood,
      secondary: InfernalColors.arcane,
      tertiary: InfernalColors.gold,
      surface: InfernalColors.surface,
      error: InfernalColors.error,
      onPrimary: InfernalColors.textPrimary,
      onSecondary: InfernalColors.textPrimary,
      onSurface: InfernalColors.textPrimary,
      onError: InfernalColors.textPrimary,
      outline: InfernalColors.border,
      outlineVariant: InfernalColors.divider,
    ),

    // Scaffold
    scaffoldBackgroundColor: InfernalColors.background,

    // AppBar
    appBarTheme: AppBarTheme(
      backgroundColor: InfernalColors.surface,
      foregroundColor: InfernalColors.textPrimary,
      elevation: 0,
      centerTitle: false,
      titleTextStyle: textTheme.titleLarge?.copyWith(
        color: InfernalColors.textPrimary,
        letterSpacing: 2.0,
      ),
    ),

    // Cards
    cardTheme: CardThemeData(
      color: InfernalColors.surface,
      elevation: InfernalElevation.low,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(InfernalRadius.md),
        side: const BorderSide(color: InfernalColors.border, width: 1),
      ),
    ),

    // Elevated buttons
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: InfernalColors.blood,
        foregroundColor: InfernalColors.textPrimary,
        padding: const EdgeInsets.symmetric(
          horizontal: InfernalSpacing.lg,
          vertical: InfernalSpacing.md,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(InfernalRadius.md),
        ),
      ),
    ),

    // Outlined buttons
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: InfernalColors.blood,
        side: const BorderSide(color: InfernalColors.blood),
        padding: const EdgeInsets.symmetric(
          horizontal: InfernalSpacing.lg,
          vertical: InfernalSpacing.md,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(InfernalRadius.md),
        ),
      ),
    ),

    // Text buttons
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(foregroundColor: InfernalColors.ember),
    ),

    // Input decoration
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: InfernalColors.surfaceVariant,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(InfernalRadius.md),
        borderSide: const BorderSide(color: InfernalColors.border),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(InfernalRadius.md),
        borderSide: const BorderSide(color: InfernalColors.border),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(InfernalRadius.md),
        borderSide: const BorderSide(color: InfernalColors.blood, width: 2),
      ),
      labelStyle: const TextStyle(color: InfernalColors.textSecondary),
      hintStyle: const TextStyle(color: InfernalColors.textMuted),
    ),

    // Divider
    dividerTheme: const DividerThemeData(
      color: InfernalColors.divider,
      thickness: 1,
    ),

    // Icon
    iconTheme: const IconThemeData(
      color: InfernalColors.textSecondary,
      size: InfernalIconSize.md,
    ),

    // Floating action button
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: InfernalColors.blood,
      foregroundColor: InfernalColors.textPrimary,
    ),

    // Bottom navigation
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: InfernalColors.surface,
      selectedItemColor: InfernalColors.blood,
      unselectedItemColor: InfernalColors.textMuted,
    ),

    // Navigation rail
    navigationRailTheme: const NavigationRailThemeData(
      backgroundColor: InfernalColors.surface,
      selectedIconTheme: IconThemeData(color: InfernalColors.blood),
      unselectedIconTheme: IconThemeData(color: InfernalColors.textMuted),
      selectedLabelTextStyle: TextStyle(color: InfernalColors.blood),
      unselectedLabelTextStyle: TextStyle(color: InfernalColors.textMuted),
    ),

    // Chip
    chipTheme: ChipThemeData(
      backgroundColor: InfernalColors.surfaceVariant,
      selectedColor: InfernalColors.blood.withValues(alpha: 0.3),
      labelStyle: const TextStyle(color: InfernalColors.textPrimary),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(InfernalRadius.pill),
      ),
    ),

    // Dialog
    dialogTheme: DialogThemeData(
      backgroundColor: InfernalColors.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(InfernalRadius.lg),
      ),
    ),

    // Snackbar
    snackBarTheme: SnackBarThemeData(
      backgroundColor: InfernalColors.surfaceElevated,
      contentTextStyle: const TextStyle(color: InfernalColors.textPrimary),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(InfernalRadius.md),
      ),
    ),

    // Text theme
    textTheme: textTheme,
  );
}

TextTheme _createTextTheme() {
  // Using Inter as a modern, clean font
  final baseTextTheme = GoogleFonts.interTextTheme();
  
  // Using Cinzel for headlines for an atmospheric 'Infernal' feel
  final headlineFont = GoogleFonts.cinzel();

  return baseTextTheme.copyWith(
    displayLarge: headlineFont.copyWith(
      color: InfernalColors.textPrimary,
      letterSpacing: 2.0,
      fontWeight: FontWeight.bold,
    ),
    displayMedium: headlineFont.copyWith(
      color: InfernalColors.textPrimary,
      letterSpacing: 1.5,
      fontWeight: FontWeight.bold,
    ),
    displaySmall: headlineFont.copyWith(
      color: InfernalColors.textPrimary,
      letterSpacing: 1.0,
      fontWeight: FontWeight.bold,
    ),
    headlineLarge: headlineFont.copyWith(
      color: InfernalColors.textPrimary,
      letterSpacing: 1.5,
      fontWeight: FontWeight.bold,
    ),
    headlineMedium: headlineFont.copyWith(
      color: InfernalColors.textPrimary,
      letterSpacing: 1.0,
      fontWeight: FontWeight.bold,
    ),
    headlineSmall: headlineFont.copyWith(
      color: InfernalColors.textPrimary,
      fontWeight: FontWeight.bold,
    ),
    titleLarge: headlineFont.copyWith(
      color: InfernalColors.textPrimary,
      fontWeight: FontWeight.bold,
      letterSpacing: 1.0,
    ),
    titleMedium: baseTextTheme.titleMedium?.copyWith(
      color: InfernalColors.textPrimary,
    ),
    titleSmall: baseTextTheme.titleSmall?.copyWith(
      color: InfernalColors.textSecondary,
    ),
// ... same rest of textTheme ...
    bodyLarge: baseTextTheme.bodyLarge?.copyWith(
      color: InfernalColors.textPrimary,
    ),
    bodyMedium: baseTextTheme.bodyMedium?.copyWith(
      color: InfernalColors.textPrimary,
    ),
    bodySmall: baseTextTheme.bodySmall?.copyWith(
      color: InfernalColors.textSecondary,
    ),
    labelLarge: baseTextTheme.labelLarge?.copyWith(
      color: InfernalColors.textPrimary,
      fontWeight: FontWeight.w500,
    ),
    labelMedium: baseTextTheme.labelMedium?.copyWith(
      color: InfernalColors.textSecondary,
    ),
    labelSmall: baseTextTheme.labelSmall?.copyWith(
      color: InfernalColors.textMuted,
      letterSpacing: 1.0,
    ),
  );
}
