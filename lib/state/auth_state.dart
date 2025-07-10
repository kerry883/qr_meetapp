import 'package:flutter/material.dart';
import 'package:qr_meetapp/data/models/user_model.dart';

class AuthState extends ChangeNotifier {
  UserModel? _currentUser;
  bool _isLoading = false;
  String? _error;

  UserModel? get currentUser => _currentUser;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> login(String email, String password) async {
    try {
      _isLoading = true;
      notifyListeners();
      
      // Authentication logic here
      
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }
  
  void logout() {
    _currentUser = null;
    notifyListeners();
  }
}
