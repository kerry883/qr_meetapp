import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_meetapp/core/theme/app_theme.dart';
import 'package:qr_meetapp/core/widgets/cards/settings_tile.dart';
import 'package:qr_meetapp/state/theme_state.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<ThemeState>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Settings', style: AppTheme.textTheme.displaySmall),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 16),
        children: [
          SettingsSection(
            title: 'Appearance',
            children: [
              SettingsTile(
                icon: Icons.dark_mode,
                title: 'Dark Mode',
                trailing: Switch(
                  value: themeState.isDarkMode,
                  onChanged: (value) => themeState.toggleTheme(),
                ),
              ),
              SettingsTile(
                icon: Icons.color_lens,
                title: 'Theme Color',
                onTap: () {},
              ),
              SettingsTile(
                icon: Icons.text_fields,
                title: 'Font Size',
                onTap: () {},
              ),
            ],
          ),
          SettingsSection(
            title: 'Notifications',
            children: [
              SettingsTile(
                icon: Icons.notifications_active,
                title: 'Meeting Reminders',
                trailing: Switch(value: true, onChanged: (value) {}),
              ),
              SettingsTile(
                icon: Icons.volume_up,
                title: 'Notification Sounds',
                trailing: Switch(value: true, onChanged: (value) {}),
              ),
            ],
          ),
          SettingsSection(
            title: 'Account',
            children: [
              SettingsTile(
                icon: Icons.lock,
                title: 'Change Password',
                onTap: () {},
              ),
              SettingsTile(
                icon: Icons.language,
                title: 'Language',
                onTap: () {},
              ),
            ],
          ),
          SettingsSection(
            title: 'Support',
            children: [
              SettingsTile(
                icon: Icons.star,
                title: 'Rate Us',
                onTap: () {},
              ),
              SettingsTile(
                icon: Icons.feedback,
                title: 'Send Feedback',
                onTap: () {},
              ),
              SettingsTile(
                icon: Icons.help,
                title: 'Help Center',
                onTap: () {},
              ),
            ],
          ),
          SettingsSection(
            title: 'About',
            children: [
              SettingsTile(
                icon: Icons.info,
                title: 'About App',
                onTap: () {},
              ),
              SettingsTile(
                icon: Icons.privacy_tip,
                title: 'Privacy Policy',
                onTap: () {},
              ),
              SettingsTile(
                icon: Icons.description,
                title: 'Terms of Service',
                onTap: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class SettingsSection extends StatelessWidget {
  final String title;
  final List<Widget> children;
  
  const SettingsSection({
    super.key,
    required this.title,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(24, 24, 24, 8),
          child: Text(
            title,
            style: AppTheme.textTheme.displaySmall?.copyWith(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
        ...children,
        const SizedBox(height: 16),
      ],
    );
  }
}
