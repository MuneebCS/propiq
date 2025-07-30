import 'package:flutter/material.dart';
import '../../../core/AppTheme/AppColors.dart';

class TermsSection extends StatelessWidget {
  final String title;
  final String content;
  final bool showDivider;

  const TermsSection({
    super.key,
    required this.title,
    required this.content,
    this.showDivider = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (showDivider)
          Divider(
            color: Colors.grey.shade300,
            thickness: 1,
          ),
        Padding(
          padding: const EdgeInsets.only(top: 16.0, bottom: 6),
          child: Text(
            title,
            style: TextStyle(
              color: CustomColors.secondary,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Text(
          content,
          style: const TextStyle(
            fontSize: 14.5,
            height: 1.6,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 12),
      ],
    );
  }
}
