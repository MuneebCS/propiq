import 'package:flutter/material.dart';
import '../../../core/AppTheme/AppColors.dart';

class BenefitsSection extends StatelessWidget {
  const BenefitsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section Heading
          Center(
            child: Text(
              '🔥 Why Real Investors Are Switching to RocketFuel',
              style: TextStyle(
                fontSize: isMobile ? 30 : 48,
                fontWeight: FontWeight.bold,
                color: CustomColors.secondary,
              ),
            ),
          ),
          const SizedBox(height: 32),

          // Benefit Cards
          Wrap(
            spacing: 20,
            runSpacing: 20,
            alignment: WrapAlignment.start,
            children: const [
              _BenefitCard(
                icon: '🤖',
                title: 'AI-Scored Leads',
                desc: 'Prioritized by actual seller behavior and urgency.',
              ),
              _BenefitCard(
                icon: '⚡',
                title: 'Instant Contact Info',
                desc: 'Skip traced & ready to call or text.',
              ),
              _BenefitCard(
                icon: '📞',
                title: 'No Marketing Required',
                desc: 'No cold calls, mailers, or dead-end SMS blasts.',
              ),
              _BenefitCard(
                icon: '🔒',
                title: 'Exclusive Access',
                desc: 'Pay to reveal & reserve leads others can\'t touch.',
              ),
              _BenefitCard(
                icon: '🔄',
                title: 'Smarter Than Lists',
                desc: 'RocketFuel updates daily—never stale.',
              ),
            ],
          ),

          const SizedBox(height: 32),

          // Testimonial
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: CustomColors.secondary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: CustomColors.secondary.withOpacity(0.3)),
            ),
            child: const Text(
              '“I used to cold call 300 people a day. Now I lock up 2–3 deals a month without ever dialing the wrong number.”\n— Jason M., Investor in Columbus, OH',
              style: TextStyle(
                fontStyle: FontStyle.italic,
                fontSize: 16,
                height: 1.6,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _BenefitCard extends StatelessWidget {
  final String icon;
  final String title;
  final String desc;

  const _BenefitCard({
    required this.icon,
    required this.title,
    required this.desc,
  });

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;

    return Container(
      width: isMobile ? double.infinity : 250,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            CustomColors.secondary.withOpacity(0.15),
            Colors.white,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: CustomColors.primary.withOpacity(0.08),
            blurRadius: 10,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            icon,
            style: const TextStyle(fontSize: 36),
          ),
          const SizedBox(height: 12),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            desc,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade800,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}
