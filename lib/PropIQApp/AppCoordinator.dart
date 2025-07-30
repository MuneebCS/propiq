import 'package:flutter/material.dart';
import 'package:propiq/features/Auth/LoginView.dart';
import 'package:propiq/features/Auth/SignupView.dart';
import 'package:propiq/features/Home/HomeView.dart';
import 'package:propiq/features/Pricing/PricingView.dart';
import 'package:propiq/features/Terms/TermsView.dart';

import '../features/Dashboard/DashboardView.dart';
import '../features/Leads/LeadsView.dart';
import '../features/Payments/PaymentCoordinatorView.dart';
import '../features/Settings/SettingView.dart';


class AppCoordinator {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const HomeView());
      case '/login':
        return MaterialPageRoute(builder: (_) => const LoginView());
      case '/signup':
        return MaterialPageRoute(builder: (_) => const SignupView());
      case '/home':
        return MaterialPageRoute(builder: (_) => const HomeView());
      case '/pricing':
        return MaterialPageRoute(builder: (_) => const PricingView());
      case '/terms':
        return MaterialPageRoute(builder: (_) => const TermsView());

      case '/dashboard':
        return MaterialPageRoute(builder: (_) => const DashboardView());
      case '/leads':
        return MaterialPageRoute(builder: (_) => const LeadsView());
      case '/payments':
        return MaterialPageRoute(builder: (_) => const PaymentsCoordinatorView());
      case '/settings':
        return MaterialPageRoute(builder: (_) => const SettingView());



      default:
        return MaterialPageRoute(builder: (_) => const HomeView());
    }
  }

}
