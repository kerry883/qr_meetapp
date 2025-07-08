import 'package:flutter/material.dart';

class OnboardingViewModel extends ChangeNotifier {
  int _currentIndex = 0;
  final PageController _pageController = PageController();

  int get currentIndex => _currentIndex;
  int get currentPage => _currentIndex;
  PageController get pageController => _pageController;

  void setCurrentIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }

  void nextPage() {
    if (_currentIndex < 2) {
      _currentIndex++;
      _pageController.animateToPage(
        _currentIndex,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      notifyListeners();
    }
  }

  void previousPage() {
    if (_currentIndex > 0) {
      _currentIndex--;
      _pageController.animateToPage(
        _currentIndex,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      notifyListeners();
    }
  }

  void goToPage(int index) {
    _currentIndex = index;
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
    notifyListeners();
  }

  bool get isLastPage => _currentIndex == 2;
  bool get isFirstPage => _currentIndex == 0;

  void updateCurrentPage(int index) {
    _currentIndex = index;
    notifyListeners();
  }

  void completeOnboarding(BuildContext context) {
    // Navigate to login screen
    Navigator.of(context).pushReplacementNamed('/login');
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
