import 'package:flutter/material.dart';
import 'package:qr_meetapp/core/constants/app_colors.dart';
import 'package:qr_meetapp/core/constants/app_styles.dart';
import "package:qr_meetapp/core/widgets/buttons/text_button.dart";

// Reusable section header component for content grouping
class SectionHeader extends StatelessWidget {
  // Required title text for the section
  final String title;
  // Optional action text (e.g., "View All")
  final String? actionText;
  // Optional callback for when action is pressed
  final VoidCallback? onAction;

  // Constructor with required title and optional action
  const SectionHeader({
    super.key,
    required this.title,
    this.actionText,
    this.onAction,
  });

  @override
  Widget build(BuildContext context) {
    // Padding around the entire header
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      // Horizontal layout with title and action
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Section title with styling
          Text(
            title,
            style: AppStyles.headlineSmall.copyWith(
              fontWeight: FontWeight.w600,
              color: AppColors.grey800,
            ),
          ),
          // Conditionally show action button
          if (actionText != null)
            AppTextButton(
              onPressed: onAction ?? () {}, // Default empty callback
              label: actionText!,
            ),
        ],
      ),
    );
  }
}