import 'package:flutter/material.dart';
import '../../core/AppTheme/AppColors.dart';
import '../Leads/LeadsView.dart';
import '../Maps/MapsView.dart';
import '../Payments/PaymentCoordinatorView.dart';
import '../Settings/SettingView.dart';
import 'components/bottom_navbar.dart';
import 'components/custom_appbar.dart';
import 'components/profile_dropdown.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  int _selectedIndex = 0;
  bool showProfileMenu = false;

  final List<Widget> _pages = [
    MapsView(),
    const LeadsView(),
    const PaymentsCoordinatorView(),
    const SettingView(),
  ];


  String get _appBarTitle {
    switch (_selectedIndex) {
      case 1:
        return 'Leads';
      case 2:
        return 'Payments';
      case 3:
        return 'Settings';
      default:
        return 'Maps';
    }
  }

  void _goToLeads() {
    setState(() {
      _selectedIndex = 1;
      showProfileMenu = false;
    });
  }

  void _goToPayments() {
    setState(() {
      _selectedIndex = 2;
      showProfileMenu = false;
    });
  }

  void _goToSettings() {
    setState(() {
      _selectedIndex = 3;
      showProfileMenu = false;
    });
  }



  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (showProfileMenu) {
          setState(() => showProfileMenu = false);
        }
      },
      child: Stack(
        children: [
          Scaffold(
            backgroundColor: CustomColors.primary,
            appBar: CustomAppBar(
              title: _appBarTitle,
              showIcons: true,
              showProfileMenu: true,
              onProfileTap: () {
                setState(() {
                  showProfileMenu = !showProfileMenu;
                });
              },
              onDownloadTap: _goToPayments,
              onHomeTap: _goToLeads,
            ),


            body: _pages[_selectedIndex],
            bottomNavigationBar: CustomBottomNavBar(
              currentIndex: _selectedIndex,
              onTap: (index) {
                setState(() {
                  _selectedIndex = index;
                  showProfileMenu = false;
                });
              },
            ),
          ),

          // Dropdown below AppBar
          if (showProfileMenu)
            Positioned(
              top: kToolbarHeight + 40,
              right: 16,
              child: ProfileDropdownButton(
                onSettingsTap: _goToSettings,
                onLogoutTap: () => Navigator.pushNamed(context, '/logout'),
              ),
            ),

        ],
      ),
    );
  }
}
