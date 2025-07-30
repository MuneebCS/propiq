import 'package:flutter/material.dart';
import '../../../core/AppTheme/AppColors.dart';
import '../../../widgets/AppTextField.dart';
import '../../../widgets/AppButton.dart';

class ResetPasswordSection extends StatefulWidget {
  const ResetPasswordSection({super.key});

  @override
  State<ResetPasswordSection> createState() => _ResetPasswordSectionState();
}

class _ResetPasswordSectionState extends State<ResetPasswordSection> {
  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _showCurrent = false;
  bool _showNew = false;
  bool _showConfirm = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: CustomColors.primary,
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      margin: const EdgeInsets.symmetric(vertical: 20),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                "Reset Password",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(height: 24),

            AppTextField(
              label: "Current Password *",
              hintText: "Enter current password",
              controller: _currentPasswordController,
              obscureText: !_showCurrent,
              suffixIcon: IconButton(
                icon: Icon(
                  _showCurrent ? Icons.visibility : Icons.visibility_off,
                ),
                onPressed: () {
                  setState(() {
                    _showCurrent = !_showCurrent;
                  });
                },
              ),
            ),
            const SizedBox(height: 14),

            AppTextField(
              label: "New Password *",
              hintText: "Enter new password",
              controller: _newPasswordController,
              obscureText: !_showNew,
              suffixIcon: IconButton(
                icon: Icon(
                  _showNew ? Icons.visibility : Icons.visibility_off,
                ),
                onPressed: () {
                  setState(() {
                    _showNew = !_showNew;
                  });
                },
              ),
            ),
            const SizedBox(height: 14),

            AppTextField(
              label: "Confirm New Password *",
              hintText: "Re-enter new password",
              controller: _confirmPasswordController,
              obscureText: !_showConfirm,
              suffixIcon: IconButton(
                icon: Icon(
                  _showConfirm ? Icons.visibility : Icons.visibility_off,
                ),
                onPressed: () {
                  setState(() {
                    _showConfirm = !_showConfirm;
                  });
                },
              ),
            ),
            const SizedBox(height: 24),

            Row(
              children: [
                Expanded(
                  child: AppButton(
                    text: "Save",
                    onPressed: () {},
                    isPrimary: true,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: AppButton(
                    text: "Cancel",
                    onPressed: () {},
                    isPrimary: false,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
