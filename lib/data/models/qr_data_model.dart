import 'dart:convert';

import 'package:equatable/equatable.dart';

/// Represents structured data for QR code generation and parsing
class QRDataModel extends Equatable {
  final String id;
  final String type;
  final DateTime createdAt;
  final String? hostId;
  final String? guestId;
  final DateTime? meetingTime;
  final String? title;
  final String? location;
  final String? note;

  const QRDataModel({
    required this.id,
    required this.type,
    required this.createdAt,
    this.hostId,
    this.guestId,
    this.meetingTime,
    this.title,
    this.location,
    this.note,
  });

  /// Creates an instance from JSON string
  factory QRDataModel.fromJson(String jsonString) {
    final data = json.decode(jsonString) as Map<String, dynamic>;
    return QRDataModel(
      id: data['id'] as String,
      type: data['type'] as String,
      createdAt: DateTime.parse(data['createdAt'] as String),
      hostId: data['hostId'] as String?,
      guestId: data['guestId'] as String?,
      meetingTime: data['meetingTime'] != null
          ? DateTime.parse(data['meetingTime'] as String)
          : null,
      title: data['title'] as String?,
      location: data['location'] as String?,
      note: data['note'] as String?,
    );
  }

  /// Converts instance to JSON string
  String toJson() {
    return json.encode({
      'id': id,
      'type': type,
      'createdAt': createdAt.toIso8601String(),
      if (hostId != null) 'hostId': hostId,
      if (guestId != null) 'guestId': guestId,
      if (meetingTime != null) 'meetingTime': meetingTime!.toIso8601String(),
      if (title != null) 'title': title,
      if (location != null) 'location': location,
      if (note != null) 'note': note,
    });
  }

  /// Determines if the QR data is valid
  bool get isValid {
    if (type == 'appointment') {
      return hostId != null && 
             guestId != null && 
             meetingTime != null &&
             title != null;
    } else if (type == 'user') {
      return hostId != null;
    }
    return false;
  }

  @override
  List<Object?> get props => [
        id,
        type,
        createdAt,
        hostId,
        guestId,
        meetingTime,
        title,
        location,
        note,
      ];
}