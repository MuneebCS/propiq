import 'package:flutter/material.dart';
import '../../core/AppTheme/AppColors.dart';
import '../../core/utils/device_utils.dart';
import '../../widgets/AppButton.dart';
import '../../widgets/AppTextField.dart';

class SignupView extends StatefulWidget {
  const SignupView({super.key});

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController agentIdController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  bool acceptTerms = false;
  bool isPasswordVisible = false;
  bool isConfirmPasswordVisible = false;

  bool get isFormValid =>
      firstNameController.text.isNotEmpty &&
          lastNameController.text.isNotEmpty &&
          agentIdController.text.isNotEmpty &&
          emailController.text.isNotEmpty &&
          phoneController.text.isNotEmpty &&
          passwordController.text.isNotEmpty &&
          confirmPasswordController.text.isNotEmpty &&
          acceptTerms;

  @override
  Widget build(BuildContext context) {
    final bool tablet = isTablet(context);
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: EdgeInsets.only(
                left: tablet ? 48 : 24,
                right: tablet ? 48 : 24,
                top: tablet ? 60 : 40,
                bottom: MediaQuery.of(context).viewInsets.bottom + 24,
              ),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Logo
                      Image.asset(
                        'lib/assets/images/logo.png',
                        height: tablet ? 140 : 116,
                        width: tablet ? 300 : 221,
                        fit: BoxFit.contain,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Create Your Account',
                        style: textTheme.titleMedium?.copyWith(
                          color: Colors.black87,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Fill out the information below to create your account.',
                        style: textTheme.bodyMedium?.copyWith(color: Colors.black54),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 32),

                      AppTextField(
                        label: 'First Name *',
                        hintText: 'John',
                        controller: firstNameController,
                      ),
                      const SizedBox(height: 20),

                      AppTextField(
                        label: 'Last Name *',
                        hintText: 'Doe',
                        controller: lastNameController,
                      ),
                      const SizedBox(height: 20),

                      AppTextField(
                        label: 'Agent ID or Investor LLC *',
                        hintText: 'Agent007 / XYZ LLC',
                        controller: agentIdController,
                      ),
                      const SizedBox(height: 20),

                      AppTextField(
                        label: 'Email *',
                        hintText: 'example@domain.com',
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                      ),
                      const SizedBox(height: 20),

                      AppTextField(
                        label: 'Phone Number *',
                        hintText: '123-456-7890',
                        controller: phoneController,
                        keyboardType: TextInputType.phone,
                      ),
                      const SizedBox(height: 20),

                      AppTextField(
                        label: 'Password *',
                        hintText: 'Enter password',
                        controller: passwordController,
                        obscureText: !isPasswordVisible,
                        suffixIcon: IconButton(
                          icon: Icon(
                            isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                            color: Colors.grey,
                          ),
                          onPressed: () {
                            setState(() {
                              isPasswordVisible = !isPasswordVisible;
                            });
                          },
                        ),
                      ),
                      const SizedBox(height: 20),

                      AppTextField(
                        label: 'Confirm Password *',
                        hintText: 'Re-enter password',
                        controller: confirmPasswordController,
                        obscureText: !isConfirmPasswordVisible,
                        suffixIcon: IconButton(
                          icon: Icon(
                            isConfirmPasswordVisible ? Icons.visibility : Icons.visibility_off,
                            color: Colors.grey,
                          ),
                          onPressed: () {
                            setState(() {
                              isConfirmPasswordVisible = !isConfirmPasswordVisible;
                            });
                          },
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Accept Terms
                      Row(
                        children: [
                          Checkbox(
                            value: acceptTerms,
                            onChanged: (val) {
                              setState(() {
                                acceptTerms = val ?? false;
                              });
                            },
                            activeColor: CustomColors.secondary,
                          ),
                          Expanded(
                            child: Text(
                              'I accept Terms and Conditions',
                              style: const TextStyle(fontSize: 14),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),

                      // Create Account Button
                      AppButton(
                        text: 'CREATE ACCOUNT',
                        onPressed: isFormValid ? () {
                          // TODO: handle account creation logic
                        } : null,
                      ),
                      const SizedBox(height: 16),

                      // Already have account
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Already have an account? "),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, '/login');
                            },
                            child: const Text(
                              'Login',
                              style: TextStyle(
                                color: CustomColors.secondary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),

                        ],
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

