import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:qr_meetapp/data/repositories/auth_repository.dart';

/// ViewModel for splash screen operations
class SplashViewModel with ChangeNotifier {
  final AuthRepository authRepository;

  SplashViewModel(this.authRepository);

  bool _isLoading = true;
  bool _isAuthenticated = false;
  bool _shouldShowOnboarding = true;
  String? _error;

  bool get isLoading => _isLoading;
  bool get isAuthenticated => _isAuthenticated;
  bool get shouldShowOnboarding => _shouldShowOnboarding;
  String? get error => _error;

  /// Initialize splash screen operations
  Future<void> initialize() async {
    try {
      // Check onboarding status
      _shouldShowOnboarding = await authRepository.checkOnboardingStatus();
      
      // Check authentication
      _isAuthenticated = await authRepository.isAuthenticated();
      
      _error = null;
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Complete onboarding flow
  Future<void> completeOnboarding() async {
    await authRepository.setOnboardingComplete();
    _shouldShowOnboarding = false;
    notifyListeners();
  }
}