import 'package:flutter/material.dart';
import 'package:qr_meetapp/core/constants/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static final textTheme = TextTheme(
    displayLarge: GoogleFonts.poppins(fontSize: 28, fontWeight: FontWeight.bold),
    displayMedium: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.w600),
    displaySmall: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w500),
    bodyLarge: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.normal),
    bodyMedium: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.normal),
    bodySmall: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.normal),
  );

  static final lightTheme = ThemeData(
    useMaterial3: true,
    colorScheme: const ColorScheme.light(
      primary: AppColors.primary,
      secondary: AppColors.secondary,
      surface: AppColors.surfaceLight,
      error: AppColors.error,
    ),
    textTheme: textTheme,
    scaffoldBackgroundColor: AppColors.backgroundLight,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: textTheme.displayMedium?.copyWith(color: AppColors.textLight),
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.primary),
      ),
      filled: true,
      fillColor: AppColors.surfaceLight,
    ),
  );

  static final darkTheme = ThemeData(
    useMaterial3: true,
    colorScheme: const ColorScheme.dark(
      primary: AppColors.primaryDark,
      secondary: AppColors.secondaryDark,
      surface: AppColors.surfaceDark,
      error: AppColors.error,
    ),
    textTheme: textTheme.apply(
      bodyColor: AppColors.textDark,
      displayColor: AppColors.textDark,
    ),
    scaffoldBackgroundColor: AppColors.backgroundDark,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: textTheme.displayMedium?.copyWith(color: AppColors.textDark),
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.primaryDark),
      ),
      filled: true,
      fillColor: AppColors.surfaceDark,
    ),
  );
}
