/// Centralized route names for navigation
/// Prevents route name typos and provides single source of truth
abstract class RouteNames {
  // Auth routes
  static const splash = '/';
  static const onboarding = '/onboarding';
  static const login = '/login';
  static const registration = '/registration';
  static const forgotPassword = '/forgot-password';
  static const otpVerification = '/otp-verification';

  // Main app routes
  static const home = '/home';
  static const booking = '/booking';
  static const bookingForm = '/booking-form';
  static const bookingConfirmation = '/booking-confirmation';
  static const hostAcceptance = '/host-acceptance';
  static const qrScanner = '/qr-scanner';
  static const qrResult = '/qr-result';
  static const profile = '/profile';
  static const editProfile = '/edit-profile';
  static const settings = '/settings';

  // Appointment routes
  static const appointmentDetails = '/appointment-details';
  static const appointmentList = '/appointments';

  // Utility method to generate route names with parameters
  static String appointmentDetailsRoute(String appointmentId) => 
      '$appointmentDetails/$appointmentId';
}