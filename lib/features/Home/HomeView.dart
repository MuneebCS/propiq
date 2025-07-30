import 'package:flutter/material.dart';
import '../../core/AppTheme/AppColors.dart';
import 'components/home_appbar.dart';
import 'components/home_menu.dart';
import 'components/home_content.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  bool _showMenu = false;

  void _toggleMenu() {
    setState(() => _showMenu = !_showMenu);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.primary, // primary background
      appBar: HomeAppBar(
        showMenu: _showMenu,
        onMenuToggle: _toggleMenu,
      ),
      body: Stack(
        children: [
          const HomeContent(),
          if (_showMenu) HomeMenu(onClose: _toggleMenu),
        ],
      ),
    );
  }
}
