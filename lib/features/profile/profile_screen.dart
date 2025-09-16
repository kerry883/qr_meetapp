import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:qr_meetapp/core/constants/app_colors.dart';
import 'package:qr_meetapp/core/theme/app_theme.dart';
import 'package:qr_meetapp/core/widgets/cards/settings_tile.dart';
import 'package:qr_meetapp/state/auth_state.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Profile', style: AppTheme.textTheme.displaySmall),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 24),
            Center(
              child: Stack(
                children: [
                  const CircleAvatar(
                    radius: 60,
                    backgroundImage: AssetImage('assets/images/avatar.png'),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: const BoxDecoration(
                        color: AppColors.primary,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.edit, color: Colors.white, size: 20),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'John Doe',
              style: AppTheme.textTheme.displayMedium,
            ),
            Text(
              'john.doe@example.com',
              style: AppTheme.textTheme.bodyLarge,
            ),
            const SizedBox(height: 32),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  SettingsTile(
                    icon: Icons.person,
                    title: 'Personal Information',
                    onTap: () => Navigator.pushNamed(context, '/edit-profile'),
                  ),
                  SettingsTile(
                    icon: Icons.history,
                    title: 'Appointment History',
                    onTap: () {},
                  ),
                  SettingsTile(
                    icon: Icons.notifications,
                    title: 'Notification Settings',
                    onTap: () {},
                  ),
                  SettingsTile(
                    icon: Icons.security,
                    title: 'Security',
                    onTap: () {},
                  ),
                  SettingsTile(
                    icon: Icons.people,
                    title: 'Invite Friends',
                    onTap: () {},
                  ),
                  const SizedBox(height: 24),
                  SettingsTile(
                    icon: Icons.logout,
                    title: 'Logout',
                    color: AppColors.error,
                    onTap: () {
                      // Call logout from AuthState and navigate to login screen
                      final authState = Provider.of<AuthState>(context, listen: false);
                      authState.logout();
                      context.go('/login');
                    },
                  ),
                  SettingsTile(
                    icon: Icons.delete,
                    title: 'Delete Account',
                    color: AppColors.error,
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
