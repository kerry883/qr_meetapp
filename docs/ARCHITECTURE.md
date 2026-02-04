# Application Architecture

This document describes the architectural design of QR MeetApp, explaining the patterns, layers, and design decisions used throughout the application.

## Table of Contents

- [Overview](#overview)
- [Architectural Pattern](#architectural-pattern)
- [Layer Architecture](#layer-architecture)
- [State Management](#state-management)
- [Dependency Injection](#dependency-injection)
- [Navigation Architecture](#navigation-architecture)
- [Data Flow](#data-flow)
- [Error Handling](#error-handling)
- [Best Practices](#best-practices)

## Overview

QR MeetApp follows a clean architecture approach with clear separation of concerns. The application is organized into distinct layers, each with specific responsibilities:

```
┌──────────────────────────────────────────────────────────────────┐
│                         UI Layer                                  │
│  ┌────────────┐  ┌────────────┐  ┌────────────┐                 │
│  │  Screens   │  │  Widgets   │  │ ViewModels │                 │
│  └────────────┘  └────────────┘  └────────────┘                 │
├──────────────────────────────────────────────────────────────────┤
│                       State Layer                                 │
│  ┌────────────┐  ┌────────────┐  ┌────────────┐                 │
│  │ AuthState  │  │ ApptState  │  │ThemeState  │                 │
│  └────────────┘  └────────────┘  └────────────┘                 │
├──────────────────────────────────────────────────────────────────┤
│                       Data Layer                                  │
│  ┌────────────┐  ┌────────────┐  ┌────────────┐                 │
│  │Repositories│  │  Services  │  │   Models   │                 │
│  └────────────┘  └────────────┘  └────────────┘                 │
├──────────────────────────────────────────────────────────────────┤
│                     External Layer                                │
│  ┌────────────┐  ┌────────────┐  ┌────────────┐                 │
│  │  Firebase  │  │    APIs    │  │Local Store │                 │
│  └────────────┘  └────────────┘  └────────────┘                 │
└──────────────────────────────────────────────────────────────────┘
```

## Architectural Pattern

### MVVM-Like Pattern

QR MeetApp uses a pattern similar to MVVM (Model-View-ViewModel):

- **Model**: Data classes in `lib/data/models/`
- **View**: Flutter widgets and screens in `lib/features/*/`
- **ViewModel/State**: ChangeNotifier classes in `lib/state/`

### Key Principles

1. **Separation of Concerns**: Each layer has a specific responsibility
2. **Dependency Inversion**: High-level modules don't depend on low-level modules
3. **Single Responsibility**: Each class has one reason to change
4. **DRY (Don't Repeat Yourself)**: Shared code is extracted to utilities

## Layer Architecture

### UI Layer

The UI layer consists of screens and widgets that present data to users.

**Location:** `lib/features/` and `lib/core/widgets/`

**Responsibilities:**
- Render UI based on state
- Handle user interactions
- Delegate business logic to state/services

**Structure:**
```
lib/features/
├── appointments/
│   ├── appointments_list_screen.dart
│   └── screens/
│       └── appointment_details_screen.dart
├── auth/
│   ├── login_screen.dart
│   ├── registration_screen.dart
│   └── auth_view_model.dart
├── home/
│   ├── home_screen.dart
│   ├── home_view_model.dart
│   └── widgets/
│       ├── home_app_bar.dart
│       ├── search_section.dart
│       └── upcoming_appointments.dart
```

**Example Screen:**
```dart
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    // Load data on initialization
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final auth = context.read<AuthState>();
      final appt = context.read<AppointmentState>();
      if (auth.currentUser != null) {
        appt.loadAppointments(auth.currentUser!.id);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const HomeAppBar(),
      body: Consumer<AppointmentState>(
        builder: (context, state, _) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          return AppointmentList(appointments: state.appointments);
        },
      ),
    );
  }
}
```

### State Layer

The state layer manages application state using Provider's ChangeNotifier.

**Location:** `lib/state/`

**Responsibilities:**
- Hold and manage application state
- Notify UI of state changes
- Coordinate between UI and data layer

**State Classes:**
```
lib/state/
├── auth_state.dart          # User authentication state
├── appointment_state.dart   # Appointment management state
├── notifications_state.dart # Notification state
└── theme_state.dart         # Theme preferences state
```

**Example State Class:**
```dart
class AppointmentState with ChangeNotifier {
  final _repo = getIt<AppointmentRepository>();

  List<AppointmentModel> _appointments = [];
  bool _isLoading = false;
  String? _error;

  List<AppointmentModel> get appointments => _appointments;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> loadAppointments(String userId) async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      _appointments = await _repo.getUpcomingAppointments(userId);
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
```

### Data Layer

The data layer handles data operations and business logic.

**Location:** `lib/data/`

**Components:**

#### Models
Data transfer objects representing domain entities.

```dart
class AppointmentModel extends Equatable {
  final String id;
  final String title;
  final DateTime startTime;
  // ... other fields

  factory AppointmentModel.fromMap(Map<String, dynamic> map) {
    // Parse from Firestore document
  }

  Map<String, dynamic> toMap() {
    // Serialize for Firestore
  }
}
```

#### Repositories
Handle data persistence and retrieval.

```dart
class AppointmentRepository {
  final FirebaseFirestore _firestore;

  Future<List<AppointmentModel>> getUpcomingAppointments(String userId) async {
    final snapshot = await _firestore
        .collection('appointments')
        .where('hostId', isEqualTo: userId)
        .where('startTime', isGreaterThan: DateTime.now().toIso8601String())
        .get();
    
    return snapshot.docs
        .map((doc) => AppointmentModel.fromMap(doc.data()))
        .toList();
  }
}
```

#### Services
Handle specific business operations.

```dart
class QRService {
  String generateAppointmentQR(AppointmentModel appointment) {
    return json.encode({
      'type': 'appointment',
      'id': appointment.id,
      // ... other data
    });
  }
}
```

### Core Layer

Shared utilities, constants, and widgets.

**Location:** `lib/core/`

```
lib/core/
├── constants/
│   ├── app_colors.dart
│   ├── app_strings.dart
│   └── app_styles.dart
├── enums/
│   └── appointment_status.dart
├── services/
│   └── service_locator.dart
├── theme/
│   └── app_theme.dart
├── utils/
│   ├── connectivity_utils.dart
│   └── date_time_utils.dart
└── widgets/
    ├── buttons/
    ├── cards/
    ├── indicators/
    ├── inputs/
    └── layout/
```

## State Management

### Provider Setup

State is provided at the app root level:

```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  setupServiceLocator();

  final authState = AuthState();
  await authState.checkAuthStatus();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeState()),
        ChangeNotifierProvider.value(value: authState),
        ChangeNotifierProvider(create: (_) => AppointmentState()),
        ChangeNotifierProvider(create: (_) => NotificationsState()),
      ],
      child: MyApp(),
    ),
  );
}
```

### Consuming State

**Using Consumer:**
```dart
Consumer<AppointmentState>(
  builder: (context, state, child) {
    return Text('Appointments: ${state.appointments.length}');
  },
)
```

**Using Selector (for fine-grained rebuilds):**
```dart
Selector<AppointmentState, bool>(
  selector: (_, state) => state.isLoading,
  builder: (context, isLoading, _) {
    return isLoading ? CircularProgressIndicator() : Container();
  },
)
```

**Using context.read (for one-time access):**
```dart
onPressed: () {
  context.read<AppointmentState>().loadAppointments(userId);
}
```

## Dependency Injection

QR MeetApp uses GetIt for service location:

```dart
// lib/core/services/service_locator.dart
final getIt = GetIt.instance;

void setupServiceLocator() {
  // Repositories
  if (!getIt.isRegistered<AppointmentRepository>()) {
    getIt.registerLazySingleton<AppointmentRepository>(
      () => AppointmentRepository(),
    );
  }
  
  // Services can be registered similarly
}
```

**Usage in State:**
```dart
class AppointmentState with ChangeNotifier {
  final _repo = getIt<AppointmentRepository>();
  
  // Use _repo for data operations
}
```

## Navigation Architecture

### Go Router Configuration

```dart
class AppRouter {
  static const String home = '/home';
  static const String booking = '/booking';
  // ... other routes

  static final List<RouteBase> routes = [
    GoRoute(
      path: '/',
      builder: (context, state) => const SplashScreen(),
    ),
    
    // Shell route for persistent bottom navigation
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return Scaffold(
          body: navigationShell,
          bottomNavigationBar: BottomNavBar(
            selectedIndex: navigationShell.currentIndex,
            onDestinationSelected: navigationShell.goBranch,
          ),
        );
      },
      branches: [
        StatefulShellBranch(routes: [/* Home routes */]),
        StatefulShellBranch(routes: [/* Booking routes */]),
        // ... other branches
      ],
    ),
  ];
}
```

### Navigation Patterns

**Declarative navigation:**
```dart
context.go('/home');           // Replace current route
context.push('/details/$id'); // Push onto stack
context.pop();                 // Go back
```

**Nested navigation with parameters:**
```dart
GoRoute(
  path: 'appointments/:id',
  builder: (context, state) {
    final id = state.pathParameters['id']!;
    return AppointmentDetailsScreen(id: id);
  },
)
```

## Data Flow

### Typical Data Flow

```
User Action
    │
    ▼
UI Widget (Screen)
    │
    ▼
State Class (ChangeNotifier)
    │
    ▼
Repository
    │
    ▼
External Service (Firebase/API)
    │
    ▼
Response
    │
    ▼
State Update (notifyListeners)
    │
    ▼
UI Rebuild
```

### Example Flow: Loading Appointments

1. **Screen initializes:**
   ```dart
   @override
   void initState() {
     super.initState();
     context.read<AppointmentState>().loadAppointments(userId);
   }
   ```

2. **State fetches data:**
   ```dart
   Future<void> loadAppointments(String userId) async {
     _isLoading = true;
     notifyListeners();
     
     _appointments = await _repo.getUpcomingAppointments(userId);
     
     _isLoading = false;
     notifyListeners();
   }
   ```

3. **Repository queries Firestore:**
   ```dart
   Future<List<AppointmentModel>> getUpcomingAppointments(String userId) async {
     final snapshot = await _firestore.collection('appointments')...get();
     return snapshot.docs.map((doc) => AppointmentModel.fromMap(doc.data())).toList();
   }
   ```

4. **UI rebuilds with new data:**
   ```dart
   Consumer<AppointmentState>(
     builder: (context, state, _) {
       if (state.isLoading) return LoadingIndicator();
       return AppointmentList(appointments: state.appointments);
     },
   )
   ```

## Error Handling

### State-Level Error Handling

```dart
class AppointmentState with ChangeNotifier {
  String? _error;
  
  String? get error => _error;

  Future<void> loadAppointments(String userId) async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();
      
      _appointments = await _repo.getUpcomingAppointments(userId);
    } catch (e) {
      _error = 'Failed to load appointments: ${e.toString()}';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
```

### UI Error Display

```dart
Consumer<AppointmentState>(
  builder: (context, state, _) {
    if (state.error != null) {
      return ErrorWidget(
        message: state.error!,
        onRetry: () => state.loadAppointments(userId),
      );
    }
    return AppointmentList(appointments: state.appointments);
  },
)
```

## Best Practices

### Do's

✅ Keep widgets stateless when possible  
✅ Use const constructors for performance  
✅ Extract reusable widgets to separate files  
✅ Use meaningful, descriptive names  
✅ Handle loading and error states  
✅ Dispose controllers and subscriptions  
✅ Use async/await for asynchronous operations  

### Don'ts

❌ Don't put business logic in widgets  
❌ Don't access context after async gaps without mounted check  
❌ Don't use setState in StatelessWidget  
❌ Don't ignore exceptions  
❌ Don't hard-code strings or colors  
❌ Don't create unnecessary widget rebuilds  

### Performance Tips

1. **Use Selector for fine-grained rebuilds:**
   ```dart
   Selector<AppointmentState, int>(
     selector: (_, s) => s.appointments.length,
     builder: (_, count, __) => Text('$count appointments'),
   )
   ```

2. **Use const widgets:**
   ```dart
   const SizedBox(height: 16),
   const Divider(),
   ```

3. **Lazy load data:**
   ```dart
   @override
   void initState() {
     super.initState();
     WidgetsBinding.instance.addPostFrameCallback((_) {
       // Load data after first frame
     });
   }
   ```

4. **Use ListView.builder for long lists:**
   ```dart
   ListView.builder(
     itemCount: items.length,
     itemBuilder: (context, index) => ItemWidget(item: items[index]),
   )
   ```
