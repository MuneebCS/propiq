import 'package:flutter/material.dart';
import '../../../core/AppTheme/AppColors.dart';
import 'components/TermsSection.dart';


class TermsView extends StatelessWidget {
  const TermsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.primary,
      appBar: AppBar(
        title: const Text('Terms of Service & Privacy Policy'),
        backgroundColor: CustomColors.primary,
        elevation: 3,
        shadowColor: Colors.black12,
        iconTheme: const IconThemeData(color: Colors.black),
        titleTextStyle: const TextStyle(
          color: Colors.black87,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        children: const [
          TermsSection(
            title: '1. Acceptance of Terms',
            content:
            'By accessing or using RocketFuel, you agree to be bound by these Terms of Service and all applicable laws and regulations. '
                'If you do not agree, please do not use our platform.',
            showDivider: false,
          ),
          TermsSection(
            title: '2. Service Description',
            content:
            'RocketFuel provides real-time, AI-powered off-market seller leads and contact information for real estate investors. '
                'All data is for informational purposes only and should be independently verified.',
          ),
          TermsSection(
            title: '3. User Responsibilities',
            content:
            '• Use leads and contact information ethically and in compliance with all laws.\n'
                '• Do not share, resell, or misuse data provided by RocketFuel.\n'
                '• Maintain the confidentiality of your account credentials.',
          ),
          TermsSection(
            title: '4. Privacy Policy',
            content:
            'We respect your privacy. RocketFuel collects only necessary information to provide our services. '
                'We do not sell your personal data. For details, see our full Privacy Policy below.',
          ),
          TermsSection(
            title: '5. Data Security',
            content:
            'We use industry-standard security measures to protect your data. However, no system is 100% secure. '
                'Use RocketFuel at your own risk.',
          ),
          TermsSection(
            title: '6. Changes to Terms',
            content:
            'RocketFuel may update these terms at any time. Continued use of the platform constitutes acceptance of the new terms.',
          ),
          TermsSection(
            title: '7. Contact',
            content:
            'For questions or concerns, contact us at support@rocketfuel.com.',
          ),
          SizedBox(height: 24),
        ],
      ),
    );
  }
}
