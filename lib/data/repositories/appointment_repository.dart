import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:qr_meetapp/data/models/appointment_model.dart';

class AppointmentRepository {
  final FirebaseFirestore _firestore;

  AppointmentRepository({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  CollectionReference get _appointmentsCollection =>
      _firestore.collection('appointments');

  /// Get user appointments as a stream
  Stream<List<AppointmentModel>> getUserAppointments(String userId) {
    return _appointmentsCollection
        .where('hostId', isEqualTo: userId)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => AppointmentModel.fromMap(doc.data() as Map<String, dynamic>))
            .toList());
  }

  /// Create a new appointment
  Future<AppointmentModel> createAppointment(AppointmentModel appointment) async {
    try {
      final docRef = await _appointmentsCollection.add(appointment.toMap());
      final updatedAppointment = appointment.copyWith(id: docRef.id);
      await docRef.update({'id': docRef.id});
      return updatedAppointment;
    } catch (e) {
      throw Exception('Failed to create appointment: $e');
    }
  }

  /// Update an existing appointment
  Future<void> updateAppointment(AppointmentModel appointment) async {
    try {
      await _appointmentsCollection.doc(appointment.id).update(appointment.toMap());
    } catch (e) {
      throw Exception('Failed to update appointment: $e');
    }
  }

  /// Delete an appointment
  Future<void> deleteAppointment(String appointmentId) async {
    try {
      await _appointmentsCollection.doc(appointmentId).delete();
    } catch (e) {
      throw Exception('Failed to delete appointment: $e');
    }
  }

  /// Cancel an appointment
  Future<void> cancelAppointment(String appointmentId) async {
    try {
      await _appointmentsCollection.doc(appointmentId).update({
        'status': 'cancelled',
        'updatedAt': DateTime.now().toIso8601String(),
      });
    } catch (e) {
      throw Exception('Failed to cancel appointment: $e');
    }
  }

  /// Get appointment by ID
  Future<AppointmentModel?> getAppointmentById(String appointmentId) async {
    try {
      final doc = await _appointmentsCollection.doc(appointmentId).get();
      if (doc.exists && doc.data() != null) {
        return AppointmentModel.fromMap(doc.data() as Map<String, dynamic>);
      }
      return null;
    } catch (e) {
      throw Exception('Failed to get appointment: $e');
    }
  }

  /// Get appointments by category
  Future<List<AppointmentModel>> getAppointmentsByCategory(String categoryId) async {
    try {
      final snapshot = await _appointmentsCollection
          .where('categoryId', isEqualTo: categoryId)
          .get();
      return snapshot.docs
          .map((doc) => AppointmentModel.fromMap(doc.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw Exception('Failed to get appointments by category: $e');
    }
  }

  /// Get appointment categories
  Future<List<String>> getAppointmentCategories() async {
    try {
      // For now, return predefined categories
      // You can implement this to fetch from Firestore or other source
      return [
        'Business Meeting',
        'Personal Meeting',
        'Conference',
        'Interview',
        'Consultation',
        'Other'
      ];
    } catch (e) {
      throw Exception('Failed to get appointment categories: $e');
    }
  }

  /// Search appointments
  Future<List<AppointmentModel>> searchAppointments(String query, String userId) async {
    try {
      final snapshot = await _appointmentsCollection
          .where('hostId', isEqualTo: userId)
          .get();
      
      return snapshot.docs
          .map((doc) => AppointmentModel.fromMap(doc.data() as Map<String, dynamic>))
          .where((appointment) =>
              appointment.title.toLowerCase().contains(query.toLowerCase()) ||
              appointment.description.toLowerCase().contains(query.toLowerCase()))
          .toList();
    } catch (e) {
      throw Exception('Failed to search appointments: $e');
    }
  }

  /// Get upcoming appointments
  Future<List<AppointmentModel>> getUpcomingAppointments(String userId) async {
    try {
      final now = DateTime.now();
      final snapshot = await _appointmentsCollection
          .where('hostId', isEqualTo: userId)
          .where('startTime', isGreaterThan: now.toIso8601String())
          .orderBy('startTime')
          .get();
      
      return snapshot.docs
          .map((doc) => AppointmentModel.fromMap(doc.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw Exception('Failed to get upcoming appointments: $e');
    }
  }

  /// Get past appointments
  Future<List<AppointmentModel>> getPastAppointments(String userId) async {
    try {
      final now = DateTime.now();
      final snapshot = await _appointmentsCollection
          .where('hostId', isEqualTo: userId)
          .where('endTime', isLessThan: now.toIso8601String())
          .orderBy('endTime', descending: true)
          .get();
      
      return snapshot.docs
          .map((doc) => AppointmentModel.fromMap(doc.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw Exception('Failed to get past appointments: $e');
    }
  }
}
