import 'package:equatable/equatable.dart';
import 'package:qr_meetapp/core/utils/date_time_utils.dart';

class AppointmentModel extends Equatable {
  final String id;
  final String title;
  final String description;
  final String hostId;
  final String hostName;
  final String? guestId;
  final String? guestName;
  final DateTime startTime;
  final DateTime endTime;
  final String location;
  final String? categoryId;
  final String status; // pending, accepted, declined, completed
  final String? qrCode;
  final DateTime createdAt;
  final DateTime? updatedAt;

  const AppointmentModel({
    required this.id,
    required this.title,
    required this.description,
    required this.hostId,
    required this.hostName,
    this.guestId,
    this.guestName,
    required this.startTime,
    required this.endTime,
    required this.location,
    this.categoryId,
    required this.status,
    this.qrCode,
    required this.createdAt,
    this.updatedAt,
  });

  factory AppointmentModel.fromMap(Map<String, dynamic> map) {
    return AppointmentModel(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      hostId: map['hostId'] ?? '',
      hostName: map['hostName'] ?? '',
      guestId: map['guestId'],
      guestName: map['guestName'],
      startTime: DateTime.parse(map['startTime']),
      endTime: DateTime.parse(map['endTime']),
      location: map['location'] ?? '',
      categoryId: map['categoryId'],
      status: map['status'] ?? 'pending',
      qrCode: map['qrCode'],
      createdAt: DateTime.parse(map['createdAt']),
      updatedAt: map['updatedAt'] != null ? DateTime.parse(map['updatedAt']) : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'hostId': hostId,
      'hostName': hostName,
      'guestId': guestId,
      'guestName': guestName,
      'startTime': startTime.toIso8601String(),
      'endTime': endTime.toIso8601String(),
      'location': location,
      'categoryId': categoryId,
      'status': status,
      'qrCode': qrCode,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }

  factory AppointmentModel.fromJson(Map<String, dynamic> json) {
    return AppointmentModel.fromMap(json);
  }

  Map<String, dynamic> toJson() {
    return toMap();
  }

  AppointmentModel copyWith({
    String? id,
    String? title,
    String? description,
    String? hostId,
    String? hostName,
    String? guestId,
    String? guestName,
    DateTime? startTime,
    DateTime? endTime,
    String? location,
    String? categoryId,
    String? status,
    String? qrCode,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return AppointmentModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      hostId: hostId ?? this.hostId,
      hostName: hostName ?? this.hostName,
      guestId: guestId ?? this.guestId,
      guestName: guestName ?? this.guestName,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      location: location ?? this.location,
      categoryId: categoryId ?? this.categoryId,
      status: status ?? this.status,
      qrCode: qrCode ?? this.qrCode,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  /// Get formatted date string
  String get formattedDate {
    return DateTimeUtils.formatDate(startTime);
  }

  /// Get formatted time string
  String get formattedTime {
    return DateTimeUtils.formatTime(startTime);
  }

  /// Get formatted date and time string
  String get formattedDateTime {
    return DateTimeUtils.formatDateTime(startTime);
  }

  /// Get duration of the appointment
  String get duration {
    return DateTimeUtils.getDuration(startTime, endTime);
  }

  /// Check if appointment is today
  bool get isToday {
    return DateTimeUtils.isToday(startTime);
  }

  /// Check if appointment is in the future
  bool get isFuture {
    return startTime.isAfter(DateTime.now());
  }

  /// Check if appointment is in the past
  bool get isPast {
    return endTime.isBefore(DateTime.now());
  }

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        hostId,
        hostName,
        guestId,
        guestName,
        startTime,
        endTime,
        location,
        categoryId,
        status,
        qrCode,
        createdAt,
        updatedAt,
      ];
}

// Alias for backwards compatibility
typedef Appointment = AppointmentModel;
