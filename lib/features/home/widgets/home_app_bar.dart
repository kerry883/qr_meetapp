import 'package:flutter/material.dart';
import 'package:qr_meetapp/core/constants/app_colors.dart';
import 'package:qr_meetapp/core/constants/app_styles.dart';
import 'package:qr_meetapp/core/constants/asset_paths.dart';

// Custom app bar for home screen with notification indicator
class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  // Number of notifications to display as badge
  final int notificationCount;

  // Constructor with optional notification count (default 0)
  const HomeAppBar({
    super.key,
    this.notificationCount = 0,
  });

  // Required height for app bar
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      // Logo and app name in title area
      title: Row(
        children: [
          // Display app logo from assets
          Image.asset(
            AssetPaths.logo,
            height: 32,
          ),
          const SizedBox(width: 12), // Spacing between logo and text
          // App name text
          Text(
            'MeetApp',
            style: AppStyles.titleLarge.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.grey900,
            ),
          ),
        ],
      ),
      // Notification icon with badge indicator
      actions: [
        // Stack for badge positioning
        Stack(
          children: [
            // Notification icon button
            IconButton(
              icon: const Icon(Icons.notifications_outlined),
              onPressed: () {}, // TODO: Implement notification action
            ),
            // Badge indicator for notification count
            if (notificationCount > 0)
              Positioned(
                right: 8,
                top: 8,
                // Badge container
                child: Container(
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: AppColors.error,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  constraints: const BoxConstraints(
                    minWidth: 18,
                    minHeight: 18,
                  ),
                  // Notification count text
                  child: Text(
                    '$notificationCount',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              )
          ],
        ),
      ],
      elevation: 0, // Remove shadow
      backgroundColor: Colors.transparent, // Transparent background
    );
  }
}