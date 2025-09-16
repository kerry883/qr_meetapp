import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:qr_meetapp/features/splash/splash_screen.dart';
import 'package:qr_meetapp/core/widgets/layout/bottom_nav_bar.dart';
import 'package:qr_meetapp/features/onboarding/onboarding_screen.dart';
import 'package:qr_meetapp/features/auth/login_screen.dart';
import 'package:qr_meetapp/features/auth/registration_screen.dart';
import 'package:qr_meetapp/features/auth/forgot_password_screen.dart';
import 'package:qr_meetapp/features/auth/otp_verification_screen.dart';
import 'package:qr_meetapp/features/home/home_screen.dart';
import 'package:qr_meetapp/features/booking/booking_screen.dart';
import 'package:qr_meetapp/features/appointments/screens/appointment_details_screen.dart';
import 'package:qr_meetapp/features/profile/profile_screen.dart';
import 'package:qr_meetapp/features/settings/settings_screen.dart';
import 'package:qr_meetapp/features/qr_scanner/qr_scanner_screen.dart';
import 'package:qr_meetapp/features/categories/category_details_screen.dart';
import 'package:qr_meetapp/features/appointments/appointments_list_screen.dart';
import 'package:qr_meetapp/features/notifications/notifications_screen.dart';

class AppRouter {
  // Top-level routes (no bottom nav)
  static const String splash = '/';
  static const String onboarding = '/onboarding';
  static const String login = '/login';
  static const String register = '/register';

  // Shell tab roots
  static const String home = '/home';
  static const String booking = '/booking';
  static const String scan = '/qr-scanner';
  static const String profile = '/profile';
  static const String settings = '/settings';

  // Use RouteBase to allow shell routes
  static final List<RouteBase> routes = [
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
      path: '/forgot-password',
      name: 'forgot-password',
      builder: (context, state) => const ForgotPasswordScreen(),
    ),
    GoRoute(
      path: '/otp-verification',
      name: 'otp-verification',
      builder: (context, state) {
        final verificationId = state.uri.queryParameters['verificationId'] ?? '';
        final phoneNumber = state.uri.queryParameters['phone'] ?? '';
        return OTPVerificationScreen(
          verificationId: verificationId,
          phoneNumber: phoneNumber,
        );
      },
    ),

    // Stateful shell with persistent bottom navigation
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return Scaffold(
          body: navigationShell,
          bottomNavigationBar: BottomNavBar(
            selectedIndex: navigationShell.currentIndex,
            onDestinationSelected: (int index) {
              navigationShell.goBranch(
                index,
                initialLocation: index == navigationShell.currentIndex,
              );
            },
          ),
        );
      },
      branches: [
        // Home branch
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: home,
              name: 'home',
              builder: (context, state) => const HomeScreen(),
              routes: [
                // Keep bottom nav while viewing appointments and notifications from Home
                GoRoute(
                  path: 'appointments',
                  name: 'appointments',
                  builder: (context, state) => const AppointmentsListScreen(),
                  routes: [
                    GoRoute(
                      path: ':id',
                      name: 'appointment-details',
                      builder: (context, state) {
                        final id = state.pathParameters['id'] ?? '';
                        return AppointmentDetailsScreen(id: id);
                      },
                    ),
                  ],
                ),
                GoRoute(
                  path: 'notifications',
                  name: 'notifications',
                  builder: (context, state) => const NotificationsScreen(),
                ),
              ],
            ),
          ],
        ),
        // Booking branch
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: booking,
              name: 'booking',
              builder: (context, state) => BookingScreen(),
            ),
            // Category details under booking so bottom nav persists
            GoRoute(
              path: '/category/:id',
              name: 'category-details',
              builder: (context, state) {
                final category = state.extra;
                if (category is! Object) {
                  return const Scaffold(body: Center(child: Text('Category not found')));
                }
                return CategoryDetailsScreen(category: category as dynamic);
              },
            ),
          ],
        ),
        // QR Scanner branch
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: scan,
              name: 'scan',
              builder: (context, state) => const QRScannerScreen(),
            ),
          ],
        ),
        // Profile branch
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: profile,
              name: 'profile',
              builder: (context, state) => const ProfileScreen(),
            ),
          ],
        ),
        // Settings branch
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: settings,
              name: 'settings',
              builder: (context, state) => const SettingsScreen(),
            ),
          ],
        ),
      ],
    ),
  ];
}

