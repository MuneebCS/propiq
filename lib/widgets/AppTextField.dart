import 'package:flutter/material.dart';
import '../core/AppTheme/AppColors.dart';

class AppTextField extends StatelessWidget {
  final String label;
  final String hintText;
  final TextEditingController controller;
  final bool obscureText;
  final TextInputType keyboardType;
  final String? errorText;
  final Widget? suffixIcon;
  final Function(String)? onChanged;

  const AppTextField({
    super.key,
    required this.label,
    required this.hintText,
    required this.controller,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.errorText,
    this.suffixIcon,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final Color borderColor = Colors.grey.shade400;
    final Color focusedColor = CustomColors.secondary;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 6),
        TextField(
          controller: controller,
          obscureText: obscureText,
          keyboardType: keyboardType,
          onChanged: onChanged,
          decoration: InputDecoration(
            hintText: hintText,
            suffixIcon: suffixIcon,
            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: borderColor),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: borderColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: focusedColor, width: 2),
            ),
          ),
        ),
        if (errorText != null)
          Padding(
            padding: const EdgeInsets.only(top: 6),
            child: Text(
              errorText!,
              style: const TextStyle(
                color: CustomColors.error,
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
      ],
    );
  }
}
