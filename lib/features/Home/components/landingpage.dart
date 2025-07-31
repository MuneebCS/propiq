import 'package:flutter/material.dart';
import 'package:propiq/features/Home/components/pricing_section.dart';
import 'package:propiq/features/Home/components/testimonials_section.dart';
import '../../../widgets/AppButton.dart';
import 'benefits_section.dart';
import 'hero_section.dart';
import 'how_it_works_section.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.4),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutBack,
    ));

    _fadeAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    _scaleAnimation = Tween<double>(
      begin: 0.9,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.elasticOut,
    ));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // 🔹 Scrollable content
          SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 120),
            child: Column(
              children: const [
                HeroSection(),
                BenefitsSection(),
                HowItWorksSection(),
                TestimonialsSection(),
                PricingSection(),
              ],
            ),
          ),


          Positioned(
            bottom: 30,
            left: 20,
            right: 20,
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: SlideTransition(
                position: _slideAnimation,
                child: ScaleTransition(
                  scale: _scaleAnimation,
                  child: Container(
                    child: AppButton(
                      text: '🔓 Reveal 3 Free Leads Now',
                      onPressed: () {
                        Navigator.pushNamed(context, '/pricing');
                      },
                      isPrimary: false,
                      height: 60,
                      width: double.infinity,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
