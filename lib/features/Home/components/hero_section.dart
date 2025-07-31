import 'package:flutter/material.dart';
import '../../../core/AppTheme/AppColors.dart';
import '../../../widgets/AppButton.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return SizedBox(
      height: screenHeight * 0.95,
      child: Stack(
        fit: StackFit.expand,
        children: [
          // 🔹 Background Image (leads.png)
          Positioned(
            top: screenHeight * 0.02,
            left: 0,
            right: 0,
            child: SizedBox(
              height: screenHeight * 0.28,
              child: Container(
                decoration: BoxDecoration(
                  image: const DecorationImage(
                    image: AssetImage('lib/assets/images/leads.png'),
                    fit: BoxFit.cover,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: CustomColors.primary.withOpacity(0.2),
                      blurRadius: 18,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // 🔹 Overlay Image (map.png)
          Positioned(
            top: screenHeight * 0.30,
            left: screenWidth * 0.07,
            right: screenWidth * 0.07,
            child: AspectRatio(
              aspectRatio: 16 / 9,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: CustomColors.secondary, width: 4),
                  boxShadow: [
                    BoxShadow(
                      color: CustomColors.primary.withOpacity(0.3),
                      blurRadius: 20,
                      offset: const Offset(0, 12),
                    ),
                  ],
                  image: const DecorationImage(
                    image: AssetImage('lib/assets/images/map.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),

          // 🔹 Gradient Overlay
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.white.withOpacity(0.05),
                    Colors.white.withOpacity(0.92),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
          ),

          // 🔹 Text and CTA
          Positioned(
            bottom: 200,
            left: 24,
            right: 24,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Find Off-Market Sellers Before Anyone Else—With Just One Click',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: screenWidth < 600 ? 22 : 32,
                    fontWeight: FontWeight.bold,
                    height: 1.3,
                    shadows: const [
                      Shadow(
                        blurRadius: 4.0,
                        color: Colors.black26,
                        offset: Offset(1.5, 1.5),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'RocketFuel uses real-time data + AI to surface the most motivated sellers in your market.\nNo cold calling. No dead lists. Just instant leads with verified contact info.',
                  style: TextStyle(
                    color: Colors.black.withOpacity(0.85),
                    fontSize: screenWidth < 600 ? 14 : 18,
                    height: 1.5,
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
