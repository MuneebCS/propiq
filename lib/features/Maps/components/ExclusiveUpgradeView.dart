import 'package:flutter/material.dart';
import 'package:propiq/core/AppTheme/AppColors.dart';
import 'package:propiq/widgets/AppButton.dart';

class ExclusiveDialog extends StatelessWidget {
  final VoidCallback onConfirm;

  const ExclusiveDialog({super.key, required this.onConfirm});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primary = theme.colorScheme.primary;
    final secondary = theme.colorScheme.secondary;

    return Dialog(
      backgroundColor: Colors.white,
      insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 60),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 30, 20, 20),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Text(
                    "Confirm Exclusive Access",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color:  Colors.black
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Property Info
                  _buildCard(
                    title: "789 Pine Street, Springfield, OH, 45505",
                    titleColor: CustomColors.secondary,
                    children: const [
                      Text("Low"),
                      SizedBox(height: 4),
                      Text("2 Bed • 2 Bath • 800 sqft"),
                      SizedBox(height: 4),
                      Text("\$45,000 - Last Sale Price"),
                      Text("2016-01-17 - Last Sale Date"),
                      Text("\$95,000 - ARV"),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // Plan Features Section Title
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Plan Features",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: CustomColors.secondary,
                        )),
                  ),
                  const SizedBox(height: 10),

                  // Plan Cards
                  _buildPlanOption(
                    context: context,
                    price: "\$25",
                    label: "1-Day Access",
                    features: [
                      "Full seller contact access",
                      "Hide lead from other users for 24 hours",
                      '"Exclusive" badge shown to others',
                    ],
                    onTap: onConfirm,
                  ),
                  const SizedBox(height: 12),
                  _buildPlanOption(
                    context: context,
                    price: "\$40",
                    label: "3-Days Access",
                    features: [
                      "Full seller contact access",
                      "Hide lead from other users for 72 hours",
                      '"Exclusive" badge + countdown timer',
                    ],
                    onTap: onConfirm,
                  ),
                  const SizedBox(height: 12),
                  _buildPlanOption(
                    context: context,
                    price: "\$75",
                    label: "7-Days Access",
                    features: [
                      "Full seller contact access",
                      "Hide lead from other users for 7 days",
                      "Full protection + priority status",
                    ],
                    onTap: onConfirm,
                  ),

                  const SizedBox(height: 20),

                  // How It Works
                  _buildCard(
                    title: "How It Works",
                    titleColor: CustomColors.secondary,
                    children: _buildBulletPoints(secondary, [
                      "You can view and contact the seller immediately.",
                      "Other users cannot reveal contact info until your exclusive window expires.",
                      "An “EXCLUSIVE” label with a live countdown appears on the property for others.",
                      "The lead automatically becomes public again once the exclusivity expires.",
                    ]),
                  ),

                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),

          // ❌ Close icon
          Positioned(
            top: 10,
            right: 10,
            child: GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: const Icon(Icons.close, color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCard({
    required String title,
    required List<Widget> children,
    required Color titleColor,
  }) {
    return Card(
      color: CustomColors.primary,
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: titleColor,
                )),
            const SizedBox(height: 12),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _buildPlanOption({
    required BuildContext context,
    required String price,
    required String label,
    required List<String> features,
    required VoidCallback onTap,
  }) {
    final theme = Theme.of(context);
    final primary = theme.colorScheme.primary;
    final secondary = theme.colorScheme.secondary;

    return Card(
      color: CustomColors.primary,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("$price - $label",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: CustomColors.secondary,
                )),
            const SizedBox(height: 8),
            ..._buildBulletPoints(secondary, features),
            const SizedBox(height: 12),
            Align(
              alignment: Alignment.centerRight,
              child:  AppButton(text: "Upgrade Now", onPressed: onTap),
            ),

          ],
        ),
      ),
    );
  }

  List<Widget> _buildBulletPoints(Color dotColor, List<String> texts) {
    return texts
        .map((text) => Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("● ",
              style: TextStyle(
                color: dotColor,
                fontSize: 16,
                height: 1.4,
              )),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(height: 1.4),
            ),
          ),
        ],
      ),
    ))
        .toList();
  }
}
