import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

class BottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int>? onDestinationSelected; // for shell route integration

  const BottomNavBar({
    super.key,
    required this.selectedIndex,
    this.onDestinationSelected,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Container(
          decoration: BoxDecoration(
            color: cs.surface.withValues(alpha: 0.8),
            border: Border(
              top: BorderSide(color: cs.outlineVariant.withValues(alpha: 0.3), width: 1.0),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 16,
                offset: const Offset(0, -6),
              ),
            ],
          ),
          child: NavigationBar(
            selectedIndex: selectedIndex,
            labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
            animationDuration: const Duration(milliseconds: 300),
            onDestinationSelected: (index) {
              HapticFeedback.lightImpact();
              if (onDestinationSelected != null) {
                onDestinationSelected!(index);
              } else {
                _onItemTapped(context, index);
              }
            },
            destinations: [
              NavigationDestination(
                icon: Icon(Icons.home_outlined, color: cs.onSurfaceVariant),
                selectedIcon: Icon(Icons.home, color: cs.primary),
                label: 'Home',
              ),
              NavigationDestination(
                icon: Icon(Icons.calendar_today_outlined, color: cs.onSurfaceVariant),
                selectedIcon: Icon(Icons.calendar_today, color: cs.primary),
                label: 'Book',
              ),
              NavigationDestination(
                icon: Icon(Icons.qr_code_scanner_outlined, color: cs.onSurfaceVariant),
                selectedIcon: Icon(Icons.qr_code_scanner, color: cs.primary),
                label: 'Scan',
              ),
              NavigationDestination(
                icon: Icon(Icons.person_outlined, color: cs.onSurfaceVariant),
                selectedIcon: Icon(Icons.person, color: cs.primary),
                label: 'Profile',
              ),
              NavigationDestination(
                icon: Icon(Icons.settings_outlined, color: cs.onSurfaceVariant),
                selectedIcon: Icon(Icons.settings, color: cs.primary),
                label: 'Settings',
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onItemTapped(BuildContext context, int index) {
    switch (index) {
      case 0:
        context.goNamed('home');
        break;
      case 1:
        context.goNamed('booking');
        break;
      case 2:
        context.goNamed('scan');
        break;
      case 3:
        context.goNamed('profile');
        break;
      case 4:
        context.goNamed('settings');
        break;
    }
  }
}
