// File: components/icon_button_with_count.dart
import 'package:flutter/material.dart';
import '../../../core/AppTheme/AppColors.dart';

class IconButtonWithCount extends StatelessWidget {
  final IconData icon;
  final int count;
  final VoidCallback? onTap;

  const IconButtonWithCount({
    super.key,
    required this.icon,
    this.count = 0,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: CustomColors.secondary.withAlpha((0.2 * 255).toInt()),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(icon, size: 18, color: CustomColors.secondary),
            const SizedBox(width: 4),
            Text(
              '$count',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: CustomColors.secondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
