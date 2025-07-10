import 'package:flutter/material.dart';
import 'package:qr_meetapp/core/constants/app_colors.dart';
import 'package:qr_meetapp/core/constants/app_styles.dart';
import 'package:qr_meetapp/core/utils/validation_utils.dart';
import 'package:qr_meetapp/core/widgets/buttons/primary_button.dart';
import 'package:qr_meetapp/core/widgets/buttons/text_button.dart';
import 'package:qr_meetapp/core/widgets/inputs/app_text_field.dart';
import 'package:qr_meetapp/features/auth/auth_view_model.dart';
import 'package:provider/provider.dart';

/// Screen for password recovery
class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Reset Password'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Illustration
              Image.asset(
                'assets/illustrations/forgot_password.png',
                height: 200,
              ),
              const SizedBox(height: 24),
              
              // Title
              Text(
                'Forgot Your Password?',
                style: AppStyles.headlineMedium.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              
              // Description
              Text(
                'Enter your email address and we\'ll send you a link to reset your password',
                style: AppStyles.bodyLarge.copyWith(color: AppColors.grey600),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              
              // Email field
              AppTextField(
                controller: _emailController,
                label: 'Email Address',
                hintText: 'your.email@example.com',
                prefixIcon: Icons.email_outlined,
                keyboardType: TextInputType.emailAddress,
                validator: ValidationUtils.validateEmail,
              ),
              const SizedBox(height: 24),
              
              // Submit button
              PrimaryButton(
                onPressed: authViewModel.isLoading
                    ? null
                    : () {
                        if (_formKey.currentState!.validate()) {
                          authViewModel.resetPassword(_emailController.text.trim());
                        }
                      },
                label: 'Send Reset Link',
              ),
              const SizedBox(height: 16),
              
              // Status message
              if (authViewModel.error != null)
                Text(
                  authViewModel.error!,
                  style: AppStyles.bodyMedium.copyWith(color: AppColors.error),
                  textAlign: TextAlign.center,
                ),
              if (authViewModel.error == null && !authViewModel.isLoading)
                const SizedBox(height: 16),
              
              // Back to login
              AppTextButton(
                onPressed: () => Navigator.pop(context),
                label: 'Back to Login',
                textColor: AppColors.primary,
                isUnderlined: true,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }
}