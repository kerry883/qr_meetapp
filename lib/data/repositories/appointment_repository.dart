import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:qr_meetapp/data/models/appointment_model.dart';

class AppointmentRepository {
  final FirebaseFirestore _firestore;

  AppointmentRepository({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  CollectionReference get _appointmentsCollection =>
      _firestore.collection('appointments');

  Future<AppointmentModel> createAppointment(
      AppointmentModel appointment) async {
    try {
      final docRef = _appointmentsCollection.doc();
      final newAppointment = appointment.copyWith(id: docRef.id);
      await docRef.set(newAppointment.toMap());
      return newAppointment;
    } catch (e) {
      throw Exception('Failed to create appointment: $e');
    }
  }

  Future<void> updateAppointment(AppointmentModel appointment) async {
    try {
      await _appointmentsCollection
          .doc(appointment.id)
          .update(appointment.toMap());
    } catch (e) {
      throw Exception('Failed to update appointment: $e');
    }
  }

  Future<void> deleteAppointment(String appointmentId) async {
    try {
      await _appointmentsCollection.doc(appointmentId).delete();
    } catch (e) {
      throw Exception('Failed to delete appointment: $e');
    }
  }

  Stream<List<AppointmentModel>> getUserAppointments(String userId) {
    return _appointmentsCollection
        .where('hostId', isEqualTo: userId)
        .orderBy('startTime', descending: false)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => AppointmentModel.fromMap(doc.data() as Map<String, dynamic>))
            .toList());
  }

  Stream<List<AppointmentModel>> getUpcomingAppointments(String userId) {
    final now = DateTime.now();
    return _appointmentsCollection
        .where('hostId', isEqualTo: userId)
        .where('startTime', isGreaterThanOrEqualTo: now)
        .orderBy('startTime', descending: false)
        .limit(5)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => AppointmentModel.fromMap(doc.data() as Map<String, dynamic>))
            .toList());
  }

  Future<AppointmentModel> getAppointmentById(String appointmentId) async {
    try {
      final doc = await _appointmentsCollection.doc(appointmentId).get();
      if (doc.exists) {
        return AppointmentModel.fromMap(doc.data() as Map<String, dynamic>);
      }
      throw Exception('Appointment not found');
    } catch (e) {
      throw Exception('Failed to get appointment: $e');
    }
  }

  Future<void> updateAppointmentStatus(
      String appointmentId, String status) async {
    try {
      await _appointmentsCollection
          .doc(appointmentId)
          .update({'status': status});
    } catch (e) {
      throw Exception('Failed to update appointment status: $e');
    }
  }

  Future<void> setQrCode(String appointmentId, String qrCode, DateTime expiry) async {
    try {
      await _appointmentsCollection.doc(appointmentId).update({
        'qrCode': qrCode,
        'qrExpiry': expiry.toIso8601String(),
      });
    } catch (e) {
      throw Exception('Failed to set QR code: $e');
    }
  }
}