import 'package:flutter/material.dart';

/// Modern, high-contrast palette aligned with Material 3
class AppColors {
  // Brand
  static const Color primary = Color(0xFF2563EB); // Blue 600
  static const Color primaryDark = Color(0xFF1D4ED8); // Blue 700
  static const Color secondary = Color(0xFF14B8A6); // Teal 500
  static const Color secondaryDark = Color(0xFF0D9488); // Teal 600

  // Surfaces
  static const Color surface = Color(0xFFFFFFFF);
  static const Color lightBackground = Color(0xFFF8FAFC); // Slate 50
  static const Color darkBackground = Color(0xFF0B0F1A); // Deep slate
  static const Color darkSurface = Color(0xFF111827); // Slate 900

  // Status
  static const Color error = Color(0xFFEF4444); // Red 500
  static const Color success = Color(0xFF22C55E); // Green 500
  static const Color warning = Color(0xFFF59E0B); // Amber 500
  static const Color info = Color(0xFF0284C7); // Cyan 700

  // On colors
  static const Color onPrimary = Color(0xFFFFFFFF);
  static const Color onSecondary = Color(0xFFFFFFFF);
  static const Color onBackground = Color(0xFF0F172A); // Slate 900
  static const Color onSurface = Color(0xFF0F172A);
  static const Color onError = Color(0xFFFFFFFF);

  // Neutral scale (Slate)
  static const Color grey50 = Color(0xFFF8FAFC);
  static const Color grey100 = Color(0xFFF1F5F9);
  static const Color grey200 = Color(0xFFE2E8F0);
  static const Color grey300 = Color(0xFFCBD5E1);
  static const Color grey400 = Color(0xFF94A3B8);
  static const Color grey500 = Color(0xFF64748B);
  static const Color grey600 = Color(0xFF475569);
  static const Color grey700 = Color(0xFF334155);
  static const Color grey800 = Color(0xFF1F2937);
  static const Color grey900 = Color(0xFF0F172A);

  // Light theme aliases
  static const Color backgroundLight = lightBackground;
  static const Color surfaceLight = surface;
  static const Color textLight = onSurface;

  // Dark theme aliases
  static const Color backgroundDark = darkBackground;
  static const Color surfaceDark = darkSurface;
  static const Color textDark = Colors.white;

  // Additional
  static const Color primaryLight = Color(0xFF93C5FD); // Blue 300
  static const Color errorLight = Color(0xFFFCA5A5); // Red 300
}
