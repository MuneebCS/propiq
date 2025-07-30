import 'package:flutter/material.dart';
import '../../../core/AppTheme/AppColors.dart';
import '../../../widgets/StatusBadge.dart';

class LeadCard extends StatelessWidget {
  final String propertyAddress;
  final String owner;
  final String email;
  final String phone;
  final String status;
  final int price;
  final int beds;
  final int baths;
  final int sqft;
  final double score;

  const LeadCard({
    super.key,
    required this.propertyAddress,
    required this.owner,
    required this.email,
    required this.phone,
    required this.status,
    required this.price,
    required this.beds,
    required this.baths,
    required this.sqft,
    required this.score,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      color: CustomColors.primary,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Top Row — Address and Status
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    propertyAddress,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                StatusBadge(status: status),
              ],
            ),
            const SizedBox(height: 16),

            /// Owner Info
            _infoRow(Icons.person, owner),
            const SizedBox(height: 6),
            _infoRow(Icons.email, email),
            const SizedBox(height: 6),
            _infoRow(Icons.phone, phone),

            const Divider(height: 30, thickness: 1),

            /// Property Details
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _detailWithIcon(Icons.attach_money, 'Price', '\$$price'),
                _detailWithIcon(Icons.bed, 'Beds', '$beds'),
                _detailWithIcon(Icons.bathtub, 'Baths', '$baths'),
                _detailWithIcon(Icons.square_foot, 'Sqft', '$sqft'),
                _detailWithIcon(Icons.star, 'Score', score.toStringAsFixed(1)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoRow(IconData icon, String text) {
    return Row(
      children: [
        CircleAvatar(
          radius: 12,
          backgroundColor: Colors.grey.shade200,
          child: Icon(icon, size: 14, color: Colors.grey.shade700),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(fontSize: 14, color: Colors.black87),
          ),
        ),
      ],
    );
  }

  Widget _detailWithIcon(IconData icon, String label, String value) {
    return Column(
      children: [
        Icon(icon, size: 18, color: CustomColors.secondary),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(fontSize: 11, color: Colors.black54),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: CustomColors.secondary,
          ),
        ),
      ],
    );
  }
}
