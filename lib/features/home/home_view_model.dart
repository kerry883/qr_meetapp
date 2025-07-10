import 'package:flutter/foundation.dart';
import 'package:qr_meetapp/data/models/appointment_model.dart';
import 'package:qr_meetapp/data/models/appointment_category.dart';
import 'package:qr_meetapp/data/repositories/appointment_repository.dart';

/// ViewModel for home screen state management
class HomeViewModel with ChangeNotifier {
  final AppointmentRepository repository;

  HomeViewModel(this.repository);

  List<AppointmentModel> _upcomingAppointments = [];
  List<AppointmentModel> _pastAppointments = [];
  List<AppointmentCategory> _categories = [];
  bool _isLoading = false;
  String? _error;
  String? _currentUserId;

  List<AppointmentModel> get upcomingAppointments => _upcomingAppointments;
  List<AppointmentModel> get pastAppointments => _pastAppointments;
  List<AppointmentCategory> get categories => _categories;
  bool get isLoading => _isLoading;
  String? get error => _error;

  /// Set current user ID
  void setUserId(String userId) {
    _currentUserId = userId;
  }

  /// Load initial home data
  Future<void> loadHomeData() async {
    if (_currentUserId == null) return;
    
    _isLoading = true;
    notifyListeners();

    try {
      // Fetch appointments using repository methods
      final upcomingAppointments = await repository.getUpcomingAppointments(_currentUserId!);
      final pastAppointments = await repository.getPastAppointments(_currentUserId!);
      
      _upcomingAppointments = upcomingAppointments;
      _pastAppointments = pastAppointments;
      
      // Fetch categories
      _categories = AppointmentCategory.getDefaultCategories();
      
      _error = null;
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Refresh home data
  Future<void> refreshData() async {
    _isLoading = true;
    notifyListeners();
    
    await loadHomeData();
  }

  /// Search appointments by title
  List<AppointmentModel> searchAppointments(String query) {
    if (query.isEmpty) return [];
    
    final searchLower = query.toLowerCase();
    return [..._upcomingAppointments, ..._pastAppointments]
        .where((appointment) => 
            appointment.title.toLowerCase().contains(searchLower) ||
            appointment.description.toLowerCase().contains(searchLower))
        .toList();
  }

  /// Get appointments for a specific category
  List<AppointmentModel> getAppointmentsByCategory(String categoryId) {
    return [..._upcomingAppointments, ..._pastAppointments]
        .where((appointment) => appointment.categoryId == categoryId)
        .toList();
  }
}