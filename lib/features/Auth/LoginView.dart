import 'package:flutter/material.dart';
import '../../core/AppTheme/AppColors.dart';
import '../../core/utils/device_utils.dart';
import '../../widgets/AppButton.dart';
import '../../widgets/AppTextField.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool rememberMe = false;
  bool isPasswordVisible = false;
  bool isFormValid = false;

  String? emailError;
  String? passwordError;
  String? generalError;

  @override
  void initState() {
    super.initState();
    emailController.addListener(_updateButtonState);
    passwordController.addListener(_updateButtonState);
  }

  void _updateButtonState() {
    setState(() {
      isFormValid = emailController.text.trim().isNotEmpty &&
          passwordController.text.trim().isNotEmpty;
    });
  }

  void _validateAndLogin() {
    setState(() {
      emailError = null;
      passwordError = null;
      generalError = null;
    });

    final email = emailController.text.trim();
    final password = passwordController.text;

    bool hasError = false;

    if (email.isEmpty) {
      emailError = 'Email is required';
      hasError = true;
    }
    if (password.isEmpty) {
      passwordError = 'Password is required';
      hasError = true;
    }

    if (hasError) {
      setState(() {});
      return;
    }

    // Skip credential check – allow any email/password
    Navigator.pushReplacementNamed(context, '/dashboard');
  }


  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final bool tablet = isTablet(context);

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
                      Image.asset(
                        'lib/assets/images/logo.png',
                        height: tablet ? 140 : 116,
                        width: tablet ? 300 : 221,
                        fit: BoxFit.contain,
                      ),
                      const SizedBox(height: 24),
                      Text(
                        'PropIQ',
                        style: textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: CustomColors.primary,
                          letterSpacing: 1.2,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Login to Your Account',
                        style: textTheme.titleMedium?.copyWith(
                          color: Colors.black87,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Enter your credentials to access your account.',
                        style: textTheme.bodyMedium?.copyWith(color: Colors.black54),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 24),

                      // 🔴 General Error
                      if (generalError != null)
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 16),
                          margin: const EdgeInsets.only(bottom: 16),
                          decoration: BoxDecoration(
                            color: Colors.red.shade50,
                            border: Border.all(color: Colors.red.shade300),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.error_outline, color: Colors.red),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  generalError!,
                                  style: const TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                      AppTextField(
                        label: 'Email *',
                        hintText: 'example@domain.com',
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        errorText: emailError,
                      ),
                      const SizedBox(height: 20),
                      AppTextField(
                        label: 'Password *',
                        hintText: 'Enter your password',
                        controller: passwordController,
                        obscureText: !isPasswordVisible,
                        errorText: passwordError,
                        suffixIcon: IconButton(
                          icon: Icon(
                            isPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Colors.grey,
                          ),
                          onPressed: () {
                            setState(() {
                              isPasswordVisible = !isPasswordVisible;
                            });
                          },
                        ),
                      ),
                      const SizedBox(height: 12),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Checkbox(
                                value: rememberMe,
                                onChanged: (val) {
                                  setState(() {
                                    rememberMe = val ?? false;
                                  });
                                },
                                activeColor: CustomColors.secondary,
                              ),
                              const Text('Remember me', style: TextStyle(fontSize: 14)),
                            ],
                          ),
                          TextButton(
                            onPressed: () {
                              // TODO: Forgot password
                            },
                            child: const Text(
                              'Forgot Password?',
                              style: TextStyle(
                                fontSize: 14,
                                color: CustomColors.secondary,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),

                      AppButton(
                        text: 'LOGIN',
                        onPressed: isFormValid ? _validateAndLogin : null,
                      ),
                      const SizedBox(height: 16),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Don't have an account? "),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, '/pricing');
                            },
                            child: const Text(
                              'Create Account',
                              style: TextStyle(
                                color: CustomColors.secondary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 32),

                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            '/home',
                                (route) => false,
                          );
                        },
                        child: const Text(
                          'Back to home',
                          style: TextStyle(
                            color: CustomColors.secondary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
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
