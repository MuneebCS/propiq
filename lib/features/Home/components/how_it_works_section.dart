import 'package:flutter/material.dart';
import 'package:propiq/widgets/AppButton.dart';
import '../../../core/AppTheme/AppColors.dart'; // Optional: for theme colors

class HowItWorksSection extends StatelessWidget {
  const HowItWorksSection({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isMobile = MediaQuery.of(context).size.width < 600;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section Title
          Text(
            '🚀 How RocketFuel Gets You Deals—Faster',
            style: TextStyle(
              fontSize: isMobile ? 30 : 38,
              fontWeight: FontWeight.bold,
              color: CustomColors.secondary,
            ),
          ),
          const SizedBox(height: 32),

          // Step Cards
          const _StepCard(
            emoji: '🗺️',
            title: 'Choose Your Market',
            description: 'Interactive map highlights the hottest zip codes for off-market seller leads.',
          ),
          const SizedBox(height: 16),
          const _StepCard(
            emoji: '🔓',
            title: 'Reveal Motivated Sellers',
            description: 'Instantly unlock phone numbers, emails, and verified property info.',
          ),
          const SizedBox(height: 16),
          const _StepCard(
            emoji: '📞',
            title: 'Make the Call, Get the Deal',
            description: 'Connect, negotiate, and close before your competition even finds them.',
          ),
          const SizedBox(height: 32),

          AppButton(text:  'Try it now—your first 3 leads are free',     onPressed: () {
            Navigator.pushNamed(context, '/pricing'); // <-- make sure route is defined
          },)
        ],
      ),
    );
  }
}

class _StepCard extends StatelessWidget {
  final String emoji;
  final String title;
  final String description;

  const _StepCard({
    required this.emoji,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.withOpacity(0.15)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            emoji,
            style: const TextStyle(fontSize: 36),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade800,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
