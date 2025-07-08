import 'package:flutter/material.dart';
import 'package:qr_meetapp/core/constants/app_colors.dart';
import 'package:qr_meetapp/core/constants/app_styles.dart';

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
          padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
          child: Text(
            title,
            style: AppStyles.headlineSmall.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        ...children,
      ],
    );
  }
}

class SettingsTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback? onTap;
  final Widget? trailing;
  final Color? color;

  const SettingsTile({
    super.key,
    required this.title,
    required this.icon,
    this.onTap,
    this.trailing,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: color ?? AppColors.grey600),
      title: Text(title, style: AppStyles.bodyLarge),
      trailing: trailing ?? const Icon(Icons.chevron_right, color: AppColors.grey500),
      onTap: onTap,
    );
  }
}

class SwitchTile extends StatelessWidget {
  final String title;
  final bool value;
  final ValueChanged<bool> onChanged;
  final IconData? icon;

  const SwitchTile({
    super.key,
    required this.title,
    required this.value,
    required this.onChanged,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: icon != null ? Icon(icon, color: AppColors.grey600) : null,
      title: Text(title, style: AppStyles.bodyLarge),
      trailing: Switch(
        value: value,
        onChanged: onChanged,
        activeColor: AppColors.primary,
      ),
    );
  }
}

class DangerTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  const DangerTile({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: AppColors.error),
      title: Text(
        title,
        style: AppStyles.bodyLarge.copyWith(color: AppColors.error),
      ),
      trailing: const Icon(Icons.chevron_right, color: AppColors.error),
      onTap: onTap,
    );
  }
}
