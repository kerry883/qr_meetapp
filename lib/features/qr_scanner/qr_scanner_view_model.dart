import 'package:flutter/foundation.dart';
import 'package:qr_meetapp/data/models/qr_data_model.dart';
import 'package:qr_meetapp/data/services/qr_service.dart';

/// ViewModel for QR scanner operations
class QRScannerViewModel with ChangeNotifier {
  final QRService qrService;

  QRScannerViewModel(this.qrService);

  bool _isScanning = true;
  bool _isProcessing = false;
  QRDataModel? _lastScannedData;
  String? _error;

  bool get isScanning => _isScanning;
  bool get isProcessing => _isProcessing;
  QRDataModel? get lastScannedData => _lastScannedData;
  String? get error => _error;

  /// Process scanned QR content
  Future<void> processQR(String rawValue) async {
    _isScanning = false;
    _isProcessing = true;
    _error = null;
    notifyListeners();

    try {
      _lastScannedData = await qrService.processQR(rawValue);
      _error = null;
    } catch (e) {
      _lastScannedData = null;
      _error = e.toString();
    } finally {
      _isProcessing = false;
      notifyListeners();
    }
  }

  /// Reset scanner state
  void resetScanner() {
    _isScanning = true;
    _isProcessing = false;
    _lastScannedData = null;
    _error = null;
    notifyListeners();
  }
}