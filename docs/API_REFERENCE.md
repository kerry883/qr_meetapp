# API Reference

This document provides detailed API documentation for QR MeetApp's core services, repositories, and data models.

## Table of Contents

- [Repositories](#repositories)
  - [AppointmentRepository](#appointmentrepository)
  - [AuthRepository](#authrepository)
  - [ProfileRepository](#profilerepository)
- [Services](#services)
  - [QRService](#qrservice)
  - [NotificationService](#notificationservice)
  - [APIService](#apiservice)
- [State Classes](#state-classes)
  - [AuthState](#authstate)
  - [AppointmentState](#appointmentstate)
  - [ThemeState](#themestate)
  - [NotificationsState](#notificationsstate)

---

## Repositories

### AppointmentRepository

Handles all appointment-related database operations with Cloud Firestore.

#### Constructor

```dart
AppointmentRepository({FirebaseFirestore? firestore})
```

**Parameters:**
- `firestore` (optional): Custom Firestore instance for testing

#### Methods

##### getUserAppointments

```dart
Stream<List<AppointmentModel>> getUserAppointments(String userId)
```

Returns a real-time stream of appointments for the specified user.

**Parameters:**
- `userId`: The unique identifier of the user

**Returns:** `Stream<List<AppointmentModel>>` - A stream of appointment lists

---

##### createAppointment

```dart
Future<AppointmentModel> createAppointment(AppointmentModel appointment)
```

Creates a new appointment in the database.

**Parameters:**
- `appointment`: The appointment model to create

**Returns:** `Future<AppointmentModel>` - The created appointment with assigned ID

**Throws:** `Exception` if creation fails

---

##### updateAppointment

```dart
Future<void> updateAppointment(AppointmentModel appointment)
```

Updates an existing appointment.

**Parameters:**
- `appointment`: The appointment model with updated values

**Throws:** `Exception` if update fails

---

##### deleteAppointment

```dart
Future<void> deleteAppointment(String appointmentId)
```

Permanently deletes an appointment.

**Parameters:**
- `appointmentId`: The unique identifier of the appointment

**Throws:** `Exception` if deletion fails

---

##### cancelAppointment

```dart
Future<void> cancelAppointment(String appointmentId)
```

Marks an appointment as cancelled (soft delete).

**Parameters:**
- `appointmentId`: The unique identifier of the appointment

**Throws:** `Exception` if cancellation fails

---

##### getAppointmentById

```dart
Future<AppointmentModel?> getAppointmentById(String appointmentId)
```

Retrieves a single appointment by its ID.

**Parameters:**
- `appointmentId`: The unique identifier of the appointment

**Returns:** `Future<AppointmentModel?>` - The appointment or null if not found

**Throws:** `Exception` if retrieval fails

---

##### getAppointmentsByCategory

```dart
Future<List<AppointmentModel>> getAppointmentsByCategory(String categoryId)
```

Retrieves all appointments for a specific category.

**Parameters:**
- `categoryId`: The category identifier

**Returns:** `Future<List<AppointmentModel>>` - List of appointments in the category

---

##### searchAppointments

```dart
Future<List<AppointmentModel>> searchAppointments(String query, String userId)
```

Searches appointments by title or description.

**Parameters:**
- `query`: The search query string
- `userId`: The user's identifier

**Returns:** `Future<List<AppointmentModel>>` - List of matching appointments

---

##### getUpcomingAppointments

```dart
Future<List<AppointmentModel>> getUpcomingAppointments(String userId)
```

Retrieves future appointments for a user, ordered by start time.

**Parameters:**
- `userId`: The user's identifier

**Returns:** `Future<List<AppointmentModel>>` - List of upcoming appointments

---

##### getPastAppointments

```dart
Future<List<AppointmentModel>> getPastAppointments(String userId)
```

Retrieves past appointments for a user, ordered by end time (descending).

**Parameters:**
- `userId`: The user's identifier

**Returns:** `Future<List<AppointmentModel>>` - List of past appointments

---

## Services

### QRService

Handles QR code generation, scanning, and processing.

#### Methods

##### createScannerController

```dart
MobileScannerController createScannerController()
```

Creates a new mobile scanner controller for QR code scanning.

**Returns:** `MobileScannerController` - Controller for the camera scanner

---

##### processBarcodeResult

```dart
Future<QRDataModel> processBarcodeResult(BarcodeCapture capture)
```

Processes the result from the mobile scanner.

**Parameters:**
- `capture`: The barcode capture result from the scanner

**Returns:** `Future<QRDataModel>` - Parsed QR data

**Throws:** `Exception` if processing fails or barcode is invalid

---

##### generateAppointmentQR

```dart
String generateAppointmentQR(AppointmentModel appointment)
```

Generates QR code data string for an appointment.

**Parameters:**
- `appointment`: The appointment to encode

**Returns:** `String` - JSON-encoded string for QR code generation

**Example output:**
```json
{
  "type": "appointment",
  "id": "abc123",
  "title": "Team Meeting",
  "host": "user1",
  "guest": "user2",
  "startTime": "2024-01-15T10:00:00.000Z",
  "endTime": "2024-01-15T11:00:00.000Z",
  "location": "Conference Room A"
}
```

---

##### generateUserQR

```dart
String generateUserQR(UserModel user)
```

Generates QR code data string for a user profile.

**Parameters:**
- `user`: The user to encode

**Returns:** `String` - JSON-encoded string for QR code generation

---

##### isValidQR

```dart
bool isValidQR(String qrContent)
```

Validates if a string contains valid QR code data.

**Parameters:**
- `qrContent`: The raw QR code content

**Returns:** `bool` - True if valid, false otherwise

---

##### processQR

```dart
Future<QRDataModel> processQR(String rawValue)
```

Processes a raw QR code string into a data model.

**Parameters:**
- `rawValue`: The raw string from QR code

**Returns:** `Future<QRDataModel>` - Parsed QR data model

**Throws:** `Exception` if QR format is invalid

---

## State Classes

### AuthState

Manages user authentication state using Firebase Auth.

```dart
class AuthState extends ChangeNotifier
```

#### Properties

| Property | Type | Description |
|----------|------|-------------|
| `currentUser` | `UserModel?` | The currently authenticated user |
| `isLoading` | `bool` | Loading state indicator |
| `error` | `String?` | Last error message |

#### Methods

##### checkAuthStatus

```dart
Future<void> checkAuthStatus()
```

Checks if a user is currently authenticated and updates state accordingly.

---

##### login

```dart
Future<void> login(String email, String password)
```

Authenticates a user with email and password.

**Parameters:**
- `email`: User's email address
- `password`: User's password

---

##### logout

```dart
void logout()
```

Signs out the current user and clears the session.

---

### AppointmentState

Manages appointment data and operations.

```dart
class AppointmentState with ChangeNotifier
```

#### Properties

| Property | Type | Description |
|----------|------|-------------|
| `appointments` | `List<AppointmentModel>` | All loaded appointments |
| `selectedAppointment` | `AppointmentModel?` | Currently selected appointment |
| `isLoading` | `bool` | Loading state indicator |
| `error` | `String?` | Last error message |
| `searchQuery` | `String` | Current search filter |
| `filteredAppointments` | `List<AppointmentModel>` | Appointments matching search |

#### Methods

##### loadAppointments

```dart
Future<void> loadAppointments(String userId)
```

Loads all upcoming appointments for a user.

---

##### setSearchQuery

```dart
void setSearchQuery(String query)
```

Sets the search filter and updates filtered results.

---

##### addAppointment

```dart
Future<void> addAppointment(AppointmentModel appointment)
```

Creates a new appointment and adds it to the list.

---

##### updateAppointment

```dart
Future<void> updateAppointment(AppointmentModel updatedAppointment)
```

Updates an existing appointment.

---

##### cancel

```dart
Future<void> cancel(String appointmentId)
```

Cancels an appointment by ID.

---

##### removeAppointment

```dart
Future<void> removeAppointment(String appointmentId)
```

Permanently removes an appointment.

---

##### selectAppointment

```dart
void selectAppointment(AppointmentModel appointment)
```

Sets the currently selected appointment.

---

##### loadById

```dart
Future<void> loadById(String id)
```

Loads and selects an appointment by its ID.

---

##### clearSelection

```dart
void clearSelection()
```

Clears the current appointment selection.

---

### ThemeState

Manages application theme preferences.

```dart
class ThemeState extends ChangeNotifier
```

#### Properties

| Property | Type | Description |
|----------|------|-------------|
| `themeMode` | `ThemeMode` | Current theme mode (light/dark/system) |
| `isDarkMode` | `bool` | Whether dark mode is active |

#### Methods

##### toggleTheme

```dart
void toggleTheme()
```

Toggles between light and dark theme modes.

---

## Usage Examples

### Creating an Appointment

```dart
final appointmentState = context.read<AppointmentState>();

final newAppointment = AppointmentModel(
  id: '',
  title: 'Team Meeting',
  description: 'Weekly sync meeting',
  hostId: currentUser.id,
  hostName: currentUser.name,
  startTime: DateTime.now().add(Duration(hours: 24)),
  endTime: DateTime.now().add(Duration(hours: 25)),
  location: 'Conference Room A',
  status: 'pending',
  createdAt: DateTime.now(),
);

await appointmentState.addAppointment(newAppointment);
```

### Generating and Scanning QR Codes

```dart
final qrService = QRService();

// Generate QR code for appointment
final qrData = qrService.generateAppointmentQR(appointment);

// Later, scan and process QR code
final scannedData = await qrService.processQR(rawQRString);

if (scannedData.type == 'appointment') {
  // Handle appointment QR code
  print('Meeting: ${scannedData.title}');
  print('Time: ${scannedData.meetingTime}');
}
```

### Searching Appointments

```dart
final appointmentState = context.read<AppointmentState>();

// Set search query
appointmentState.setSearchQuery('meeting');

// Access filtered results
final results = appointmentState.filteredAppointments;
```
