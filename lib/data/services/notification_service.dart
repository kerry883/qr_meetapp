import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:qr_meetapp/core/utils/notification_utils.dart';
import 'package:qr_meetapp/data/models/appointment_model.dart';

/// Service for handling all notification operations
class NotificationService {
  final FlutterLocalNotificationsPlugin notificationsPlugin;

  NotificationService(this.notificationsPlugin);

  /// Initialize notification services
  Future<void> initialize() async {
    await NotificationUtils.initialize();
  }

  /// Schedule appointment reminders
  Future<void> scheduleAppointmentReminders(Appointment appointment) async {
    // Schedule reminder 1 day before
    await NotificationUtils.scheduleMeetingReminder(
      id: appointment.id.hashCode,
      title: 'Reminder: ${appointment.title}',
      body: 'Your appointment is tomorrow at ${appointment.startTime}',
      meetingTime: appointment.startTime.subtract(const Duration(days: 1)),
    );

    // Schedule reminder 1 hour before
    await NotificationUtils.scheduleMeetingReminder(
      id: appointment.id.hashCode + 1,
      title: 'Starting Soon: ${appointment.title}',
      body: 'Your appointment starts in 1 hour',
      meetingTime: appointment.startTime.subtract(const Duration(hours: 1)),
    );
  }

  /// Show instant notification
  Future<void> showInstantNotification({
    required String title,
    required String body,
    String? payload,
  }) async {
    await NotificationUtils.showInstantNotification(
      title: title,
      body: body,
      payload: payload,
    );
  }

  /// Cancel all notifications for an appointment
  Future<void> cancelAppointmentNotifications(Appointment appointment) async {
    await notificationsPlugin.cancel(appointment.id.hashCode);
    await notificationsPlugin.cancel(appointment.id.hashCode + 1);
  }

  /// Handle notification taps
  void configureNotificationActions() {
    // Handle notification taps
    notificationsPlugin.initialize(
      const InitializationSettings(
        android: AndroidInitializationSettings('@mipmap/ic_launcher'),
        iOS: DarwinInitializationSettings(),
      ),
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        // Handle notification tap
        // Could navigate to specific appointment details
      },
    );
  }
}