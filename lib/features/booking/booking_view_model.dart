import 'package:flutter/foundation.dart';
import 'package:qr_meetapp/data/models/appointment_model.dart';
import 'package:qr_meetapp/data/repositories/appointment_repository.dart';

/// Booking ViewModel
class BookingViewModel with ChangeNotifier {
  final AppointmentRepository repository;

  BookingViewModel(this.repository);

  bool _isLoading = false;
  Appointment? _lastCreatedAppointment;
  String? _error;

  bool get isLoading => _isLoading;
  Appointment? get lastCreatedAppointment => _lastCreatedAppointment;
  String? get error => _error;

  /// Create a new appointment
  Future<void> createAppointment(Appointment appointment) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _lastCreatedAppointment = await repository.createAppointment(appointment);
      _error = null;
    } catch (e) {
      _lastCreatedAppointment = null;
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Update an existing appointment
  Future<void> updateAppointment(Appointment appointment) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      await repository.updateAppointment(appointment);
      _error = null;
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Cancel an appointment
  Future<void> cancelAppointment(String appointmentId) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      await repository.cancelAppointment(appointmentId);
      _error = null;
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}