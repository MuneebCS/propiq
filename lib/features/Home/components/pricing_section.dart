import 'package:flutter/material.dart';
import 'package:propiq/widgets/AppButton.dart';
import '../../../core/AppTheme/AppColors.dart';

class PricingSection extends StatelessWidget {
  const PricingSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 24),
      color: CustomColors.primary.withAlpha(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            '💰 Ready to Close More Deals—Without the Overhead?',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: isMobile ? 26 : 36,
              fontWeight: FontWeight.bold,
              color: CustomColors.secondary,
            ),
          ),
          const SizedBox(height: 24),

          Text(
            'Start for Free — 3 High-Motivation Leads, On Us',
            style: TextStyle(
              fontSize: isMobile ? 16 : 20,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),

          // 🌟 FREE PLAN CARD
          _PricingCard(
            title: 'Free Trial',
            subtitle: '3 exclusive seller leads',
            price: '\$0',
            buttonText: '🔓 Reveal Free Leads Now',
            onPressed: () {
              Navigator.pushNamed(context, '/pricing'); // <-- make sure route is defined
            },
            highlight: false,
          ),
          const SizedBox(height: 32),

          // 🚀 PRO PLAN CARD
          _PricingCard(
            title: 'Pro Access',
            subtitle: 'Unlimited markets, 60% off reveals',
            price: '\$200/mo',
            buttonText: '🚀 Upgrade to Pro',
            onPressed: () {
              Navigator.pushNamed(context, '/pricing'); // <-- make sure route is defined
            },
            highlight: true,
          ),
          const SizedBox(height: 24),

          AppButton(text: '🧪 See a Live Demo', onPressed: (){})
        ],
      ),
    );
  }
}

class _PricingCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String price;
  final String buttonText;
  final VoidCallback onPressed;
  final bool highlight;

  const _PricingCard({
    required this.title,
    required this.subtitle,
    required this.price,
    required this.buttonText,
    required this.onPressed,
    required this.highlight,
  });

  @override
  Widget build(BuildContext context) {
    final Color borderColor = highlight ? CustomColors.secondary : Colors.grey.shade300;
    final Color bgColor = highlight ? CustomColors.secondary.withAlpha(20) : Colors.white;
    final bool isMobile = MediaQuery.of(context).size.width < 600;

    return Container(
      width: isMobile ? double.infinity : 400,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: borderColor, width: 2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 12,
            offset: const Offset(0, 6),
          )
        ],
      ),
      child: Column(
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: CustomColors.secondary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            subtitle,
            style: const TextStyle(fontSize: 16, color: Colors.black87),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Text(
            price,
            style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.bold,
              color: highlight ? CustomColors.secondary : Colors.black,
            ),
          ),
          const SizedBox(height: 20),
          AppButton(text: buttonText, onPressed: onPressed)
        ],
      ),
    );
  }
}
