// File: components/bottom_navbar.dart
import 'package:flutter/material.dart';
import '../../../core/AppTheme/AppColors.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      selectedItemColor: CustomColors.secondary,
      unselectedItemColor: Colors.grey,
      backgroundColor: Colors.white,
      type: BottomNavigationBarType.fixed,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.map),
          label: 'Maps',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.group),
          label: 'Leads',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.payment),
          label: 'Payments',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          label: 'Settings',
        ),
      ],
    );
  }
}




