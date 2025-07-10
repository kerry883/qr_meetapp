import 'package:flutter/foundation.dart';
import 'package:qr_meetapp/data/models/user_model.dart';
import 'package:qr_meetapp/data/repositories/profile_repository.dart';

/// ViewModel for profile management
class ProfileViewModel with ChangeNotifier {
  final ProfileRepository repository;

  ProfileViewModel(this.repository);

  UserModel? _currentUser;
  bool _isLoading = false;
  String? _error;
  String? _currentUserId;

  UserModel? get currentUser => _currentUser;
  bool get isLoading => _isLoading;
  String? get error => _error;

  /// Set current user ID
  void setUserId(String userId) {
    _currentUserId = userId;
  }

  /// Load user profile
  Future<void> loadProfile() async {
    if (_currentUserId == null) return;
    
    _isLoading = true;
    notifyListeners();

    try {
      _currentUser = await repository.getUserProfile(_currentUserId!);
      _error = null;
    } catch (e) {
      _currentUser = null;
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Update user profile
  Future<void> updateProfile(UserModel user) async {
    _isLoading = true;
    notifyListeners();

    try {
      await repository.updateProfile(user);
      _currentUser = user;
      _error = null;
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Change user password
  Future<void> changePassword(
    String currentPassword, 
    String newPassword
  ) async {
    _isLoading = true;
    notifyListeners();

    try {
      await repository.changePassword(currentPassword, newPassword);
      _error = null;
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Delete user account
  Future<void> deleteAccount() async {
    if (_currentUserId == null) return;
    
    _isLoading = true;
    notifyListeners();

    try {
      await repository.deleteAccount(_currentUserId!);
      _currentUser = null;
      _error = null;
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}