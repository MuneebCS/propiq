import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:propiq/core/AppTheme/AppColors.dart';
import '../../../widgets/AppTextField.dart';
import '../../../widgets/AppButton.dart';

class NameAndProfileSection extends StatefulWidget {
  const NameAndProfileSection({super.key});

  @override
  State<NameAndProfileSection> createState() => _NameAndProfileSectionState();
}

class _NameAndProfileSectionState extends State<NameAndProfileSection> {
  File? _profileImage;
  DateTime? _selectedBirthday;

  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _birthdayController = TextEditingController();

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        _profileImage = File(image.path);
      });
    }
  }

  Future<void> _pickBirthday() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: DateTime(1900),
      lastDate: now,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: CustomColors.primary,
              onPrimary: Colors.white,
              onSurface: Colors.black87,
              secondary: CustomColors.secondary,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: CustomColors.secondary,
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        _selectedBirthday = picked;
        _birthdayController.text =
        "${picked.month}/${picked.day}/${picked.year}";
      });
    }
  }



  void _removeImage() {
    setState(() {
      _profileImage = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: CustomColors.primary,
      margin: const EdgeInsets.symmetric(vertical: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "Name and Profile",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),

            // Profile Avatar
            Center(
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.grey.shade200,
                    backgroundImage:
                    _profileImage != null ? FileImage(_profileImage!) : null,
                    child: _profileImage == null
                        ? const Icon(Icons.person, size: 50, color: Colors.grey)
                        : null,
                  ),
                  Positioned(
                    bottom: 0,
                    right: 4,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 4,
                          )
                        ],
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.edit, size: 20),
                        onPressed: _pickImage,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Upload/Remove buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 130,
                  child: AppButton(
                    text: "UPLOAD",
                    onPressed: _pickImage,
                    isPrimary: true,
                    height: 40,
                  ),
                ),
                const SizedBox(width: 12),
                SizedBox(
                  width: 130,
                  child: AppButton(
                    text: "Remove",
                    onPressed: _removeImage,
                    isPrimary: false,
                    height: 40,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            AppTextField(
              label: "First Name *",
              hintText: "Enter first name",
              controller: _firstNameController,
            ),
            const SizedBox(height: 16),

            AppTextField(
              label: "Last Name *",
              hintText: "Enter last name",
              controller: _lastNameController,
            ),
            const SizedBox(height: 16),

            // Birthday calendar picker
            GestureDetector(
              onTap: _pickBirthday,
              child: AbsorbPointer(
                child: AppTextField(
                  label: "Birthday",
                  hintText: "mm/dd/yyyy",
                  controller: _birthdayController,
                ),
              ),
            ),
            const SizedBox(height: 24),

            Row(
              children: [
                Expanded(
                  child: AppButton(
                    text: "Save",
                    onPressed: () {},
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: AppButton(
                    text: "Cancel",
                    isPrimary: false,
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
