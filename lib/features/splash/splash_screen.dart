import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:lottie/lottie.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:qr_meetapp/core/theme/app_theme.dart';
import 'package:qr_meetapp/core/widgets/buttons/primary_button.dart';
import 'package:qr_meetapp/navigation/app_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // On newer connectivity_plus versions, checkConnectivity returns Future<List<ConnectivityResult>> on web.
  late Future<List<ConnectivityResult>> _connectivityFuture;
  Timer? _navigationTimer;

  @override
  void initState() {
    super.initState();
    _connectivityFuture = Connectivity().checkConnectivity();
  }

  Future<void> _checkConnectivity() async {
    setState(() {
      _connectivityFuture = Connectivity().checkConnectivity();
    });
  }

  void _startNavigationTimer() {
    _navigationTimer?.cancel();
    _navigationTimer = Timer(const Duration(seconds: 2), () {
      // Navigate to home screen after delay
      context.go(AppRouter.home);
    });
  }

  @override
  void dispose() {
    _navigationTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<ConnectivityResult>>(
        future: _connectivityFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return _buildLoadingState();
          }

          final results = snapshot.data ?? const [];
          final isConnected = results.any((r) => r != ConnectivityResult.none);
          if (isConnected) {
            _startNavigationTimer();
            return _buildConnectedState();
          }

          return _buildOfflineState();
        },
      ),
    );
  }

  Widget _buildLoadingState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(
            'assets/animations/loading.json',
            width: 150,
            height: 150,
          ),
          const SizedBox(height: 20),
          Text(
            'Initializing...',
            style: AppTheme.textTheme.bodyLarge,
          ),
        ],
      ),
    );
  }

  Widget _buildConnectedState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/images/logo.png', width: 150),
          const SizedBox(height: 30),
          Lottie.asset(
            'assets/animations/loading.json',
            width: 80,
            height: 80,
          ),
        ],
      ),
    );
  }

  Widget _buildOfflineState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
              'assets/animations/no_internet.json',
              width: 200,
              height: 200,
            ),
            const SizedBox(height: 20),
            Text(
              'Connection Required',
              style: AppTheme.textTheme.displaySmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            Text(
              'Please connect to the internet to use QR_MeetApp',
              style: AppTheme.textTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            PrimaryButton(
              onPressed: _checkConnectivity,
              label: 'Retry Connection',
            ),
          ],
        ),
      ),
    );
  }
}
