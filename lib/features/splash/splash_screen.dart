import 'package:flutter/material.dart';

import 'package:lottie/lottie.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:qr_meetapp/core/theme/app_theme.dart';
import 'package:qr_meetapp/core/widgets/buttons/primary_button.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late Future<ConnectivityResult> _connectivityFuture;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<ConnectivityResult>(
        future: _connectivityFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return _buildLoadingState();
          }
          
          if (snapshot.hasData && snapshot.data != ConnectivityResult.none) {
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
