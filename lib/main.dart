import 'package:flutter/material.dart';

import 'PropIQApp/AppCoordinator.dart';
import 'PropIQApp/PropIQApp.dart';
import 'core/AppTheme/AppTheme.dart';


void main() {
  runApp(
      PropIQApp(
          theme: AppTheme.defaultTheme,
          coordinator: AppCoordinator(),
      )
  );
}