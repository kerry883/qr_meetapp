import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app.dart';
import 'core/services/service_locator.dart';
import 'state/theme_state.dart';
import 'state/auth_state.dart';
import 'state/appointment_state.dart';
import 'state/notifications_state.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Setup service locator (synchronous)
  setupServiceLocator();

  // Check auth status
  final authState = AuthState();
  await authState.checkAuthStatus();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeState()),
        ChangeNotifierProvider.value(value: authState),
        ChangeNotifierProvider(create: (_) => AppointmentState()),
        ChangeNotifierProvider(create: (_) => NotificationsState()),
      ],
      child: MyApp(),
    ),
  );
}
