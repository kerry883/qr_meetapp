# QR MeetApp

A modern Flutter application for managing appointments and meetings using QR code technology. This app streamlines the process of scheduling, managing, and checking in to appointments through an intuitive mobile interface.

## Table of Contents

- [Overview](#overview)
- [Features](#features)
- [Screenshots](#screenshots)
- [Technology Stack](#technology-stack)
- [Architecture](#architecture)
- [Project Structure](#project-structure)
- [Getting Started](#getting-started)
- [Firebase Setup](#firebase-setup)
- [Configuration](#configuration)
- [Data Models](#data-models)
- [State Management](#state-management)
- [Navigation](#navigation)
- [Contributing](#contributing)
- [License](#license)

## Overview

QR MeetApp is a comprehensive appointment management solution that leverages QR code technology to simplify the meeting check-in process. Users can create, manage, and track appointments while using QR codes for quick verification and check-in at meetings.

### Key Use Cases

- **Business Meetings**: Schedule and manage professional meetings with QR-based check-ins
- **Academic Appointments**: Book consultations with professors or advisors
- **Healthcare Visits**: Manage medical appointments with easy verification
- **Interviews**: Coordinate interview schedules with candidates
- **Casual Meetups**: Organize informal meetings with friends or colleagues

## Features

### Authentication
- Email and password authentication via Firebase
- OTP verification for phone numbers
- Password recovery functionality
- Secure session management

### Appointment Management
- Create new appointments with detailed information
- View upcoming and past appointments
- Search and filter appointments
- Cancel or reschedule appointments
- Categorize appointments (Business, Academic, Health, Interview, Casual, etc.)

### QR Code Integration
- Generate QR codes for appointments
- Scan QR codes to verify appointments
- Manual code entry option
- QR code validation and processing

### User Profile
- View and edit personal information
- Profile picture management
- Appointment history
- Account settings and security options

### Settings & Preferences
- Dark/Light theme toggle
- Notification preferences
- Language settings
- Privacy and terms of service

### Additional Features
- Push notifications via Firebase Cloud Messaging
- Real-time data synchronization with Firestore
- Offline capability with local data caching
- Responsive UI with animations

## Screenshots

*Screenshots can be added here showcasing the main features of the application*

## Technology Stack

### Core Framework
- **Flutter** (SDK >=3.0.0 <4.0.0) - Cross-platform mobile development framework
- **Dart** - Programming language

### Backend & Database
- **Firebase Core** - Core Firebase SDK
- **Firebase Auth** - User authentication
- **Cloud Firestore** - NoSQL cloud database
- **Firebase Storage** - File and media storage
- **Firebase Messaging** - Push notifications

### State Management & Dependency Injection
- **Provider** (^6.0.5) - State management solution
- **GetIt** (^7.6.4) - Service locator for dependency injection

### Navigation
- **Go Router** (^12.0.0) - Declarative routing

### UI Components
- **Flutter ScreenUtil** (^5.9.0) - Responsive UI scaling
- **Lottie** (^3.1.0) - Animation support
- **Animations** (^2.0.7) - Material motion animations
- **Google Fonts** (^6.2.1) - Custom typography
- **Cached Network Image** (^3.3.0) - Image caching
- **Carousel Slider** (^5.1.1) - Image carousels
- **Shimmer** (^3.0.0) - Loading placeholders

### Forms & Validation
- **Flutter Form Builder** (^10.1.0) - Form creation and validation
- **Formz** (^0.8.0) - Form validation

### QR Code Functionality
- **Mobile Scanner** (^7.0.1) - QR code scanning
- **QR Flutter** (^4.1.0) - QR code generation

### Networking & Utilities
- **Dio** (^5.3.0) - HTTP client
- **HTTP** (^1.2.2) - HTTP requests
- **Connectivity Plus** (^6.1.4) - Network connectivity checking
- **Shared Preferences** (^2.2.0) - Local key-value storage
- **Intl** (^0.20.2) - Internationalization and formatting

### Location Services
- **Google Maps Flutter** (^2.5.0) - Map integration
- **Geolocator** (^14.0.2) - Location services

### Additional Utilities
- **Equatable** (^2.0.5) - Value equality
- **Logger** (^2.6.1) - Debugging and logging
- **Image Picker** (^1.1.2) - Photo selection
- **File Picker** (^10.2.0) - File selection
- **Timezone** (^0.10.0) - Timezone handling
- **Flutter Local Notifications** (^19.3.1) - Local notifications

## Architecture

QR MeetApp follows a clean architecture pattern with clear separation of concerns:

```
┌─────────────────────────────────────────────────────────┐
│                    Presentation Layer                    │
│  (Screens, Widgets, ViewModels)                         │
├─────────────────────────────────────────────────────────┤
│                      State Layer                         │
│  (Provider ChangeNotifiers)                             │
├─────────────────────────────────────────────────────────┤
│                      Data Layer                          │
│  (Repositories, Services, Models)                       │
├─────────────────────────────────────────────────────────┤
│                    External Services                     │
│  (Firebase, APIs, Local Storage)                        │
└─────────────────────────────────────────────────────────┘
```

### Layer Responsibilities

- **Presentation Layer**: UI components, screens, and user interactions
- **State Layer**: Application state management using Provider
- **Data Layer**: Business logic, data repositories, and models
- **External Services**: Third-party integrations and data sources

## Project Structure

```
lib/
├── main.dart                 # Application entry point
├── app.dart                  # Root widget and MaterialApp configuration
├── firebase_options.dart     # Firebase configuration (auto-generated)
│
├── core/                     # Core utilities and shared components
│   ├── constants/            # App-wide constants (colors, strings, styles)
│   ├── enums/                # Enumeration types
│   ├── services/             # Core services (service locator)
│   ├── theme/                # Theme configuration
│   ├── utils/                # Utility functions
│   └── widgets/              # Reusable UI components
│       ├── buttons/          # Button widgets
│       ├── cards/            # Card widgets
│       ├── indicators/       # Loading and status indicators
│       ├── inputs/           # Form input widgets
│       └── layout/           # Layout widgets
│
├── data/                     # Data layer
│   ├── models/               # Data models
│   │   ├── appointment_model.dart
│   │   ├── category_model.dart
│   │   ├── qr_data_model.dart
│   │   └── user_model.dart
│   ├── repositories/         # Data repositories
│   │   ├── appointment_repository.dart
│   │   ├── auth_repository.dart
│   │   ├── profile_repository.dart
│   │   └── settings_repository.dart
│   └── services/             # External services
│       ├── api_service.dart
│       ├── notification_service.dart
│       └── qr_service.dart
│
├── features/                 # Feature modules
│   ├── appointments/         # Appointment management
│   ├── auth/                 # Authentication
│   ├── booking/              # Appointment booking
│   ├── categories/           # Category browsing
│   ├── home/                 # Home screen
│   ├── notifications/        # Notifications
│   ├── onboarding/           # User onboarding
│   ├── profile/              # User profile
│   ├── qr_scanner/           # QR code scanning
│   ├── settings/             # App settings
│   └── splash/               # Splash screen
│
├── navigation/               # Navigation configuration
│   ├── app_router.dart       # Route definitions
│   └── route_names.dart      # Route name constants
│
└── state/                    # Application state
    ├── appointment_state.dart
    ├── auth_state.dart
    ├── notifications_state.dart
    └── theme_state.dart

assets/
├── animations/               # Lottie animation files
├── icons/                    # App icons
└── images/                   # Image assets
```

## Getting Started

### Prerequisites

- Flutter SDK (>=3.0.0 <4.0.0)
- Dart SDK
- Android Studio / VS Code with Flutter extensions
- Firebase CLI (for Firebase setup)
- Xcode (for iOS development on macOS)
- Android SDK (for Android development)

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/yourusername/qr_meetapp.git
   cd qr_meetapp
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Configure Firebase** (see [Firebase Setup](#firebase-setup) section)

4. **Run the application**
   ```bash
   # Run in debug mode
   flutter run

   # Run on specific device
   flutter run -d <device_id>

   # Run in release mode
   flutter run --release
   ```

### Build Commands

```bash
# Build APK (Android)
flutter build apk

# Build App Bundle (Android)
flutter build appbundle

# Build iOS
flutter build ios

# Build for web
flutter build web
```

## Firebase Setup

QR MeetApp uses Firebase for backend services. Follow these steps to configure Firebase:

### 1. Create a Firebase Project

1. Go to the [Firebase Console](https://console.firebase.google.com/)
2. Click "Add Project" and follow the setup wizard
3. Enable Google Analytics (optional)

### 2. Add Platform Apps

#### Android
1. In Firebase Console, click "Add App" and select Android
2. Enter package name: `com.example.qr_meetapp` (or your package name)
3. Download `google-services.json`
4. Place it in `android/app/` directory

#### iOS
1. Click "Add App" and select iOS
2. Enter bundle ID from `ios/Runner.xcodeproj`
3. Download `GoogleService-Info.plist`
4. Add to `ios/Runner/` using Xcode

### 3. Enable Firebase Services

#### Authentication
1. Go to Authentication > Sign-in method
2. Enable Email/Password provider
3. Enable Phone authentication (if using OTP)

#### Cloud Firestore
1. Go to Firestore Database
2. Create database in production or test mode
3. Set up security rules:

```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    match /appointments/{appointmentId} {
      allow read, write: if request.auth != null;
    }
    match /users/{userId} {
      allow read, write: if request.auth != null && request.auth.uid == userId;
    }
  }
}
```

#### Firebase Storage
1. Go to Storage
2. Set up storage bucket
3. Configure security rules for file uploads

#### Cloud Messaging
1. Go to Cloud Messaging
2. Note your Server Key for push notifications
3. Configure APNs for iOS (requires Apple Developer account)

### 4. Generate Firebase Options

```bash
# Install FlutterFire CLI
dart pub global activate flutterfire_cli

# Configure Firebase
flutterfire configure
```

This generates the `lib/firebase_options.dart` file automatically.

## Configuration

### Environment Variables

Create environment-specific configurations as needed:

```dart
// lib/core/constants/app_config.dart
class AppConfig {
  static const String appName = 'QR MeetApp';
  static const String appVersion = '1.0.0';
  // Add other configuration constants
}
```

### Theme Customization

Modify the app theme in `lib/core/theme/app_theme.dart`:

```dart
class AppTheme {
  static ThemeData get lightTheme => ThemeData(
    // Customize light theme
  );

  static ThemeData get darkTheme => ThemeData(
    // Customize dark theme
  );
}
```

## Data Models

### UserModel

Represents a user in the system.

```dart
class UserModel {
  final String id;
  final String name;
  final String email;
  final String? phone;
  final String? company;
  final String? position;
  final String? profileImageUrl;
  final DateTime createdAt;
}
```

### AppointmentModel

Represents an appointment/meeting.

```dart
class AppointmentModel {
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
  final String status;  // pending, accepted, declined, completed
  final String? qrCode;
  final DateTime createdAt;
  final DateTime? updatedAt;
}
```

### QRDataModel

Represents data encoded in QR codes.

```dart
class QRDataModel {
  final String id;
  final String type;  // 'appointment' or 'user'
  final DateTime createdAt;
  final String? hostId;
  final String? guestId;
  final DateTime? meetingTime;
  final String? title;
  final String? location;
  final String? note;
}
```

### AppointmentCategory

Represents appointment categories.

```dart
class AppointmentCategory {
  final String id;
  final String name;
  final IconData icon;
  final Color color;
}
```

## State Management

The app uses Provider for state management with the following state classes:

### AuthState

Manages user authentication state.

```dart
class AuthState extends ChangeNotifier {
  UserModel? currentUser;
  bool isLoading;
  String? error;

  Future<void> checkAuthStatus();
  Future<void> login(String email, String password);
  void logout();
}
```

### AppointmentState

Manages appointment data and operations.

```dart
class AppointmentState with ChangeNotifier {
  List<AppointmentModel> appointments;
  AppointmentModel? selectedAppointment;
  bool isLoading;
  String? error;
  String searchQuery;

  List<AppointmentModel> get filteredAppointments;

  Future<void> loadAppointments(String userId);
  Future<void> addAppointment(AppointmentModel appointment);
  Future<void> updateAppointment(AppointmentModel appointment);
  Future<void> cancel(String appointmentId);
  Future<void> removeAppointment(String appointmentId);
}
```

### ThemeState

Manages app theme preferences.

```dart
class ThemeState extends ChangeNotifier {
  ThemeMode themeMode;
  bool isDarkMode;

  void toggleTheme();
}
```

### NotificationsState

Manages notification preferences and data.

## Navigation

The app uses Go Router for declarative navigation with a stateful shell for persistent bottom navigation.

### Route Structure

```
/                     → Splash Screen
/onboarding           → Onboarding Flow
/login                → Login Screen
/register             → Registration Screen
/forgot-password      → Password Recovery
/otp-verification     → OTP Verification

# Shell Routes (with bottom navigation)
/home                 → Home Screen
  /home/appointments  → Appointments List
    /home/appointments/:id → Appointment Details
  /home/notifications → Notifications
/booking              → Booking Screen
/category/:id         → Category Details
/qr-scanner           → QR Scanner
/profile              → User Profile
/settings             → Settings
```

### Navigation Usage

```dart
// Navigate to a route
context.go('/home');

// Push a route onto the stack
context.push('/home/appointments');

// Navigate with parameters
context.push('/home/appointments/$appointmentId');

// Navigate with extra data
context.push('/category/$categoryId', extra: category);
```

## Contributing

We welcome contributions to QR MeetApp! Please follow these guidelines:

### Getting Started

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Make your changes
4. Run tests and linting
5. Commit your changes (`git commit -m 'Add amazing feature'`)
6. Push to your branch (`git push origin feature/amazing-feature`)
7. Open a Pull Request

### Code Style

- Follow the [Dart style guide](https://dart.dev/guides/language/effective-dart/style)
- Use meaningful variable and function names
- Add comments for complex logic
- Keep functions small and focused
- Write unit tests for new features

### Running Tests

```bash
# Run all tests
flutter test

# Run tests with coverage
flutter test --coverage

# Run specific test file
flutter test test/widget_test.dart
```

### Linting

```bash
# Analyze code
flutter analyze

# Fix formatting issues
dart format .
```

### Commit Messages

Follow conventional commits format:
- `feat:` New feature
- `fix:` Bug fix
- `docs:` Documentation changes
- `style:` Code style changes (formatting, etc.)
- `refactor:` Code refactoring
- `test:` Adding or updating tests
- `chore:` Maintenance tasks

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

## Support

If you encounter any issues or have questions:

1. Check the [Issues](https://github.com/yourusername/qr_meetapp/issues) page
2. Create a new issue with detailed information
3. Include steps to reproduce bugs
4. Attach screenshots when helpful

## Acknowledgments

- [Flutter](https://flutter.dev/) - UI framework
- [Firebase](https://firebase.google.com/) - Backend services
- [Provider](https://pub.dev/packages/provider) - State management
- All other open-source packages used in this project
