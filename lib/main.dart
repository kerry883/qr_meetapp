import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app.dart';
import 'core/services/service_locator.dart';
import 'state/theme_state.dart';
import 'state/auth_state.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  
  // Setup service locator
  await setupServiceLocator();
  
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeState()),
        ChangeNotifierProvider(create: (_) => AuthState()),
      ],
      child: MyApp(),
    ),
  );
}
