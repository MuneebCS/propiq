import 'package:flutter/material.dart';

class StatusBadge extends StatelessWidget {
  final String status;

  const StatusBadge({super.key, required this.status});

  Map<String, dynamic> getStatusStyle(String status) {
    switch (status.toLowerCase()) {
      case 'high':
        return {'color': Colors.red, 'bg': Colors.red.withAlpha((0.3 * 255).toInt()),};
      case 'medium':
      case 'mediumconfirmed':
        return {'color': Colors.orange, 'bg': Colors.orange.withAlpha((0.3 * 255).toInt()),};
      case 'low':
        return {'color': Colors.green, 'bg': Colors.green.withAlpha((0.3 * 255).toInt()),};
      case 'pending':
        return {'color': Colors.blue, 'bg': Colors.blue.withAlpha((0.3 * 255).toInt()),};
      case 'make exclusive':
        return {'color': Colors.purple, 'bg': Colors.purple.withAlpha((0.3 * 255).toInt()),};
      case 'zillow':
        return {'color': Colors.indigo, 'bg': Colors.indigo.withAlpha((0.3 * 255).toInt()),};
      case 'street view':
        return {'color': Colors.brown, 'bg': Colors.brown.withAlpha((0.3 * 255).toInt()),};
      case 'seller notes':
        return {'color': Colors.teal, 'bg': Colors.teal.withAlpha((0.3 * 255).toInt()),};
      case 'temporarily paused due to high activity. check back soon.':
        return {'color': Colors.redAccent, 'bg': Colors.redAccent.withAlpha((0.3 * 255).toInt()),};
      default:
        return {'color': Colors.grey, 'bg': Colors.grey.withAlpha((0.3 * 255).toInt()),};
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
