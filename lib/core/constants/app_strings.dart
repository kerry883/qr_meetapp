/// Centralized string resources for the app
/// Allows easy updates and localization
class AppStrings {
  // Authentication
  static const String appName = 'QR MeetApp';
  static const String welcomeBack = 'Welcome Back!';
  static const String loginToContinue = 'Login to continue your meeting journey';
  static const String emailHint = 'Enter your email';
  static const String passwordHint = 'Enter your password';
  static const String forgotPassword = 'Forgot Password?';
  static const String login = 'Login';
  static const String noAccount = "Don't have an account? ";
  static const String signUp = 'Sign Up';

  // Common
  static const String cancel = 'Cancel';
  static const String confirm = 'Confirm';
  static const String next = 'Next';
  static const String back = 'Back';
  static const String save = 'Save';
  static const String search = 'Search';
  static const String loading = 'Loading...';
  static const String retry = 'Retry';
  static const String success = 'Success!';
  static const String error = 'Error';
  static const String noInternet = 'No internet connection';

  // Validation
  static const String invalidEmail = 'Please enter a valid email';
  static const String emptyField = 'This field cannot be empty';
  static const String passwordTooShort = 'Password must be at least 8 characters';
  static const String passwordsDontMatch = 'Passwords do not match';

  // Date/Time
  static const String today = 'Today';
  static const String tomorrow = 'Tomorrow';
  static const String thisWeek = 'This Week';
  static const String selectDate = 'Select Date';
  static const String selectTime = 'Select Time';

  // API Error Messages
  static const String invalidRequest = 'Invalid request';
  static const String unauthorized = 'Unauthorized access';
  static const String forbidden = 'Access forbidden';
  static const String resourceNotFound = 'Resource not found';
  static const String serverError = 'Server error';
  static const String unknownError = 'Unknown error occurred';

  // QR Code Messages
  static const String qrScanCancelled = 'QR code scan was cancelled';
  static const String qrScanFailed = 'Failed to scan QR code';

  // Add more strings as needed, organized by feature
}