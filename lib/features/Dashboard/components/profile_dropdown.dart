// File: components/profile_dropdown.dart
import 'package:flutter/material.dart';
import '../../../core/AppTheme/AppColors.dart';

class ProfileDropdownButton extends StatelessWidget {
  final VoidCallback onSettingsTap;
  final VoidCallback onLogoutTap;

  const ProfileDropdownButton({
    super.key,
    required this.onSettingsTap,
    required this.onLogoutTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 6,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: 160,
        decoration: BoxDecoration(
          color: CustomColors.primary,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _menuItem(context, Icons.settings, 'Settings', onSettingsTap),
            _menuItem(context, Icons.logout, 'Logout', onLogoutTap),
          ],
        ),
      ),
    );
  }

  Widget _menuItem(BuildContext context, IconData icon, String title, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        child: Row(
          children: [
            Icon(icon, size: 20, color: CustomColors.secondary),
            const SizedBox(width: 8),
            Text(
              title,
              style: const TextStyle(
                color: CustomColors.secondary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
