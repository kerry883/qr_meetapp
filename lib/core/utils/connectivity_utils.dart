import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

class ConnectivityUtils with ChangeNotifier {
  bool _isConnected = true;

  bool get isConnected => _isConnected;

  ConnectivityUtils() {
    _init();
  }

  Future<void> _init() async {
    Connectivity().onConnectivityChanged.listen((List<ConnectivityResult> results) {
      _isConnected = !results.contains(ConnectivityResult.none);
      notifyListeners();
    });
  }

  Future<void> checkConnection() async {
    final List<ConnectivityResult> results = await Connectivity().checkConnectivity();
    _isConnected = !results.contains(ConnectivityResult.none);
    notifyListeners();
  }
}