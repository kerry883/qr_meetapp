import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:qr_meetapp/core/constants/app_colors.dart';
import 'package:qr_meetapp/core/constants/app_styles.dart';
import 'package:qr_meetapp/core/constants/asset_paths.dart';

/// Generic empty state widget with optional action
class EmptyState extends StatelessWidget {
  final String title;
  final String message;
  final String? actionLabel;
  final VoidCallback? onAction;
  final double height;

  const EmptyState({
    super.key,
    required this.title,
    required this.message,
    this.actionLabel,
    this.onAction,
    this.height = 220,
  });

  @override
  Widget build(BuildContext context) {
    final showAction = actionLabel != null && onAction != null;

    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Lottie animation with fallback
            SizedBox(
              height: height,
              child: Lottie.asset(
                AssetPaths.emptyStateAnimation,
                fit: BoxFit.contain,
                repeat: true,
                errorBuilder: (_, __, ___) => Icon(
                  Icons.inbox_outlined,
                  size: height * 0.2,
                  color: AppColors.grey300,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: AppStyles.heading4,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4),
            Text(
              message,
              style: AppStyles.bodyMedium.copyWith(color: AppColors.grey600),
              textAlign: TextAlign.center,
            ),
            if (showAction) ...[
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: onAction,
                child: Text(actionLabel!),
              )
            ]
          ],
        ),
      ),
    );
  }
}