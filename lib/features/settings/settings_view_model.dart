import 'package:flutter/material.dart';
import 'package:qr_meetapp/data/repositories/settings_repository.dart';

/// ViewModel for settings management
class SettingsViewModel with ChangeNotifier {
  final SettingsRepository repository;

  SettingsViewModel(this.repository);

  bool _isLoading = false;
  ThemeMode _themeMode = ThemeMode.system;
  bool _notificationsEnabled = true;
  String? _error;

  bool get isLoading => _isLoading;
  ThemeMode get themeMode => _themeMode;
  bool get notificationsEnabled => _notificationsEnabled;
  String? get error => _error;

  /// Load settings from persistent storage
  Future<void> loadSettings() async {
    _isLoading = true;
    notifyListeners();

    try {
      final themeString = await repository.getThemeMode();
      _themeMode = _stringToThemeMode(themeString);
      _notificationsEnabled = await repository.getNotificationStatus();
      _error = null;
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Update theme mode
  Future<void> updateThemeMode(ThemeMode mode) async {
    _themeMode = mode;
    notifyListeners();
    
    try {
      await repository.saveThemeMode(_themeModeToString(mode));
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }

  /// Toggle notification status
  Future<void> toggleNotifications(bool enabled) async {
    _notificationsEnabled = enabled;
    notifyListeners();
    
    try {
      await repository.saveNotificationStatus(enabled);
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }

  /// Convert string to ThemeMode
  ThemeMode _stringToThemeMode(String themeString) {
    switch (themeString) {
      case 'dark':
        return ThemeMode.dark;
      case 'light':
        return ThemeMode.light;
      case 'system':
      default:
        return ThemeMode.system;
    }
  }

  /// Convert ThemeMode to string
  String _themeModeToString(ThemeMode mode) {
    switch (mode) {
      case ThemeMode.dark:
        return 'dark';
      case ThemeMode.light:
        return 'light';
      case ThemeMode.system:
        return 'system';
    }
  }
}