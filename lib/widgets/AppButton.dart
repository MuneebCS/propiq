import 'package:flutter/material.dart';
import '../core/AppTheme/AppColors.dart';

class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed; // ✅ made nullable
  final bool isPrimary;
  final double height;
  final double width;

  const AppButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isPrimary = true,
    this.height = 50,
    this.width = double.infinity,
  });

  @override
  Widget build(BuildContext context) {
    final bool isEnabled = onPressed != null;

    return SizedBox(
      height: height,
      width: width,
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          backgroundColor: isPrimary
              ? (isEnabled ? CustomColors.secondary : Colors.grey.shade300)
              : Colors.transparent,
          foregroundColor: isPrimary
              ? (isEnabled ? CustomColors.primary : Colors.grey)
              : CustomColors.secondary,
          side: isPrimary
              ? BorderSide.none
              : BorderSide(color: CustomColors.secondary, width: 1.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
