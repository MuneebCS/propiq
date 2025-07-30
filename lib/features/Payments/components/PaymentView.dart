import 'package:flutter/material.dart';
import 'package:propiq/features/Payments/components/subscription_confirmation_view.dart';
import '../../../core/AppTheme/AppColors.dart';
import '../../../core/utils/device_utils.dart';
import '../../../widgets/AppButton.dart';
import '../../Pricing/components/PlanData.dart';
import '../../Pricing/components/PricingCard.dart';

class PaymentsView extends StatelessWidget {
  final VoidCallback? onAddRevealsTap;

  const PaymentsView({super.key, this.onAddRevealsTap});


  @override
  Widget build(BuildContext context) {
    final isTabletDevice = isTablet(context);

    final plans = [
      const PlanData(
        title: "Free Plan",
        price: "\$0.00",
        subtitle: "/month",
        buttonText: "Upgrade",
        features: [
          "New users get a 3-day free trial",
          "Up to 10 free reveals during trial period",
          "Limited access to lead details",
          "After the trial, users must subscribe to continue revealing contact info",
        ],
      ),
      const PlanData(
        title: "Beta Plan",
        price: "\$97.00",
        subtitle: "/month",
        buttonText: "Upgrade",
        features: [
          "Includes 35 reveals per month",
          "Reveals expire each month (no rollover)",
          "No wallet top-ups allowed in Beta Plan",
        ],
        isPopular: true,
      ),
      const PlanData(
        title: "Pro Plan",
        price: "\$200.00",
        subtitle: "/month",
        buttonText: "Upgrade",
        features: [
          "Includes 200 reveals per month",
          "Plan reveals expire monthly",
          "Top-up reveals can be purchased once 200 are used",
        ],
      ),
    ];

    return Scaffold(
      backgroundColor: CustomColors.primary,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildPlanInfoCard(),
            const SizedBox(height: 12),
            _buildRevealsCard(context),
            const SizedBox(height: 20),
            _buildHeader(),
            const SizedBox(height: 20),
            _buildPricingCards(context, isTabletDevice, plans),
          ],
        ),
      ),
    );
  }

  Widget _buildPlanInfoCard() {
    return SizedBox(
      width: double.infinity,
      child: Card(
        color: CustomColors.primary,
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              Text(
                'Your current plan is',
                style: TextStyle(fontSize: 14, color: Colors.black54),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 4),
              Text(
                'Basic Free',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 8),
              Text(
                '\$0.00',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 4),
              Text(
                'Next payment due: -',
                style: TextStyle(color: Colors.black54),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }


  Widget _buildRevealsCard(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Card(
        color: CustomColors.primary,
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                '0',
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 4),
              const Text(
                'Reveals remaining',
                style: TextStyle(color: Colors.black54),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              AppButton(
                text: "Add Reveals",
                onPressed: onAddRevealsTap,
                isPrimary: true,
                width: 160,
              ),

            ],
          ),
        ),
      ),
    );
  }


  Widget _buildHeader() {
    return Center(
      child: Column(
        children: const [
          Text(
            'Upgrade Plans',
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

  Widget _buildPricingCards(BuildContext context, bool isTablet, List<PlanData> plans) {
    if (isTablet) {
      return Center(
        child: Wrap(
          spacing: 16,
          runSpacing: 16,
          children: plans
              .map((plan) => PricingCard(
            plan: plan,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SubscriptionView(
                    selectedPlan: plan,
                    currentPlanTitle: "Basic Free",
                  ),

                ),
              );
            },

          ))
              .toList(),
        ),
      );
    } else {
      return Column(
        children: plans
            .map((plan) => Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: PricingCard(
            plan: plan,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SubscriptionView(
                    selectedPlan: plan,
                    currentPlanTitle: "Basic Free", // this comes from state or backend
                  ),

                ),
              );
            },
          ),
        ))
            .toList(),
      );
    }
  }
}
