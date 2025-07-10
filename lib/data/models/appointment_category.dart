/// Model for appointment categories
class AppointmentCategory {
  final String id;
  final String name;
  final String description;
  final String? iconName;
  final String? colorCode;

  const AppointmentCategory({
    required this.id,
    required this.name,
    required this.description,
    this.iconName,
    this.colorCode,
  });

  factory AppointmentCategory.fromMap(Map<String, dynamic> map) {
    return AppointmentCategory(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      iconName: map['iconName'],
      colorCode: map['colorCode'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'iconName': iconName,
      'colorCode': colorCode,
    };
  }

  /// Default categories for the app
  static List<AppointmentCategory> getDefaultCategories() {
    return [
      const AppointmentCategory(
        id: 'business',
        name: 'Business Meeting',
        description: 'Professional meetings and conferences',
        iconName: 'business',
        colorCode: '#2196F3',
      ),
      const AppointmentCategory(
        id: 'personal',
        name: 'Personal Meeting',
        description: 'Personal appointments and social gatherings',
        iconName: 'person',
        colorCode: '#4CAF50',
      ),
      const AppointmentCategory(
        id: 'interview',
        name: 'Interview',
        description: 'Job interviews and assessments',
        iconName: 'work',
        colorCode: '#FF9800',
      ),
      const AppointmentCategory(
        id: 'consultation',
        name: 'Consultation',
        description: 'Professional consultations and advice',
        iconName: 'help',
        colorCode: '#9C27B0',
      ),
      const AppointmentCategory(
        id: 'conference',
        name: 'Conference',
        description: 'Conferences and seminars',
        iconName: 'event',
        colorCode: '#F44336',
      ),
      const AppointmentCategory(
        id: 'other',
        name: 'Other',
        description: 'Other types of appointments',
        iconName: 'more',
        colorCode: '#607D8B',
      ),
    ];
  }
}
