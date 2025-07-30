import 'package:flutter/material.dart';
import '../../../core/AppTheme/AppColors.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool showMenu;
  final VoidCallback onMenuToggle;

  const HomeAppBar({
    super.key,
    required this.showMenu,
    required this.onMenuToggle,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: CustomColors.primary,
      elevation: 2, // Softer elevation
      leadingWidth: 150,
      leading: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Align(
          alignment: Alignment.centerLeft,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              'lib/assets/images/logo.png',
              fit: BoxFit.contain,
              height: 50,
              width: 140,
            ),
          ),
        ),
      ),
      actions: [
        IconButton(
          splashRadius: 24,
          icon: AnimatedSwitcher(
            duration: const Duration(milliseconds: 250),
            transitionBuilder: (child, animation) {
              return RotationTransition(turns: animation, child: child);
            },
            child: showMenu
                ? const Icon(Icons.close, key: ValueKey('close'), color: Colors.black87)
                : const Icon(Icons.more_vert, key: ValueKey('menu'), color: Colors.black87),
          ),
          onPressed: onMenuToggle,
        ),
        const SizedBox(width: 8),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
