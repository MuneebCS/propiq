import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../Models/Properties/Properties.dart';
import '../../../../core/AppTheme/AppColors.dart';
import '../../../../widgets/StatusBadge.dart';
import '../../../../widgets/AppButton.dart';
import '../ExclusiveUpgradeView.dart';
import '../ReviewPage.dart';

class DetailedPropertyCard extends StatelessWidget {
  final Property property;

  const DetailedPropertyCard({super.key, required this.property});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);


    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 300),
      child: Card(
        elevation: 6,
        margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        color: Colors.white,
        shadowColor: Colors.black12,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _addressHeader(property),
              const SizedBox(height: 16),
              _badgeRow(),
              const SizedBox(height: 16),
              _propertyOverview(property),
              const SizedBox(height: 20),
              _sectionTitle("Seller"),
              _infoRow(Icons.person, property.seller.name),
              _infoRow(Icons.phone, property.seller.phones.first),
              _infoRow(Icons.email, property.seller.email),
              const SizedBox(height: 16),
              AppButton(
                text: "Make Exclusive",
                onPressed: () => _showExclusiveDialog(context),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _addressHeader(Property p) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Icon(Icons.location_on, color: Colors.blueAccent),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            '${p.address.street}, ${p.address.city}, ${p.address.state}, ${p.address.zipCode}',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        StatusBadge(status: "LowConfirmed"),
      ],
    );
  }

  Widget _badgeRow() {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: const [
        StatusBadge(status: "Zillow"),
        StatusBadge(status: "Street View"),
      ],
    );
  }

  Widget _sectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Widget _infoRow(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(icon, size: 18, color: Colors.black54),
          const SizedBox(width: 10),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    text,
                    style: const TextStyle(fontSize: 14),
                  ),
                ),
                if (icon == Icons.phone) ...[
                  const SizedBox(width: 8),
                  _buildActionButton(Icons.add, Colors.green),
                  const SizedBox(width: 8),
                  _buildActionButton(Icons.remove, Colors.red),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(IconData icon, Color color) {
    return Builder(
      builder: (context) => GestureDetector(
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text('Please review if the numbers are correct'),
              backgroundColor: CustomColors.secondary,
              duration: const Duration(seconds: 1),
            ),
          );

          Future.delayed(const Duration(seconds: 9), () {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (_) => LeadEngagementFeedback(
                onNext: () {
                  Navigator.of(context).pop(); // Close feedback dialog
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (_) => QuickSurveyForm(
                      onSubmit: () {
                        Navigator.of(context).pop(); // Close survey dialog
                      },
                    ),
                  );
                },
              ),
            );
          });
        },
        child: Icon(icon, color: color, size: 20),
      ),
    );
  }




  Widget _propertyOverview(Property p) {
    final formattedDate = DateFormat('yyyy-MM-dd').format(p.lastSaleDate);
    TextStyle labelStyle = const TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 14,
    );
    TextStyle valueStyle = const TextStyle(
      fontSize: 14,
      color: Colors.black87,
    );

    return Wrap(
      spacing: 20,
      runSpacing: 10,
      children: [
        _detailItem("Beds", '${p.beds}', labelStyle, valueStyle),
        _detailItem("Baths", '${p.baths}', labelStyle, valueStyle),
        _detailItem("Sqft", '${p.sqft}', labelStyle, valueStyle),
        _detailItem("ARV", '\$${p.arv}', labelStyle, valueStyle),
        _detailItem("Last Sale", '\$${p.lastSalePrice}', labelStyle, valueStyle),
       _detailItem("Sale Date", formattedDate, labelStyle, valueStyle),

    ],
    );
  }

  Widget _detailItem(String label, String value, TextStyle labelStyle, TextStyle valueStyle) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: labelStyle),
        const SizedBox(height: 2),
        Text(value, style: valueStyle),
      ],
    );
  }

  void _showExclusiveDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => ExclusiveDialog(
        onConfirm: () {
          // Add your exclusive logic here
          debugPrint("Property marked as exclusive!");
          // You can call setState(), API, etc. here
        },
      ),
    );
  }

}

