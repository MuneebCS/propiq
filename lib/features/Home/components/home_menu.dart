import 'package:flutter/material.dart';
import '../../../core/AppTheme/AppColors.dart';
import '../../../widgets/AppButton.dart';

class HomeMenu extends StatelessWidget {
  final VoidCallback onClose;

  const HomeMenu({super.key, required this.onClose});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: kToolbarHeight - 40,
      right: 8,
      child: Material(
        elevation: 6,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          width: 220,
          padding: const EdgeInsets.symmetric(),
          decoration: BoxDecoration(
            color: CustomColors.primary,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _menuItem(context, Icons.home, 'Home', '/home', clearStack: true),
              _menuItem(context, Icons.attach_money, 'Pricing', '/pricing'),
              _menuItem(context, Icons.description, 'Terms', '/terms'),
              const Divider(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                child: AppButton(
                  text: "Login",
                  onPressed: () {
                    onClose();
                    _safeNavigate(context, "/login");
                  },
                  isPrimary: true,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                child: AppButton(
                  text: "Create Account",
                  onPressed: () {
                    onClose();
                    _safeNavigate(context, "/pricing");
                  },
                  isPrimary: false,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _menuItem(BuildContext context, IconData icon, String title, String route,
      {bool clearStack = false}) {
    return InkWell(
      onTap: () {
        onClose();
        _safeNavigate(context, route, clearStack: clearStack);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        child: Row(
          children: [
            Icon(icon, size: 20, color: CustomColors.secondary),
            const SizedBox(width: 8),
            Text(
              title,
              style: TextStyle(
                color: CustomColors.secondary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _safeNavigate(BuildContext context, String routeName, {bool clearStack = false}) {
    final currentRoute = ModalRoute.of(context)?.settings.name;
    if (currentRoute != routeName) {
      if (clearStack && routeName == '/home') {
        Navigator.pushNamedAndRemoveUntil(context, routeName, (route) => false);
      } else {
        Navigator.pushNamed(context, routeName);
      }
    }
  }
}
