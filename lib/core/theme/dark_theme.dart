import 'package:flutter/material.dart';
import 'package:qr_meetapp/core/constants/app_colors.dart';
import 'package:qr_meetapp/core/constants/app_styles.dart';

/// Dark theme configuration for the app
final darkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: AppColors.primaryDark,
  colorScheme: const ColorScheme.dark(
    primary: AppColors.primaryDark,
    secondary: AppColors.secondaryDark,
    surface: AppColors.darkSurface,
    error: AppColors.error,
  ),
  scaffoldBackgroundColor: AppColors.darkBackground,
  appBarTheme: AppBarTheme(
    backgroundColor: AppColors.darkSurface,
    elevation: 0,
    titleTextStyle: AppStyles.titleLarge.copyWith(color: Colors.white),
    iconTheme: const IconThemeData(color: Colors.white),
  ),
  cardTheme: const CardThemeData(
    color: AppColors.darkSurface,
    elevation: 2,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(12)),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: AppColors.darkSurface,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide.none,
    ),
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
  ),
  textTheme: TextTheme(
    displayLarge: AppStyles.displayLarge.copyWith(color: Colors.white),
    displayMedium: AppStyles.displayMedium.copyWith(color: Colors.white),
    // Add other text styles as needed
  ),
  extensions: const <ThemeExtension<dynamic>>[
    // Custom theme extensions if needed
  ],
);