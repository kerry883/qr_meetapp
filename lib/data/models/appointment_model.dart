

enum AppointmentStatus {
  pending,
  confirmed,
  cancelled,
  completed,
}

class AppointmentModel {
  final String id;
  final String hostId;
  final String guestId;
  final String category;
  final String title;
  final String description;
  final String location;
  final DateTime startTime;
  final DateTime endTime;
  final AppointmentStatus status;
  final String? qrCode;
  final DateTime? qrExpiry;
  final DateTime createdAt;
  final DateTime updatedAt;

  AppointmentModel({
    required this.id,
    required this.hostId,
    required this.guestId,
    required this.category,
    required this.title,
    required this.description,
    required this.location,
    required this.startTime,
    required this.endTime,
    this.status = AppointmentStatus.pending,
    this.qrCode,
    this.qrExpiry,
    required this.createdAt,
    required this.updatedAt,
  });

  factory AppointmentModel.fromMap(Map<String, dynamic> map) {
    return AppointmentModel(
      id: map['id'] ?? '',
      hostId: map['hostId'] ?? '',
      guestId: map['guestId'] ?? '',
      category: map['category'] ?? '',
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      location: map['location'] ?? '',
      startTime: DateTime.parse(map['startTime']),
      endTime: DateTime.parse(map['endTime']),
      status: _parseStatus(map['status']),
      qrCode: map['qrCode'],
      qrExpiry: map['qrExpiry'] != null ? DateTime.parse(map['qrExpiry']) : null,
      createdAt: DateTime.parse(map['createdAt']),
      updatedAt: DateTime.parse(map['updatedAt']),
    );
  }

  static AppointmentStatus _parseStatus(String status) {
    switch (status) {
      case 'confirmed':
        return AppointmentStatus.confirmed;
      case 'cancelled':
        return AppointmentStatus.cancelled;
      case 'completed':
        return AppointmentStatus.completed;
      default:
        return AppointmentStatus.pending;
    }
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'hostId': hostId,
      'guestId': guestId,
      'category': category,
      'title': title,
      'description': description,
      'location': location,
      'startTime': startTime.toIso8601String(),
      'endTime': endTime.toIso8601String(),
      'status': status.name,
      'qrCode': qrCode,
      'qrExpiry': qrExpiry?.toIso8601String(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  String get statusText {
    switch (status) {
      case AppointmentStatus.pending:
        return 'Pending';
      case AppointmentStatus.confirmed:
        return 'Confirmed';
      case AppointmentStatus.cancelled:
        return 'Cancelled';
      case AppointmentStatus.completed:
        return 'Completed';
    }
  }

  AppointmentModel copyWith({
    String? id,
    String? hostId,
    String? guestId,
    String? category,
    String? title,
    String? description,
    String? location,
    DateTime? startTime,
    DateTime? endTime,
    AppointmentStatus? status,
    String? qrCode,
    DateTime? qrExpiry,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return AppointmentModel(
      id: id ?? this.id,
      hostId: hostId ?? this.hostId,
      guestId: guestId ?? this.guestId,
      category: category ?? this.category,
      title: title ?? this.title,
      description: description ?? this.description,
      location: location ?? this.location,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      status: status ?? this.status,
      qrCode: qrCode ?? this.qrCode,
      qrExpiry: qrExpiry ?? this.qrExpiry,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}