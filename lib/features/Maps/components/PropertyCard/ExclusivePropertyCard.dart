import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../Models/Properties/Properties.dart';
import '../../../../widgets/StatusBadge.dart';
import '../../../../core/AppTheme/AppColors.dart';

class ExclusivePropertyCard extends StatelessWidget {
  final Property property;

  const ExclusivePropertyCard({super.key, required this.property});

  String _formatDate(DateTime date) {
    return DateFormat('MMM dd, yyyy').format(date);
  }

  String _formatNumber(num number) {
    return number.toStringAsFixed(0).replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match m) => '${m[1]},',
    );
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
                _contactSection(),
                const SizedBox(height: 16),
                _exclusiveTime(),
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
        const Icon(Icons.location_on, color: Colors.deepPurple),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            '${property.address.street}, ${property.address.city}, ${property.address.state} ${property.address.zipCode}',
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
              letterSpacing: 0.3,
            ),
          ),
        ),
        Chip(
          label: const Text(
            "EXCLUSIVE",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 10, // reduced font size
              color: Colors.white,
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 0), // tighter padding
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap, // reduces size further
          backgroundColor: Colors.deepPurple,
        )

      ],
    );
  }

  Widget _infoGrid() {
    return LayoutBuilder(
      builder: (context, constraints) {
        int columns = (constraints.maxWidth / 160).floor().clamp(2, 4);

        return GridView.count(
          crossAxisCount: columns,
          crossAxisSpacing: 5,
          mainAxisSpacing: 6,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          childAspectRatio: 2,
          children: [
            _infoBox('🛏️ Beds', '${property.beds}'),
            _infoBox('🛁 Baths', '${property.baths}'),
            _infoBox('📐 Sqft', '${property.sqft}'),
            _infoBox('💸 ARV', '\$${_formatNumber(property.arv)}'),
            _infoBox('📅 Sale Date', _formatDate(property.lastSaleDate)),
            _infoBox('🏷️ Last Sale', '\$${_formatNumber(property.lastSalePrice)}'),
            _infoBox('📊 Score', '${property.score}'),
            _infoBox('🏷️ Classification', property.classification),
            _infoBox('🔄 Status', property.status),
          ],
        );
      },
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

  Widget _contactSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Seller Contact',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w700,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 10),
        _infoRow(Icons.person, property.seller.name),
        _infoRow(Icons.email, property.seller.email),
        _infoRow(Icons.phone, property.seller.phones.first),
      ],
    );
  }

  Widget _infoRow(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        children: [
          Icon(icon, size: 16, color: Colors.deepPurple),
          const SizedBox(width: 8),
          Expanded(child: Text(text, style: const TextStyle(fontSize: 14))),
        ],
      ),
    );
  }

  Widget _exclusiveTime() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const StatusBadge(status: "Mins Left"),
        Text(
          property.exclusiveTime ?? "N/A",
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.deepPurple,
          ),
        ),
      ],
    );
  }
}
