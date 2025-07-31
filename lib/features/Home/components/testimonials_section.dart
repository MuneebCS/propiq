import 'package:flutter/material.dart';
import '../../../core/AppTheme/AppColors.dart'; // Optional: for theme colors

class TestimonialsSection extends StatelessWidget {
  const TestimonialsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '📈 Real Results from Real Investors',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: isMobile ? 30 : 38,
              color: CustomColors.secondary,
            ),
          ),
          const SizedBox(height: 32),
          Center(
            child: Wrap(
              spacing: 20,
              runSpacing: 20,
              alignment: WrapAlignment.start,
              children: const [
                _TestimonialCard(
                  name: 'Brandon T.',
                  quote: 'RocketFuel replaced 90% of my old CRM and direct mail budget. First week: \$18K wholesale fee.',
                ),
                _TestimonialCard(
                  name: 'Ashley R.',
                  quote: 'I got two deals in 30 days using the map + motivation score. Nothing else compares.',
                ),
                _TestimonialCard(
                  name: 'Luis D.',
                  quote: 'I don’t even hire cold callers anymore. This is plug-and-play.',
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),
          Text(
            '🛠️ Built by real investors who closed \$2.4M+ in deals using this exact system.',
            style: TextStyle(
              fontStyle: FontStyle.italic,
              fontSize: isMobile ? 14 : 16,
              color: Colors.grey.shade700,
            ),
          ),
        ],
      ),
    );
  }
}

class _TestimonialCard extends StatelessWidget {
  final String name;
  final String quote;

  const _TestimonialCard({
    required this.name,
    required this.quote,
  });

  @override
  Widget build(BuildContext context) {
    final initials = name.split(' ').map((e) => e[0]).take(2).join();

    return Container(
      width: 280,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.85),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.withOpacity(0.1)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          // Profile or Initials Circle
          CircleAvatar(
            radius: 24,
            backgroundColor: CustomColors.secondary.withOpacity(0.8),
            child: Text(
              initials,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 12),

          // Quote block
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('“', style: TextStyle(fontSize: 36, color: Colors.grey)),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  quote,
                  style: const TextStyle(
                    fontStyle: FontStyle.italic,
                    fontSize: 14,
                    height: 1.4,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Name footer
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              '- $name',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
