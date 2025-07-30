import 'package:flutter/material.dart';
import '../../../core/AppTheme/AppColors.dart';
import '../../../core/utils/device_utils.dart';
import '../../../widgets/AppButton.dart';
import 'PlanData.dart';

class PricingCard extends StatelessWidget {
  final PlanData plan;
  final VoidCallback onPressed;

  const PricingCard({
    super.key,
    required this.plan,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final isTabletDevice = isTablet(context);
    final textTheme = Theme.of(context).textTheme;

    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      margin: EdgeInsets.symmetric(
        vertical: 16,
        horizontal: isTabletDevice ? 8 : 16,
      ),
      child: Container(
        width: isTabletDevice ? 320 : double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              CustomColors.primary.withOpacity(0.95),
              CustomColors.primary.withOpacity(0.85),
            ],
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 20,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Stack(
          children: [
            if (plan.isPopular)
              Positioned(
                top: 0,
                left: 0,
                child: CustomPaint(
                  size: const Size(80, 35),
                  painter: _RibbonPainter(
                    color: Colors.deepOrange,
                    text: 'POPULAR',
                  ),
                ),
              ),
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (plan.isPopular) const SizedBox(height: 20),

                  Text(
                    plan.title,
                    style: textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: CustomColors.secondary,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 8),

                  MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      padding: const EdgeInsets.symmetric(
                        vertical: 8,
                        horizontal: 16,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        children: [
                          Text(
                            plan.price,
                            style: textTheme.headlineMedium?.copyWith(
                              fontWeight: FontWeight.w800,
                              color: Colors.black87,
                            ),
                          ),
                          Text(
                            plan.subtitle,
                            style: textTheme.bodyMedium?.copyWith(
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  AppButton(
                    text: plan.buttonText,
                    onPressed: onPressed,
                    isPrimary: true,
                    height: 50,
                    width: isTabletDevice ? 200 : double.infinity,
                  ),
                  const SizedBox(height: 28),

                  Row(
                    children: [
                      const Expanded(
                        child: Divider(
                          color: Colors.black26,
                          thickness: 1,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Icon(
                          Icons.star,
                          color: CustomColors.secondary,
                          size: 18,
                        ),
                      ),
                      const Expanded(
                        child: Divider(
                          color: Colors.black26,
                          thickness: 1,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  Text(
                    'What\'s included',
                    style: textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 16),

                  ...plan.features.map(
                        (feature) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.check_circle,
                            color: CustomColors.secondary,
                            size: 20,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              feature,
                              style: textTheme.bodyLarge?.copyWith(
                                color: Colors.black87,
                                height: 1.5,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _RibbonPainter extends CustomPainter {
  final Color color;
  final String text;

  _RibbonPainter({required this.color, required this.text});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;

    final path = Path()
      ..moveTo(0, 0)
      ..lineTo(size.width * 0.7, 0)
      ..lineTo(size.width, size.height * 0.5)
      ..lineTo(size.width * 0.7, size.height)
      ..lineTo(0, size.height)
      ..close();

    canvas.drawShadow(path, Colors.black45, 4, true);
    canvas.drawPath(path, paint);

    final textPainter = TextPainter(
      text: TextSpan(
        text: text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 11,
          fontWeight: FontWeight.w700,
        ),
      ),
      maxLines: 1,
      textDirection: TextDirection.ltr,
    )..layout(minWidth: 0, maxWidth: size.width);

    final offset = Offset(
      (size.width - textPainter.width) / 2,
      (size.height - textPainter.height) / 2,
    );

    textPainter.paint(canvas, offset);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
