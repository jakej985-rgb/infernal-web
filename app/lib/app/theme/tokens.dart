/// Theme color and style tokens for the Infernal Ink & Steel Suite
///
/// Based on the legacy C# app's dark "infernal" theme with dramatic styling.
library;

import 'package:flutter/material.dart';

/// Core color palette representing a premium dark-industrial tattoo and piercing studio
abstract final class InfernalColors {
  // Base colors
  static const Color background = Color(0xFF0F0F11); // Dark charcoal background
  static const Color surface = Color(0xFF1B1B1E); // Sleek matte black surface
  static const Color surfaceVariant = Color(0xFF26262B);
  static const Color surfaceElevated = Color(0xFF303036);

  // Text colors
  static const Color textPrimary = Color(0xFFF1F1F3);
  static const Color textSecondary = Color(0xFFADB5BD);
  static const Color textMuted = Color(0xFF6C757D);
  static const Color textAccent = Color(0xFFFF922B); // Tangerine/ember accent

  // Accent colors (Tattoo & Piercing studio theme)
  static const Color blood = Color(
    0xFFC92A2A,
  ); // Crimson Red - Ink primary accent
  static const Color arcane = Color(
    0xFF8E9AAF,
  ); // Cool Metallic Steel Grey/Silver
  static const Color gold = Color(0xFFC5A059); // Warm Brass/Bronze
  static const Color voidColor = Color(0xFF343A40); // Dark Slate Charcoal
  static const Color ember = Color(0xFFD9480F); // Warm Copper / Rust Orange

  // Status colors
  static const Color success = Color(0xFF2B8A3E); // Deep forest green
  static const Color warning = Color(0xFFE67E22);
  static const Color error = Color(0xFFC92A2A);
  static const Color info = Color(0xFF1971C2);

  // Border/divider
  static const Color border = Color(0xFF2C2E33);
  static const Color divider = Color(0xFF212529);

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
