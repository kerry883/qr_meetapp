import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

class ConnectivityUtils with ChangeNotifier {
  bool _isConnected = true;

  bool get isConnected => _isConnected;

  ConnectivityUtils() {
    _init();
  }

  Future<void> _init() async {
    Connectivity().onConnectivityChanged.listen((result) {
      _isConnected = result != ConnectivityResult.none;
      notifyListeners();
    });
  }

  Future<void> checkConnection() async {
    final result = await Connectivity().checkConnectivity();
    _isConnected = result != ConnectivityResult.none;
    notifyListeners();
  }
}