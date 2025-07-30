// File: components/custom_appbar.dart
import 'package:flutter/material.dart';
import '../../../core/AppTheme/AppColors.dart';
import 'icon_with_counter.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showIcons;
  final bool showProfileMenu;
  final VoidCallback? onProfileTap;
  final VoidCallback? onBack;
  final VoidCallback? onDownloadTap; // <-- new
  final VoidCallback? onHomeTap;     // <-- new

  const CustomAppBar({
    super.key,
    required this.title,
    required this.showIcons,
    this.showProfileMenu = true,
    this.onProfileTap,
    this.onBack,
    this.onDownloadTap, // <-- new
    this.onHomeTap,     // <-- new
  });


  @override
  Size get preferredSize => const Size.fromHeight(60);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 2,
      automaticallyImplyLeading: false,
      titleSpacing: 10,
      title: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              'lib/assets/images/logo.png',
              fit: BoxFit.contain,
              height: 60,
              width: 90,
            ),
          ),
          const Spacer(),
          if (showIcons) ...[
            IconButtonWithCount(
              icon: Icons.download,
              count: 0,
              onTap: onDownloadTap,
            ),
            const SizedBox(width: 8),
            IconButtonWithCount(
              icon: Icons.home,
              count: 0,
              onTap: onHomeTap,
            ),

            const SizedBox(width: 8),
            GestureDetector(
              onTap: onProfileTap,
              child: Row(
                children: const [
                  CircleAvatar(
                    backgroundColor: CustomColors.secondary,
                    child: Icon(Icons.person, color: Colors.white),
                  ),
                  SizedBox(width: 4),
                  Icon(Icons.arrow_drop_down, color: CustomColors.secondary),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}
