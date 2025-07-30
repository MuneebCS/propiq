import 'package:flutter/material.dart';
import '../../../core/AppTheme/AppColors.dart';
import '../../../core/utils/device_utils.dart';
import '../../../widgets/AppButton.dart';
import '../../Pricing/components/PlanData.dart';

class SubscriptionView extends StatefulWidget {
  final PlanData selectedPlan;
  final String currentPlanTitle;
  const SubscriptionView({super.key, required this.selectedPlan, required this.currentPlanTitle});

  @override
  State<SubscriptionView> createState() => _SubscriptionViewState();
}

class _SubscriptionViewState extends State<SubscriptionView> {
  bool _agreedToTerms = false;

  @override
  Widget build(BuildContext context) {
    final isTabletDevice = isTablet(context);
    final plan = widget.selectedPlan;

    return Scaffold(
      backgroundColor: CustomColors.primary,
      appBar: AppBar(
        title: const Text('Checkout'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: isTabletDevice ? 48 : 20,
          vertical: 24,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// ---------------- Plan Info ----------------
            Center(
              child: Column(
                children: [
                  Text(
                    '1. ${plan.title}',
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 6),
                  Text(
                    '${plan.price}${plan.subtitle}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.black54,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'What’s included:',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 10),
                  ...plan.features.map(
                        (f) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(top: 5),
                            width: 6,
                            height: 6,
                            decoration: BoxDecoration(
                              color: CustomColors.secondary,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              f,
                              style: const TextStyle(
                                fontSize: 14.5,
                                color: Colors.black87,
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

            const SizedBox(height: 32),


            const Text(
              '2. Choose Payment Method',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 12),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: const Text(
                '+ Add new payment method',
                style: TextStyle(fontSize: 14.5, color: Colors.black54),
              ),
            ),

            const SizedBox(height: 32),


            const Text(
              '3. Order Summary',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    'Upgrade from ${widget.currentPlanTitle} to ${widget.selectedPlan.title}',
                    style: const TextStyle(fontSize: 14),
                  ),
                ),
                Text(
                  plan.price,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const Divider(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  'Total amount due',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '\$0.00',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 32),


            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Checkbox(
                  value: _agreedToTerms,
                  onChanged: (val) {
                    setState(() {
                      _agreedToTerms = val ?? false;
                    });
                  },
                  activeColor: CustomColors.secondary,
                ),
                const Expanded(
                  child: Text(
                    'I agree to all of RocketFuel\'s Terms of Service & Privacy Policy.',
                    style: TextStyle(fontSize: 13.5),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            Center(
              child: AppButton(
                text: 'Submit payment',
                width: isTabletDevice ? 260 : double.infinity,
                isPrimary: true,
                onPressed: _agreedToTerms
                    ? () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Payment submitted.',
                        style: TextStyle(color: CustomColors.primary),
                      ),
                      backgroundColor: CustomColors.secondary,
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  );
                }
                    : null,
              ),
            ),


            const SizedBox(height: 20),

            const Text(
              'The subscription is set to auto-renew by default every month.\n'
                  'You can upgrade, cancel, or pause your subscription at any time.\n'
                  'All payments made once the subscription is active are final.',
              style: TextStyle(fontSize: 13.5, color: Colors.black54),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
