import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

/// Provides and monitors network connectivity status
class ConnectivityProvider extends ChangeNotifier {
  bool _isConnected = true;

  bool get isConnected => _isConnected;

  ConnectivityProvider() {
    _init();
  }

  Future<void> _init() async {
    // Check initial connectivity
    var result = await Connectivity().checkConnectivity();
    _updateStatus(result);
    
    // Listen for connectivity changes
    Connectivity().onConnectivityChanged.listen(_updateStatus);
  }

  void _updateStatus(ConnectivityResult result) {
    final newStatus = result != ConnectivityResult.none;
    if (newStatus != _isConnected) {
      _isConnected = newStatus;
      notifyListeners();
    }
  }

  /// Manually check connectivity status
  Future<void> checkConnection() async {
    final result = await Connectivity().checkConnectivity();
    _updateStatus(result);
  }
}

/// Visual indicator for connectivity status
class ConnectivityIndicator extends StatelessWidget {
  const ConnectivityIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    final connectivity = Provider.of<ConnectivityProvider>(context);
    
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: connectivity.isConnected 
        ? const SizedBox.shrink()
        : Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            color: Colors.red,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.wifi_off, color: Colors.white, size: 20),
                const SizedBox(width: 8),
                const Text(
                  'No internet connection',
                  style: TextStyle(color: Colors.white),
                ),
                const SizedBox(width: 16),
                TextButton(
                  onPressed: connectivity.checkConnection,
                  child: const Text(
                    'RETRY',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
    );
  }
}