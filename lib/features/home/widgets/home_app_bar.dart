import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:qr_meetapp/core/constants/asset_paths.dart';
import 'package:qr_meetapp/state/notifications_state.dart';

// Custom app bar for home screen with notification indicator
class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  // Optional explicit count; if 0, uses NotificationsState
  final int notificationCount;

  const HomeAppBar({
    super.key,
    this.notificationCount = 0,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final stateCount = context.watch<NotificationsState>().unreadCount;
    final badgeCount = notificationCount > 0 ? notificationCount : stateCount;

    final cs = Theme.of(context).colorScheme;

    return AppBar(
      title: GestureDetector(
        onTap: () => context.go('/home'),
        child: Row(
          children: [
            Hero(
              tag: 'app-logo',
              child: Image.asset(AssetPaths.logo, height: 32),
            ),
            const SizedBox(width: 12),
            Text(
              'MeetApp',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w600,
                color: cs.onSurface,
              ),
            ),
          ],
        ),
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.search, color: cs.onSurfaceVariant),
          onPressed: () {
            HapticFeedback.lightImpact();
            // TODO: Implement search functionality
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Search feature coming soon!')),
            );
          },
        ),
        Badge.count(
          count: badgeCount,
          isLabelVisible: badgeCount > 0,
          backgroundColor: cs.primary,
          textColor: cs.onPrimary,
          child: IconButton(
            icon: Icon(Icons.notifications_outlined, color: cs.onSurfaceVariant),
            onPressed: () {
              HapticFeedback.lightImpact();
              context.push('/home/notifications');
            },
          ),
        ),
      ],
      elevation: 0,
      backgroundColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      flexibleSpace: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: Container(
          decoration: BoxDecoration(
            color: cs.surface.withValues(alpha: 0.7),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                cs.surface.withValues(alpha: 0.8),
                cs.surface.withValues(alpha: 0.6),
              ],
            ),
          ),
        ),
        ),
      ),
    );
  }
}
