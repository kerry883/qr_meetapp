import 'package:flutter/foundation.dart';
import 'package:qr_meetapp/data/models/user_model.dart';
import 'package:qr_meetapp/data/repositories/auth_repository.dart';

/// ViewModel for authentication state management
class AuthViewModel with ChangeNotifier {
  final AuthRepository repository;

  AuthViewModel(this.repository);

  UserModel? _currentUser;
  bool _isLoading = false;
  bool _isAuthenticated = false;
  String? _error;

  UserModel? get currentUser => _currentUser;
  bool get isLoading => _isLoading;
  bool get isAuthenticated => _isAuthenticated;
  String? get error => _error;

  /// Check if user is already authenticated
  Future<void> checkAuthStatus() async {
    _isLoading = true;
    notifyListeners();

    try {
      _isAuthenticated = await repository.isAuthenticated();
      if (_isAuthenticated) {
        // Get current user from repository if authenticated
        final currentUser = repository.currentUser;
        if (currentUser != null) {
          _currentUser = UserModel(
            id: currentUser.uid,
            name: currentUser.displayName ?? '',
            email: currentUser.email ?? '',
            createdAt: DateTime.now(),
          );
        }
      }
      _error = null;
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Login with email and password
  Future<void> login(String email, String password) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _currentUser = await repository.login(email, password);
      _isAuthenticated = true;
      _error = null;
    } catch (e) {
      _currentUser = null;
      _isAuthenticated = false;
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Register a new user
  Future<void> register(String email, String password, String name) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _currentUser = await repository.register(email, password, name);
      _isAuthenticated = true;
      _error = null;
    } catch (e) {
      _currentUser = null;
      _isAuthenticated = false;
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Logout current user
  Future<void> logout() async {
    _isLoading = true;
    notifyListeners();

    try {
      await repository.logout();
      _currentUser = null;
      _isAuthenticated = false;
      _error = null;
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Send password reset email
  Future<void> resetPassword(String email) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      await repository.resetPassword(email);
      _error = null;
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  

  /// Verify OTP code (placeholder implementation)
  Future<void> verifyOTP(String otpCode) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      // OTP verification logic would go here
      // For now, just simulate success
      await Future.delayed(const Duration(seconds: 2));
      _error = null;
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Resend OTP to the provided phone number
  Future<void> resendOTP(String phoneNumber) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      await repository.resendOTP(phoneNumber);
      _error = null;
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}