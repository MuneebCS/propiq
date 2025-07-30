import 'package:flutter/material.dart';

import 'AppCoordinator.dart';
import 'Strings.dart';

class PropIQApp extends StatelessWidget {

  final ThemeData theme;
  final AppCoordinator coordinator;


  const PropIQApp({
    super.key,
    required this.theme,
    required this.coordinator,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: AppStrings.appTitle.value,
      theme: theme,
      onGenerateRoute: coordinator.onGenerateRoute,
      navigatorKey: coordinator.navigatorKey,
    );
  }
}