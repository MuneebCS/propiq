import 'package:flutter/material.dart';

class StatusBadge extends StatelessWidget {
  final String status;

  const StatusBadge({super.key, required this.status});

  Map<String, dynamic> getStatusStyle(String status) {
    switch (status.toLowerCase()) {
      case 'high':
        return {'color': Colors.red, 'bg': Colors.red.withOpacity(0.1)};
      case 'medium':
      case 'mediumconfirmed':
        return {'color': Colors.orange, 'bg': Colors.orange.withOpacity(0.1)};
      case 'low':
        return {'color': Colors.green, 'bg': Colors.green.withOpacity(0.1)};
      case 'pending':
        return {'color': Colors.blue, 'bg': Colors.blue.withOpacity(0.1)};
      case 'make exclusive':
        return {'color': Colors.purple, 'bg': Colors.purple.withOpacity(0.1)};
      case 'zillow':
        return {'color': Colors.indigo, 'bg': Colors.indigo.withOpacity(0.1)};
      case 'street view':
        return {'color': Colors.brown, 'bg': Colors.brown.withOpacity(0.1)};
      case 'seller notes':
        return {'color': Colors.teal, 'bg': Colors.teal.withOpacity(0.1)};
      case 'temporarily paused due to high activity. check back soon.':
        return {'color': Colors.redAccent, 'bg': Colors.redAccent.withOpacity(0.1)};
      default:
        return {'color': Colors.grey, 'bg': Colors.grey.withOpacity(0.1)};
    }
  }


  @override
  Widget build(BuildContext context) {
    final style = getStatusStyle(status);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: style['bg'],
        border: Border.all(color: style['color']),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        status,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: style['color'],
        ),
      ),
    );
  }
}
