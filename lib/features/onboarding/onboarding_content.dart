import 'package:qr_meetapp/core/constants/asset_paths.dart';

class OnboardingContent {
  final String title;
  final String description;
  final String imagePath;

  OnboardingContent({
    required this.title,
    required this.description,
    required this.imagePath,
  });
}

final List<OnboardingContent> onboardingContent = [
  OnboardingContent(
    title: "Book Appointments Easily",
    description: "Schedule your meetings and appointments with just a few taps.",
    imagePath: AssetPaths.onboarding1,
  ),
  OnboardingContent(
    title: "Scan QR Codes",
    description: "Quickly scan QR codes to join meetings or book appointments.",
    imagePath: AssetPaths.onboarding2,
  ),
  OnboardingContent(
    title: "Manage Your Schedule",
    description: "Keep track of all your appointments in one place.",
    imagePath: AssetPaths.onboarding3,
  ),
];
