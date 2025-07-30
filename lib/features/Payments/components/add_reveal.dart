import 'package:flutter/material.dart';
import '../../../core/AppTheme/AppColors.dart';
import '../../../core/utils/device_utils.dart';
import '../../../widgets/AppButton.dart';

class AddRevealsView extends StatefulWidget {
  const AddRevealsView({super.key});

  @override
  State<AddRevealsView> createState() => _AddRevealsViewState();
}

class _AddRevealsViewState extends State<AddRevealsView> {
  int? _selectedIndex;
  bool _agreedToTerms = false;

  final List<Map<String, dynamic>> _options = [
    {'price': 25, 'reveals': 20},
    {'price': 50, 'reveals': 45},
    {'price': 75, 'reveals': 75},
    {'price': 100, 'reveals': 110},
  ];

  @override
  Widget build(BuildContext context) {
    final isTabletDevice = isTablet(context);
    final selected = _selectedIndex != null ? _options[_selectedIndex!] : null;

    return Scaffold(
      backgroundColor: CustomColors.primary,
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: isTabletDevice ? 32 : 20, vertical: 24),
        child: Column(
          children: [
            _topUpCard(),
            const SizedBox(height: 20),
            _orderSummaryCard(selected, isTabletDevice),
          ],
        ),
      ),
    );
  }

  Widget _topUpCard() {
    return Card(
      color: CustomColors.primary,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Wallet Top-Ups (For Pro Plan Users Only)',
              style: TextStyle(fontSize: 19, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 10),
            const Text(
              'Select the number of additional reveals you want to purchase:',
              style: TextStyle(fontSize: 14.5, color: Colors.black54),
            ),
            const SizedBox(height: 16),
            Center( // ⬅️ Ensures Wrap aligns centrally
              child: Wrap(
                spacing: 12,
                runSpacing: 12,
                children: List.generate(_options.length, (index) {
                  final option = _options[index];
                  final isSelected = _selectedIndex == index;

                  return GestureDetector(
                    onTap: () => setState(() => _selectedIndex = index),
                    child: Container(
                      width: 120,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        color: isSelected ? CustomColors.secondary.withOpacity(0.12) : Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: isSelected ? CustomColors.secondary : Colors.grey.shade300,
                          width: 2,
                        ),
                      ),
                      child: Column(
                        children: [
                          Text(
                            '\$${option['price']}',
                            style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '${option['reveals']} reveals',
                            style: const TextStyle(fontSize: 13.5),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }


  Widget _orderSummaryCard(Map<String, dynamic>? selected, bool isTablet) {
    return Card(
      color: CustomColors.primary,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 20, 16, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Order Summary',
              style: TextStyle(fontSize: 19, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 14),
            _summaryRow('Additional Reveals', '${selected?['reveals'] ?? 0} reveals'),
            const Divider(height: 28),
            _summaryRow('Total amount due', '\$${selected?['price'] ?? '0.00'}', isBold: true),
            const SizedBox(height: 16),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Checkbox(
                  value: _agreedToTerms,
                  onChanged: (val) => setState(() => _agreedToTerms = val!),
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
            const SizedBox(height: 14),
            Center(
              child: AppButton(
                text: 'Submit payment',
                width: isTablet ? 230 : double.infinity,
                isPrimary: true,
                onPressed: _agreedToTerms && selected != null
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
            const SizedBox(height: 18),
            const Text(
              'Purchase Details:\n'
                  '• Wallet reveals never expire\n'
                  '• Instant access to your purchased reveals anytime\n'
                  '• No recurring charges — one-time secure payment\n'
                  '• Exclusive reveals not available in free plan',
              style: TextStyle(fontSize: 13.5, color: Colors.black54, height: 1.5),
            ),
          ],
        ),
      ),
    );
  }

  Widget _summaryRow(String label, String value, {bool isBold = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: TextStyle(fontSize: 14.5, fontWeight: isBold ? FontWeight.w600 : FontWeight.normal)),
        Text(value, style: TextStyle(fontSize: 14.5, fontWeight: isBold ? FontWeight.w600 : FontWeight.normal)),
      ],
    );
  }
}
