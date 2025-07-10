import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:qr_meetapp/core/constants/app_strings.dart';
import 'package:qr_meetapp/data/models/appointment_model.dart';
import 'package:qr_meetapp/data/models/qr_data_model.dart';
import 'package:qr_meetapp/data/models/user_model.dart';

/// Service for handling QR code operations
class QRService {
  /// Create a mobile scanner controller for QR code scanning
  MobileScannerController createScannerController() {
    return MobileScannerController();
  }
  
  /// Process barcode result from mobile scanner
  Future<QRDataModel> processBarcodeResult(BarcodeCapture capture) async {
    try {
      final barcode = capture.barcodes.first;
      
      if (barcode.rawValue == null) {
        throw Exception(AppStrings.qrScanCancelled);
      }

      return processQR(barcode.rawValue!);
    } on PlatformException catch (e) {
      throw Exception('${AppStrings.qrScanFailed}: ${e.message}');
    }
  }

  /// Generate QR code data for an appointment
  String generateAppointmentQR(AppointmentModel appointment) {
    return json.encode({
      'type': 'appointment',
      'id': appointment.id,
      'title': appointment.title,
      'host': appointment.hostId,
      'guest': appointment.guestId,
      'startTime': appointment.startTime.toIso8601String(),
      'endTime': appointment.endTime.toIso8601String(),
      'location': appointment.location,
    });
  }

  /// Generate QR code for user profile
  String generateUserQR(UserModel user) {
    return json.encode({
      'type': 'user',
      'id': user.id,
      'name': user.name,
      'email': user.email,
      'phone': user.phone,
    });
  }

  /// Validate QR code content
  bool isValidQR(String qrContent) {
    try {
      final data = json.decode(qrContent);
      return data['type'] != null && (data['type'] == 'appointment' || data['type'] == 'user');
    } catch (e) {
      return false;
    }
  }

  /// Process QR code string and return QRDataModel
  Future<QRDataModel> processQR(String rawValue) async {
    try {
      if (!isValidQR(rawValue)) {
        throw Exception('Invalid QR code format');
      }
      
      final data = json.decode(rawValue);
      return QRDataModel(
        id: data['id'] ?? '',
        type: data['type'] ?? '',
        createdAt: DateTime.now(),
        hostId: data['host'] ?? data['hostId'],
        guestId: data['guest'] ?? data['guestId'],
        meetingTime: data['startTime'] != null 
            ? DateTime.parse(data['startTime'])
            : data['meetingTime'] != null
                ? DateTime.parse(data['meetingTime'])
                : null,
        title: data['title'],
        location: data['location'],
        note: data['note'],
      );
    } catch (e) {
      throw Exception('Failed to process QR code: ${e.toString()}');
    }
  }
}