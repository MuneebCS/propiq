import 'package:flutter/material.dart';
import '../../../core/AppTheme/AppColors.dart';
import '../../../widgets/AppTextField.dart';
import '../../../widgets/AppButton.dart';

class ContactInfoAndAddressSection extends StatefulWidget {
  const ContactInfoAndAddressSection({super.key});

  @override
  State<ContactInfoAndAddressSection> createState() =>
      _ContactInfoAndAddressSectionState();
}

class _ContactInfoAndAddressSectionState
    extends State<ContactInfoAndAddressSection> {
  bool _sendNotifications = true;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: CustomColors.primary,
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      margin: const EdgeInsets.symmetric(vertical: 20),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                "Contact Info and Address",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(height: 24),

            AppTextField(
              label: "Email Address *",
              hintText: "you@example.com",
              controller: TextEditingController(),
            ),
            const SizedBox(height: 14),

            AppTextField(
              label: "Phone Number *",
              hintText: "+1 000 000 0000",
              controller: TextEditingController(),
            ),
            const SizedBox(height: 14),

            // ✅ Checkbox with working state
            CheckboxListTile(
              value: _sendNotifications,
              onChanged: (value) {
                setState(() {
                  _sendNotifications = value ?? false;
                });
              },
              title: const Text("Send me notifications via email"),
              activeColor: CustomColors.secondary,
              contentPadding: EdgeInsets.zero,
              controlAffinity: ListTileControlAffinity.leading,
            ),
            const SizedBox(height: 8),

            AppTextField(
              label: "Country",
              hintText: "United States",
              controller: TextEditingController(),
            ),
            const SizedBox(height: 16),

            const Text(
              "Billing Address",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 10),

            AppTextField(
              label: "City",
              hintText: "City",
              controller: TextEditingController(),
            ),
            const SizedBox(height: 14),

            AppTextField(
              label: "State",
              hintText: "Select...",
              controller: TextEditingController(),
            ),
            const SizedBox(height: 14),

            AppTextField(
              label: "Zip",
              hintText: "Zip code",
              controller: TextEditingController(),
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
