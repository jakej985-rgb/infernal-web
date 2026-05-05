/// Theme color and style tokens for the Infernal Ink & Steel Suite
///
/// Based on the legacy C# app's dark "infernal" theme with dramatic styling.
library;

import 'package:flutter/material.dart';

/// Core color palette matching the legacy "infernal" dark theme
abstract final class InfernalColors {
  // Base colors
  static const Color background = Color(0xFF0D0D0D);
  static const Color surface = Color(0xFF1A1A1A);
  static const Color surfaceVariant = Color(0xFF252525);
  static const Color surfaceElevated = Color(0xFF2D2D2D);

  // Text colors
  static const Color textPrimary = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0xFFB0B0B0);
  static const Color textMuted = Color(0xFF808080);
  static const Color textAccent = Color(0xFFFF6B35);

  // Accent colors (rune colors from legacy)
  static const Color blood = Color(0xFFDC143C); // Blood red - primary accent
  static const Color arcane = Color(0xFF9B59B6); // Arcane purple
  static const Color gold = Color(0xFFFFD700); // Gold/amber
  static const Color voidColor = Color(0xFF4A4A6A); // Void/dark blue-grey
  static const Color ember = Color(0xFFFF6B35); // Ember orange

  // Status colors
  static const Color success = Color(0xFF2ECC71);
  static const Color warning = Color(0xFFF39C12);
  static const Color error = Color(0xFFE74C3C);
  static const Color info = Color(0xFF3498DB);

  // Border/divider
  static const Color border = Color(0xFF3D3D3D);
  static const Color divider = Color(0xFF2D2D2D);

  // Appointment status colors
  static const Color scheduled = arcane;
  static const Color completed = success;
  static const Color cancelled = error;
  static const Color noShow = warning;
  static const Color blockOff = voidColor;

  // Glow/Neon Effects
  static Color bloodGlow = blood.withValues(alpha: 0.3);
  static Color arcaneGlow = arcane.withValues(alpha: 0.3);
  static Color goldGlow = gold.withValues(alpha: 0.3);
}

/// Spacing constants for consistent layout
abstract final class InfernalSpacing {
  static const double xs = 4.0;
  static const double sm = 8.0;
  static const double md = 16.0;
  static const double lg = 24.0;
  static const double xl = 32.0;
  static const double xxl = 48.0;
}

/// Border radius constants
abstract final class InfernalRadius {
  static const double sm = 4.0;
  static const double md = 8.0;
  static const double lg = 12.0;
  static const double xl = 16.0;
  static const double pill = 9999.0;
}

/// Elevation/shadow levels
abstract final class InfernalElevation {
  static const double none = 0.0;
  static const double low = 2.0;
  static const double medium = 4.0;
  static const double high = 8.0;
}

/// Icon sizes
abstract final class InfernalIconSize {
  static const double sm = 16.0;
  static const double md = 24.0;
  static const double lg = 32.0;
  static const double xl = 48.0;
}
