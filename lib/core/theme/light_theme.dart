import 'package:flutter/material.dart';
import 'package:qr_meetapp/core/constants/app_colors.dart';
import 'package:qr_meetapp/core/constants/app_styles.dart';

/// Light theme configuration for the app
final lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: AppColors.primary,
  colorScheme: const ColorScheme.light(
    primary: AppColors.primary,
    secondary: AppColors.secondary,
    surface: Colors.white,
    error: AppColors.error,
  ),
  scaffoldBackgroundColor: AppColors.lightBackground,
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.white,
    elevation: 0,
    titleTextStyle: AppStyles.titleLarge.copyWith(color: AppColors.grey900),
    iconTheme: const IconThemeData(color: AppColors.grey900),
  ),
  cardTheme: const CardThemeData(
    color: Colors.white,
    elevation: 2,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(12)),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: AppColors.grey50,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide.none,
    ),
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
  ),
  textTheme: TextTheme(
    displayLarge: AppStyles.displayLarge.copyWith(color: AppColors.grey900),
    displayMedium: AppStyles.displayMedium.copyWith(color: AppColors.grey900),
    // Add other text styles as needed
  ),
  extensions: const <ThemeExtension<dynamic>>[
    // Custom theme extensions if needed
  ],
);