// Import Flutter material library for UI components
import 'package:flutter/material.dart';
// Import app-specific color constants
import 'package:qr_meetapp/core/constants/app_colors.dart';
// Import app-specific text styles
import 'package:qr_meetapp/core/constants/app_styles.dart';

// Custom text button widget for consistent styling throughout the app
class AppTextButton extends StatelessWidget {
  // Required callback function when button is pressed
  final VoidCallback onPressed;
  // Text label displayed on the button
  final String label;
  // Optional custom text color (defaults to primary color)
  final Color? textColor;
  // Whether to show text underline (defaults to false)
  final bool isUnderlined;

  // Constructor with required parameters and optional ones
  const AppTextButton({
    super.key,
    required this.onPressed,
    required this.label,
    this.textColor,
    this.isUnderlined = false,
  });

  @override
  Widget build(BuildContext context) {
    // Build the core TextButton widget
    return TextButton(
      // Assign the press callback
      onPressed: onPressed,
      // Customize button appearance
      style: TextButton.styleFrom(
        // Set text color (use primary if not specified)
        foregroundColor: textColor ?? AppColors.primary,
        // Minimize padding for compact design
        padding: EdgeInsets.zero,
        // Remove minimum size constraints
        minimumSize: Size.zero,
        // Shrink tap target to content size
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      // Button text content
      child: Text(
        label,
        // Apply text styling with optional underline
        style: AppStyles.bodyMedium.copyWith(
          // Set text color
          color: textColor ?? AppColors.primary,
          // Add underline if requested
          decoration: isUnderlined ? TextDecoration.underline : TextDecoration.none,
        ),
      ),
    );
  }
}