/// Enum for appointment status values
enum AppointmentStatus {
  pending,
  accepted,
  declined,
  completed,
  cancelled;
}

/// Create AppointmentStatus from string
AppointmentStatus appointmentStatusFromString(String status) {
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
