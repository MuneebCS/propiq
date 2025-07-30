import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../Models/Properties/Properties.dart';
import '../../../../widgets/AppButton.dart';
import '../../../../widgets/StatusBadge.dart';
import '../../../../core/AppTheme/AppColors.dart';

class RevealedPropertyCard extends StatelessWidget {
  final Property property;
  final void Function(Property) onReveal;

  const RevealedPropertyCard({
    super.key,
    required this.property,
    required this.onReveal,
  });

  String _formatDate(DateTime date) {
    return DateFormat('MMM dd, yyyy').format(date);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Card(
          color: CustomColors.secondary.withOpacity(0.1),
          elevation: 10,
          shadowColor: Colors.white24,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
          margin: const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
          child: Padding(
            padding: const EdgeInsets.all(22),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _headerSection(),
                const SizedBox(height: 18),
                _infoGrid(),
                const SizedBox(height: 24),
                Align(
                  alignment: Alignment.centerRight,
                  child: AppButton(
                    text: 'Reveal 🔓',
                    isPrimary: true,
                    onPressed: () => onReveal(property),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _headerSection() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Icon(Icons.location_on, color: Colors.redAccent),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            '${property.address.city}, ${property.address.state}, ${property.address.zipCode}',
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
              letterSpacing: 0.3,
            ),
          ),
        ),
        StatusBadge(status: property.status),
      ],
    );
  }

  Widget _infoGrid() {
    return Wrap(
      runSpacing: 16,
      spacing: 30,
      children: [
        _infoBox('🛏️ Beds', '${property.beds}'),
        _infoBox('🛁 Baths', '${property.baths}'),
        _infoBox('📐 Area', '${property.sqft} sqft'),
        _infoBox('💸 Last Sale', '\$${_formatNumber(property.lastSalePrice)}'),
        _infoBox('📅 Sale Date', _formatDate(property.lastSaleDate)),
        _infoBox('📈 ARV', '\$${_formatNumber(property.arv)}'),
      ],
    );
  }

  Widget _infoBox(String label, String value) {
    return SizedBox(
      width: 140,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label.toUpperCase(),
            style: const TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: 13,
              color: Colors.black54,
              letterSpacing: 1,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  String _formatNumber(num number) {
    return number.toStringAsFixed(0).replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match m) => '${m[1]},',
    );
  }
}
