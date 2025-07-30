import 'package:flutter/material.dart';
import '../../../core/AppTheme/AppColors.dart';
import '../../core/utils/device_utils.dart';
import 'components/PlanData.dart';
import 'components/PricingCard.dart';

class PricingView extends StatelessWidget {
  const PricingView({super.key});

  @override
  Widget build(BuildContext context) {
    final isTabletDevice = isTablet(context);

    final plans = [
      const PlanData(
        title: "Free Plan",
        price: "\$0.00",
        subtitle: "/month",
        features: [
          "New users get a 3-day free trial",
          "Up to 10 free reveals during trial period",
          "Limited access to lead details",
          "After the trial, users must subscribe to continue revealing contact info",
        ],
        buttonText: "Get Started",
      ),
      const PlanData(
        title: "Beta Plan",
        price: "\$97.00",
        subtitle: "/month",
        features: [
          "Includes 35 reveals per month",
          "Reveals expire each month (no rollover)",
          "No wallet top-ups allowed in Beta Plan",
        ],
        isPopular: true,
        buttonText: "Get Started",
      ),
      const PlanData(
        title: "Pro Plan",
        price: "\$200.00",
        subtitle: "/month",
        features: [
          "Includes 200 reveals per month",
          "Plan reveals expire monthly",
          "Top-up reveals can be purchased once 200 are used",
        ],
        buttonText: "Get Started",
      ),
    ];


    return Scaffold(
      backgroundColor: CustomColors.primary,
      appBar: AppBar(
        title: const Text("Pricing"),
        backgroundColor: CustomColors.primary,
        elevation: 3,
        shadowColor: Colors.black12,
        iconTheme: const IconThemeData(color: Colors.black),
        titleTextStyle: const TextStyle(
          color: Colors.black87,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Column(
          children: [
            _buildHeader(),
            const SizedBox(height: 20),
            Expanded(child: _buildPricingCards(context, isTabletDevice, plans)),
          ],
        ),
      ),
    );
  }

  /// 🔷 Top Section Header
  Widget _buildHeader() {
    return Center(
      child: Column(
        children: const [
          Text(
            'Subscription Plans',
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 6),
          Text(
            'Choose the plan that works best for you',
            style: TextStyle(
              fontSize: 15.5,
              color: Colors.black54,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  /// 🔷 Builds Pricing Cards based on device type
  Widget _buildPricingCards(BuildContext context, bool isTablet, List<PlanData> plans) {
    if (isTablet) {
      return Center(
        child: Wrap(
          spacing: 16,
          runSpacing: 16,
          children: plans
              .map((plan) => PricingCard(
            plan: plan,
            onPressed: () => Navigator.pushNamed(context, '/signup'),
          ))
              .toList(),
        ),
      );
    } else {
      return ListView.separated(
        itemCount: plans.length,
        itemBuilder: (context, index) {
          return PricingCard(
            plan: plans[index],
            onPressed: () => Navigator.pushNamed(context, '/signup'),
          );
        },
        separatorBuilder: (_, __) => const SizedBox(height: 16),
      );
    }
  }
}
