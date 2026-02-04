# QR MeetApp - Project Overview

## Project Description

QR MeetApp is a cross-platform Flutter mobile application designed to streamline appointment scheduling and meeting management through innovative QR code technology. The app enables users to create, manage, and track appointments while using QR codes for quick verification and seamless check-in experiences at meetings, making it ideal for business, academic, healthcare, and casual meetup scenarios.

---

## My Role & Contributions

- **Full-Stack Mobile Development**: Designed and implemented the entire Flutter application architecture using clean architecture principles with clear separation between presentation, state, data, and service layers.
- **Firebase Integration**: Set up and configured Firebase services including Authentication, Cloud Firestore, Firebase Storage, and Cloud Messaging for real-time data synchronization and push notifications.
- **QR Code System**: Developed the complete QR code generation and scanning functionality using `qr_flutter` and `mobile_scanner` packages for appointment verification and check-in processes.
- **State Management**: Implemented reactive state management using Provider with ChangeNotifiers for authentication, appointments, themes, and notifications.
- **UI/UX Implementation**: Built responsive and animated user interfaces using Flutter ScreenUtil, Lottie animations, and Material Design components with dark/light theme support.
- **Navigation Architecture**: Configured Go Router for declarative routing with deep linking support and persistent bottom navigation using stateful shell routes.

---

## Key Features

- **User Authentication**
  - Email/password authentication via Firebase Auth
  - OTP verification for phone numbers
  - Password recovery functionality
  - Secure session management

- **Appointment Management**
  - Create, view, edit, and cancel appointments
  - Search and filter appointments by date, category, or status
  - Categorize appointments (Business, Academic, Health, Interview, Casual)
  - Track upcoming and past appointments

- **QR Code Integration**
  - Generate unique QR codes for each appointment
  - Scan QR codes to verify and check-in to appointments
  - Manual code entry fallback option
  - Real-time QR validation and processing

- **User Profile & Settings**
  - View and edit personal information
  - Profile picture management via Firebase Storage
  - Dark/Light theme toggle
  - Notification preferences
  - Language settings

- **Real-Time Features**
  - Push notifications via Firebase Cloud Messaging
  - Real-time data synchronization with Firestore
  - Offline capability with local data caching

---

## Learning Outcomes / Impact

### Technical Skills Gained
- **Flutter Development**: Mastered cross-platform mobile app development with Flutter, including widget composition, state management, and platform-specific configurations for Android and iOS.
- **Firebase Backend Services**: Gained hands-on experience with Firebase ecosystem including Authentication, Firestore database design, Storage for media files, and Cloud Messaging for notifications.
- **Clean Architecture**: Applied clean architecture principles to create maintainable, testable, and scalable mobile application structure.
- **QR Code Technology**: Implemented QR code generation and scanning workflows for real-world verification and check-in use cases.

### Project Impact
- **Improved Meeting Efficiency**: The QR check-in system reduces manual verification time and streamlines the meeting check-in process.
- **Cross-Platform Reach**: Single codebase deploys to Android, iOS, and web platforms, maximizing user accessibility.
- **Scalable Foundation**: The modular architecture allows easy addition of new features and appointment categories.
- **Professional Portfolio Piece**: Demonstrates full-stack mobile development capabilities with modern Flutter practices.

---

## Link / Screenshot

### GitHub Repository
[https://github.com/kerry883/qr_meetapp](https://github.com/kerry883/qr_meetapp)

### Application Screenshots

*Add screenshots of the application here:*

| Home Screen | Appointments | QR Scanner | Profile |
|-------------|--------------|------------|---------|
| ![Home](assets/screenshots/home.png) | ![Appointments](assets/screenshots/appointments.png) | ![QR Scanner](assets/screenshots/qr_scanner.png) | ![Profile](assets/screenshots/profile.png) |

> **Note**: To add screenshots, capture images from the running application and save them to `assets/screenshots/` directory.

---

## Technology Stack

| Category | Technologies |
|----------|-------------|
| **Framework** | Flutter (SDK >=3.0.0 <4.0.0), Dart |
| **Backend** | Firebase (Auth, Firestore, Storage, Messaging) |
| **State Management** | Provider, GetIt (DI) |
| **Navigation** | Go Router |
| **QR Code** | qr_flutter, mobile_scanner |
| **UI/UX** | Flutter ScreenUtil, Lottie, Google Fonts |
| **Networking** | Dio, HTTP |
| **Location** | Google Maps Flutter, Geolocator |

---

*Last Updated: February 2026*
