import 'package:flutter/material.dart';

class AppointmentCategory {
  final String id;
  final String name;
  final IconData icon;
  final Color color;

  const AppointmentCategory({
    required this.id,
    required this.name,
    required this.icon,
    this.color = Colors.blue,
  });

  factory AppointmentCategory.fromMap(Map<String, dynamic> map) {
    return AppointmentCategory(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      icon: _parseIcon(map['icon']),
      color: _parseColor(map['color']),
    );
  }

  static IconData _parseIcon(String icon) {
    switch (icon) {
      case 'business':
        return Icons.business;
      case 'school':
        return Icons.school;
      case 'health':
        return Icons.health_and_safety;
      case 'people':
        return Icons.people;
      case 'coffee':
        return Icons.coffee;
      case 'interview':
        return Icons.work;
      default:
        return Icons.calendar_today;
    }
  }

  static Color _parseColor(String color) {
    switch (color) {
      case 'green':
        return Colors.green;
      case 'red':
        return Colors.red;
      case 'orange':
        return Colors.orange;
      case 'purple':
        return Colors.purple;
      case 'teal':
        return Colors.teal;
      default:
        return Colors.blue;
    }
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'icon': _iconToString(icon),
      'color': _colorToString(color),
    };
  }

  String _iconToString(IconData icon) {
    switch (icon) {
      case Icons.business:
        return 'business';
      case Icons.school:
        return 'school';
      case Icons.health_and_safety:
        return 'health';
      case Icons.people:
        return 'people';
      case Icons.coffee:
        return 'coffee';
      case Icons.work:
        return 'interview';
      default:
        return 'default';
    }
  }

  String _colorToString(Color color) {
    if (color == Colors.green) return 'green';
    if (color == Colors.red) return 'red';
    if (color == Colors.orange) return 'orange';
    if (color == Colors.purple) return 'purple';
    if (color == Colors.teal) return 'teal';
    return 'blue';
  }
}