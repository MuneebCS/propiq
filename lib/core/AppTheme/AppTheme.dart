import 'package:flutter/material.dart';
import 'AppColors.dart';

class AppTheme {
  static ThemeData get defaultTheme {
    final base = ThemeData.light();
    return base.copyWith(
      primaryColor: CustomColors.primary,
      secondaryHeaderColor: CustomColors.secondary
    );
  }
}
