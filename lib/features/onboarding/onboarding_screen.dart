import 'package:flutter/material.dart';
import 'package:qr_meetapp/core/constants/app_colors.dart';
import 'package:qr_meetapp/core/constants/app_styles.dart';

import 'package:qr_meetapp/core/widgets/buttons/primary_button.dart';
import 'package:qr_meetapp/core/widgets/buttons/text_button.dart';
import 'package:qr_meetapp/features/onboarding/onboarding_content.dart';
import 'package:qr_meetapp/features/onboarding/onboarding_view_model.dart';
import 'package:provider/provider.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => OnboardingViewModel(),
      child: const _OnboardingScreenContent(),
    );
  }
}

class _OnboardingScreenContent extends StatelessWidget {
  const _OnboardingScreenContent();

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<OnboardingViewModel>(context);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Skip button
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: AppTextButton(
                  onPressed: () => viewModel.completeOnboarding(context),
                  label: 'Skip',
                ),
              ),
            ),

            // Content
            Expanded(
              child: PageView.builder(
                itemCount: onboardingContent.length,
                controller: viewModel.pageController,
                onPageChanged: viewModel.updateCurrentPage,
                itemBuilder: (context, index) {
                  final content = onboardingContent[index];
                  return Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Illustration
                        Image.asset(
                          content.imagePath,
                          height: 250,
                        ),
                        const SizedBox(height: 40),
                        // Title
                        Text(
                          content.title,
                          style: AppStyles.headlineMedium.copyWith(
                            fontWeight: FontWeight.bold,
                            color: AppColors.grey900,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),
                        // Description
                        Text(
                          content.description,
                          style: AppStyles.bodyLarge.copyWith(
                            color: AppColors.grey600,
                            height: 1.5,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            // Page indicator and next button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24.0),
              child: Row(
                children: [
                  // Page indicator
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      onboardingContent.length,
                      (index) => Container(
                        width: 8,
                        height: 8,
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: viewModel.currentPage == index
                              ? AppColors.primary
                              : AppColors.grey300,
                        ),
                      ),
                    ),
                  ),
                  const Spacer(),
                  // Next button
                  PrimaryButton(
                    onPressed: () {
                      if (viewModel.currentPage == onboardingContent.length - 1) {
                        viewModel.completeOnboarding(context);
                      } else {
                        viewModel.nextPage();
                      }
                    },
                    label: viewModel.currentPage == onboardingContent.length - 1
                        ? 'Get Started'
                        : 'Next',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
