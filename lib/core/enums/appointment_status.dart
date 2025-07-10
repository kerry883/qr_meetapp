/// Enum for appointment status values
enum AppointmentStatus {
  pending,
  accepted,
  declined,
  completed,
  cancelled;

  /// Get display name for the status
  String get displayName {
    switch (this) {
      case AppointmentStatus.pending:
        return 'Pending';
      case AppointmentStatus.accepted:
        return 'Accepted';
      case AppointmentStatus.declined:
        return 'Declined';
      case AppointmentStatus.completed:
        return 'Completed';
      case AppointmentStatus.cancelled:
        return 'Cancelled';
    }
  }

  /// Get color for the status
  String get colorName {
    switch (this) {
      case AppointmentStatus.pending:
        return 'warning';
      case AppointmentStatus.accepted:
        return 'success';
      case AppointmentStatus.declined:
        return 'error';
      case AppointmentStatus.completed:
        return 'primary';
      case AppointmentStatus.cancelled:
        return 'error';
    }
  }

  /// Create AppointmentStatus from string
  static AppointmentStatus fromString(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return AppointmentStatus.pending;
      case 'accepted':
        return AppointmentStatus.accepted;
      case 'declined':
        return AppointmentStatus.declined;
      case 'completed':
        return AppointmentStatus.completed;
      case 'cancelled':
        return AppointmentStatus.cancelled;
      default:
        return AppointmentStatus.pending;
    }
  }
}
