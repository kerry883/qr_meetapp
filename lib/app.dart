import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'core/theme/app_theme.dart';
import 'navigation/app_router.dart';
import 'state/theme_state.dart';

class MyApp extends StatelessWidget {
   MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<ThemeState>(context);
    
    return MaterialApp.router(
      title: 'QRMeetApp',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeState.themeMode,
      routerConfig: _router,
    );
  }

  final GoRouter _router = GoRouter(
    routes: AppRouter.routes,
    initialLocation: AppRouter.splash,
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Text('Page not found!', style: AppTheme.textTheme.headlineMedium),
      ),
    ),
  );
}
