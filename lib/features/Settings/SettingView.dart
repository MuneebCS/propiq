import 'package:flutter/material.dart';
import 'package:propiq/core/AppTheme/AppColors.dart';
import 'Components/contact_info.dart';
import 'Components/name_profile_section.dart';
import 'Components/password_reset.dart';


class SettingView extends StatelessWidget {
  const SettingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.primary,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            NameAndProfileSection(),
            SizedBox(height: 24),
            ContactInfoAndAddressSection(),
            SizedBox(height: 24),
            ResetPasswordSection(),
          ],
        ),
      ),
    );
  }
}





// File: screens/settings/sections/contact_info_section.dart


