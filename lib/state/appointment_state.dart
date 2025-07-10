import 'package:flutter/foundation.dart';
import 'package:qr_meetapp/data/models/appointment_model.dart';

/// Global state for appointment management
class AppointmentState with ChangeNotifier {
  List<AppointmentModel> _appointments = [];
  AppointmentModel? _selectedAppointment;
  bool _isLoading = false;
  String? _error;

  List<AppointmentModel> get appointments => _appointments;
  AppointmentModel? get selectedAppointment => _selectedAppointment;
  bool get isLoading => _isLoading;
  String? get error => _error;

  /// Set appointments list
  void setAppointments(List<AppointmentModel> appointments) {
    _appointments = appointments;
    notifyListeners();
  }

  /// Add new appointment
  void addAppointment(AppointmentModel appointment) {
    _appointments.add(appointment);
    notifyListeners();
  }

  /// Update existing appointment
  void updateAppointment(AppointmentModel updatedAppointment) {
    final index = _appointments.indexWhere((a) => a.id == updatedAppointment.id);
    if (index != -1) {
      _appointments[index] = updatedAppointment;
      notifyListeners();
    }
  }

  /// Delete appointment
  void removeAppointment(String appointmentId) {
    _appointments.removeWhere((a) => a.id == appointmentId);
    notifyListeners();
  }

  /// Set currently selected appointment
  void selectAppointment(AppointmentModel appointment) {
    _selectedAppointment = appointment;
    notifyListeners();
  }

  /// Clear selected appointment
  void clearSelection() {
    _selectedAppointment = null;
    notifyListeners();
  }

  /// Set loading state
  void setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  /// Set error message
  void setError(String? error) {
    _error = error;
    notifyListeners();
  }
}