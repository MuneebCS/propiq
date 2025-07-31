import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../Models/Properties/Properties.dart';
import '../../../../widgets/StatusBadge.dart';

class ExclusivePropertyCard extends StatelessWidget {
  final Property property;

  const ExclusivePropertyCard({super.key, required this.property});

  String _formatDate(DateTime date) {
    return DateFormat('MMM dd, yyyy').format(date);
  }


  @override
  Widget build(BuildContext context) {
    final address = property.address;
    final location = "${address.city}, ${address.state}, ${address.zipCode}";

    return Center(
      child: Card(
        elevation: 16,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
        margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        shadowColor: Colors.deepPurple.withAlpha((0.2 * 255).toInt()),
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  StatusBadge(status: "Exclusive"),
                  const SizedBox(width: 12),
                  StatusBadge(status: property.status),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                location,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),

              const SizedBox(height: 24),
              Wrap(
                spacing: 20,
                runSpacing: 12,
                alignment: WrapAlignment.center,
                children: [
                  _iconText("🛏️", "${property.beds} Bed"),
                  _iconText("🛁", "${property.baths} Bath"),
                  _iconText("📐", "${property.sqft} sqft"),
                ],
              ),
              const SizedBox(height: 24),
              const Divider(height: 1, thickness: 0.4),
              const SizedBox(height: 16),
              _infoRow("Last Sale Price", "\$${_formatNumber(property.lastSalePrice)}"),
              _infoRow("Last Sale Date", _formatDate(property.lastSaleDate)),
              _infoRow('📈 ARV', '\$${_formatNumber(property.arv)}'),
              const SizedBox(height: 26),
              const Text(
                "Mins Left",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.deepPurple,
                ),
              ),
              Text(
                property.exclusiveTime ?? "N/A",
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _iconText(String emoji, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(emoji, style: const TextStyle(fontSize: 18)),
        const SizedBox(width: 6),
        Text(
          text,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }

  Widget _infoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black54,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 15,
              color: Colors.black87,
              fontWeight: FontWeight.w700,
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
