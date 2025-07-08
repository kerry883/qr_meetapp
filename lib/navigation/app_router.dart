import 'package:go_router/go_router.dart';
import 'package:qr_meetapp/features/splash/splash_screen.dart';
import 'package:qr_meetapp/features/onboarding/onboarding_screen.dart';
import 'package:qr_meetapp/features/auth/login_screen.dart';
import 'package:qr_meetapp/features/auth/registration_screen.dart';
import 'package:qr_meetapp/features/home/home_screen.dart';
import 'package:qr_meetapp/features/booking/booking_screen.dart';
import 'package:qr_meetapp/features/profile/profile_screen.dart';
import 'package:qr_meetapp/features/settings/settings_screen.dart';

class AppRouter {
  static const String splash = '/';
  static const String onboarding = '/onboarding';
  static const String login = '/login';
  static const String register = '/register';
  static const String home = '/home';
  static const String booking = '/booking';
  static const String profile = '/profile';
  static const String settings = '/settings';

  static final List<GoRoute> routes = [
    GoRoute(
      path: splash,
      name: 'splash',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: onboarding,
      name: 'onboarding',
      builder: (context, state) => const OnboardingScreen(),
    ),
    GoRoute(
      path: login,
      name: 'login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: register,
      name: 'register',
      builder: (context, state) => const RegistrationScreen(),
    ),
    GoRoute(
      path: home,
      name: 'home',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: booking,
      name: 'booking',
      builder: (context, state) =>  BookingScreen(),
    ),
    GoRoute(
      path: profile,
      name: 'profile',
      builder: (context, state) => const ProfileScreen(),
    ),
    GoRoute(
      path: settings,
      name: 'settings',
      builder: (context, state) => const SettingsScreen(),
    ),
  ];
}


