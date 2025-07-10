import 'package:flutter/material.dart';
import 'package:qr_meetapp/core/constants/app_colors.dart';
import 'package:qr_meetapp/core/constants/app_styles.dart';
import 'package:qr_meetapp/core/widgets/buttons/primary_button.dart';
import 'package:qr_meetapp/core/widgets/buttons/text_button.dart';
import 'package:qr_meetapp/features/auth/auth_view_model.dart';
import 'package:provider/provider.dart';

/// OTP Verification Screen
class OTPVerificationScreen extends StatefulWidget {
  final String verificationId;
  final String phoneNumber;

  const OTPVerificationScreen({
    super.key,
    required this.verificationId,
    required this.phoneNumber,
  });

  @override
  State<OTPVerificationScreen> createState() => _OTPVerificationScreenState();
}

class _OTPVerificationScreenState extends State<OTPVerificationScreen> {
  final _otpController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Verify OTP'),
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
                'assets/illustrations/otp_verification.png',
                height: 180,
              ),
              const SizedBox(height: 24),
              
              // Title
              Text(
                'Verify Your Number',
                style: AppStyles.headlineMedium.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              
              // Description
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text: 'We sent a code to ',
                  style: AppStyles.bodyLarge.copyWith(color: AppColors.grey600),
                  children: [
                    TextSpan(
                      text: widget.phoneNumber,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                    ),
                    const TextSpan(
                      text: '. Enter it below to verify.',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              
              // OTP input field
              TextFormField(
                controller: _otpController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Verification Code',
                  border: const OutlineInputBorder(),
                  prefixIcon: const Icon(Icons.sms),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () => _otpController.clear(),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the OTP';
                  } else if (value.length != 6) {
                    return 'OTP must be 6 digits';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              
              // Resend code
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Didn't receive the code? ",
                    style: AppStyles.bodyMedium,
                  ),
                  AppTextButton(
                    onPressed: () {
                      // TODO: Implement resend OTP
                    },
                    label: 'Resend',
                  ),
                ],
              ),
              const SizedBox(height: 32),
              
              // Verify button
              PrimaryButton(
                onPressed: authViewModel.isLoading
                    ? null
                    : () {
                        if (_formKey.currentState!.validate()) {
                        authViewModel.verifyOTP(_otpController.text);
                        }
                      },
                label: 'Verify Code',
              ),
              const SizedBox(height: 16),
              
              // Status message
              if (authViewModel.error != null)
                Text(
                  authViewModel.error!,
                  style: AppStyles.bodyMedium.copyWith(color: AppColors.error),
                  textAlign: TextAlign.center,
                ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _otpController.dispose();
    super.dispose();
  }
}