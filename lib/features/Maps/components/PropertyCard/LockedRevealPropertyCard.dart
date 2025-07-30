import 'package:flutter/material.dart';
import '../../../../Models/Properties/Properties.dart';
import '../../../../widgets/AppButton.dart';
import '../../../../widgets/StatusBadge.dart';

class LockedRevealPropertyCard extends StatelessWidget {
  final Property property;

  const LockedRevealPropertyCard({super.key, required this.property});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 300),
      child: Card(
        elevation: 5,
        margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        color: Colors.grey.shade100,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _addressHeader(property),
              const SizedBox(height: 16),
              Wrap(
                spacing: 16,
                runSpacing: 10,
                children: [
                  _infoItem("Beds", "${property.beds}"),
                  _infoItem("Baths", "${property.baths}"),
                  _infoItem("Sqft", "${property.sqft}"),
                  _infoItem("ARV", "\$${property.arv}"),
                  _infoItem("Last Sale", "\$${property.lastSalePrice}"),
                  _infoItem("Sale Date", "${property.lastSaleDate}"),
                ],
              ),
              const SizedBox(height: 16),
              AppButton(
                text: "Reveal",
                onPressed: null, // Reveal intentionally disabled
              ),
              const SizedBox(height: 12),
              const StatusBadge(
                status: "Temporarily paused due to high activity. Check back soon.",
              ),
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
            '${p.address.city}, ${p.address.state}, ${p.address.zipCode}',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        StatusBadge(status: p.status),
      ],
    );
  }

  Widget _infoItem(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
        const SizedBox(height: 2),
        Text(
          value,
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
