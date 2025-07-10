import 'package:shared_preferences/shared_preferences.dart';

/// Handles persistent storage of user settings
class SettingsRepository {
  static const _themeModeKey = 'theme_mode';
  static const _languageKey = 'language_code';
  static const _notificationsKey = 'notifications_enabled';
  static const _firstLaunchKey = 'first_launch';

  final SharedPreferences _prefs;

  SettingsRepository(this._prefs);

  /// Gets the saved theme mode
  /// Returns 'system' if no value is set
  Future<String> getThemeMode() async {
    return _prefs.getString(_themeModeKey) ?? 'system';
  }

  /// Saves the selected theme mode
  Future<void> saveThemeMode(String mode) async {
    await _prefs.setString(_themeModeKey, mode);
  }

  /// Gets the saved language code
  /// Returns 'en' if no value is set
  Future<String> getLanguageCode() async {
    return _prefs.getString(_languageKey) ?? 'en';
  }

  /// Saves the selected language code
  Future<void> saveLanguageCode(String languageCode) async {
    await _prefs.setString(_languageKey, languageCode);
  }

  /// Checks if notifications are enabled
  /// Returns true by default
  Future<bool> getNotificationsEnabled() async {
    return _prefs.getBool(_notificationsKey) ?? true;
  }

  /// Saves the notification preference
  Future<void> setNotificationsEnabled(bool enabled) async {
    await _prefs.setBool(_notificationsKey, enabled);
  }

  /// Alias for getNotificationsEnabled
  Future<bool> getNotificationStatus() async {
    return getNotificationsEnabled();
  }

  /// Alias for setNotificationsEnabled
  Future<void> saveNotificationStatus(bool enabled) async {
    await setNotificationsEnabled(enabled);
  }

  /// Checks if this is the first app launch
  Future<bool> isFirstLaunch() async {
    return _prefs.getBool(_firstLaunchKey) ?? true;
  }

  /// Marks the app as launched (after onboarding)
  Future<void> setAppLaunched() async {
    await _prefs.setBool(_firstLaunchKey, false);
  }
}