import 'package:flutter/foundation.dart';
import 'package:qr_meetapp/core/services/service_locator.dart';
import 'package:qr_meetapp/data/models/appointment_model.dart';
import 'package:qr_meetapp/data/repositories/appointment_repository.dart';

/// Global state for appointment management
class AppointmentState with ChangeNotifier {
  final _repo = getIt<AppointmentRepository>();

  List<AppointmentModel> _appointments = [];
  AppointmentModel? _selectedAppointment;
  bool _isLoading = false;
  String? _error;
  String _searchQuery = '';

  List<AppointmentModel> get appointments => _appointments;
  AppointmentModel? get selectedAppointment => _selectedAppointment;
  bool get isLoading => _isLoading;
  String? get error => _error;
  String get searchQuery => _searchQuery;

  /// Load appointments for a user
  Future<void> loadAppointments(String userId) async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      final list = await _repo.getUpcomingAppointments(userId);
      _appointments = list;
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Search appointments locally (after load)
  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  List<AppointmentModel> get filteredAppointments {
    if (_searchQuery.isEmpty) return _appointments;
    return _appointments
        .where((a) => a.title.toLowerCase().contains(_searchQuery.toLowerCase()) ||
            a.description.toLowerCase().contains(_searchQuery.toLowerCase()))
        .toList();
  }

  /// Add new appointment
  Future<void> addAppointment(AppointmentModel appointment) async {
    final created = await _repo.createAppointment(appointment);
    _appointments.add(created);
    notifyListeners();
  }

  /// Update existing appointment
  Future<void> updateAppointment(AppointmentModel updatedAppointment) async {
    await _repo.updateAppointment(updatedAppointment);
    final index = _appointments.indexWhere((a) => a.id == updatedAppointment.id);
    if (index != -1) {
      _appointments[index] = updatedAppointment;
      notifyListeners();
    }
  }

  /// Cancel appointment
  Future<void> cancel(String appointmentId) async {
    await _repo.cancelAppointment(appointmentId);
    final index = _appointments.indexWhere((a) => a.id == appointmentId);
    if (index != -1) {
      _appointments[index] = _appointments[index].copyWith(status: 'cancelled');
      notifyListeners();
    }
  }

  /// Delete appointment
  Future<void> removeAppointment(String appointmentId) async {
    await _repo.deleteAppointment(appointmentId);
    _appointments.removeWhere((a) => a.id == appointmentId);
    notifyListeners();
  }

  /// Set currently selected appointment
  void selectAppointment(AppointmentModel appointment) {
    _selectedAppointment = appointment;
    notifyListeners();
  }

  /// Load and select by id
  Future<void> loadById(String id) async {
    _isLoading = true;
    notifyListeners();
    try {
      final appt = await _repo.getAppointmentById(id);
      _selectedAppointment = appt;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
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