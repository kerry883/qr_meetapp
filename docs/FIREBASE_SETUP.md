# Firebase Setup Guide

This guide provides detailed instructions for setting up Firebase services for QR MeetApp.

## Table of Contents

- [Prerequisites](#prerequisites)
- [Creating a Firebase Project](#creating-a-firebase-project)
- [Adding Platform Apps](#adding-platform-apps)
- [Configuring Firebase Services](#configuring-firebase-services)
- [Security Rules](#security-rules)
- [Environment Configuration](#environment-configuration)
- [Testing Firebase Connection](#testing-firebase-connection)
- [Troubleshooting](#troubleshooting)

## Prerequisites

Before starting, ensure you have:

- A Google account
- Flutter SDK installed
- Firebase CLI installed (`npm install -g firebase-tools`)
- FlutterFire CLI installed (`dart pub global activate flutterfire_cli`)

## Creating a Firebase Project

### Step 1: Access Firebase Console

1. Go to [Firebase Console](https://console.firebase.google.com/)
2. Sign in with your Google account
3. Click **"Create a project"** (or **"Add project"**)

### Step 2: Project Setup

1. **Enter project name:** `qr-meetapp` (or your preferred name)
2. **Enable Google Analytics:** Recommended for production apps
3. **Select Analytics account:** Choose or create one
4. Click **"Create project"**
5. Wait for project creation to complete
6. Click **"Continue"**

## Adding Platform Apps

### Android Setup

#### Step 1: Add Android App

1. In Firebase Console, click the **Android icon** to add an Android app
2. Enter your package name: `com.example.qr_meetapp`
   - Find this in `android/app/build.gradle` under `applicationId`
3. (Optional) Enter app nickname: `QR MeetApp Android`
4. (Optional) Enter SHA-1 certificate:
   ```bash
   cd android
   ./gradlew signingReport
   ```
5. Click **"Register app"**

#### Step 2: Download Configuration

1. Download `google-services.json`
2. Move it to `android/app/google-services.json`

#### Step 3: Verify Android Configuration

Ensure your `android/build.gradle` includes:

```gradle
buildscript {
    dependencies {
        classpath 'com.google.gms:google-services:4.3.15'
    }
}
```

Ensure your `android/app/build.gradle` includes:

```gradle
apply plugin: 'com.google.gms.google-services'

android {
    defaultConfig {
        minSdkVersion 21  // Required for Firebase
    }
}
```

### iOS Setup

#### Step 1: Add iOS App

1. In Firebase Console, click the **iOS icon** to add an iOS app
2. Enter your bundle ID (found in Xcode under `Runner > General > Bundle Identifier`)
3. (Optional) Enter app nickname: `QR MeetApp iOS`
4. Click **"Register app"**

#### Step 2: Download Configuration

1. Download `GoogleService-Info.plist`
2. Open your project in Xcode
3. Right-click on `Runner` folder
4. Select **"Add Files to Runner..."**
5. Add the downloaded plist file
6. Ensure **"Copy items if needed"** is checked

#### Step 3: Configure iOS Capabilities

In Xcode, enable required capabilities:
- **Push Notifications** (for FCM)
- **Background Modes** > **Remote notifications**

### Web Setup (Optional)

1. In Firebase Console, click the **Web icon**
2. Enter app nickname: `QR MeetApp Web`
3. Copy the Firebase configuration object
4. The FlutterFire CLI will handle this automatically

## Configuring Firebase Services

### Firebase Authentication

#### Enable Email/Password Authentication

1. Go to **Authentication** > **Sign-in method**
2. Click **"Email/Password"**
3. Toggle **"Enable"**
4. Click **"Save"**

#### Enable Phone Authentication (Optional)

1. Click **"Phone"** in Sign-in providers
2. Toggle **"Enable"**
3. Add test phone numbers for development
4. Click **"Save"**

### Cloud Firestore

#### Create Database

1. Go to **Firestore Database**
2. Click **"Create database"**
3. Choose mode:
   - **Test mode**: For development (allows all reads/writes for 30 days)
   - **Production mode**: Secure by default
4. Select a location (choose closest to your users)
5. Click **"Enable"**

#### Create Collections

Create the following collections with sample documents:

**appointments collection:**
```javascript
{
  id: "auto-generated",
  title: "Sample Meeting",
  description: "A test appointment",
  hostId: "user123",
  hostName: "John Doe",
  guestId: "user456",
  guestName: "Jane Smith",
  startTime: "2024-01-15T10:00:00.000Z",
  endTime: "2024-01-15T11:00:00.000Z",
  location: "Conference Room A",
  categoryId: "business",
  status: "pending",
  qrCode: null,
  createdAt: "2024-01-01T00:00:00.000Z",
  updatedAt: null
}
```

**users collection:**
```javascript
{
  id: "auto-generated",
  name: "John Doe",
  email: "john@example.com",
  phone: "+1234567890",
  company: "Acme Inc",
  position: "Developer",
  profileImageUrl: null,
  createdAt: "2024-01-01T00:00:00.000Z"
}
```

### Firebase Storage

#### Create Storage Bucket

1. Go to **Storage**
2. Click **"Get started"**
3. Review security rules
4. Select storage location
5. Click **"Done"**

#### Storage Structure

```
/profile_images/{userId}/profile.jpg
/appointment_files/{appointmentId}/{filename}
```

### Firebase Cloud Messaging

#### Configure FCM

1. Go to **Cloud Messaging**
2. Note your **Server key** (for backend integration)

#### iOS APNs Configuration

1. Create an APNs key in [Apple Developer Portal](https://developer.apple.com/)
2. Upload the `.p8` file to Firebase Console
3. Enter Key ID and Team ID

## Security Rules

### Firestore Security Rules

```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    
    // Helper function to check authentication
    function isAuthenticated() {
      return request.auth != null;
    }
    
    // Helper function to check document ownership
    function isOwner(userId) {
      return request.auth.uid == userId;
    }
    
    // Users collection
    match /users/{userId} {
      allow read: if isAuthenticated();
      allow create: if isAuthenticated() && isOwner(userId);
      allow update, delete: if isAuthenticated() && isOwner(userId);
    }
    
    // Appointments collection
    match /appointments/{appointmentId} {
      allow read: if isAuthenticated() && 
        (resource.data.hostId == request.auth.uid || 
         resource.data.guestId == request.auth.uid);
      allow create: if isAuthenticated();
      allow update: if isAuthenticated() && 
        (resource.data.hostId == request.auth.uid);
      allow delete: if isAuthenticated() && 
        (resource.data.hostId == request.auth.uid);
    }
    
    // Categories collection (read-only for authenticated users)
    match /categories/{categoryId} {
      allow read: if isAuthenticated();
      allow write: if false; // Admin only via Firebase Console
    }
  }
}
```

### Storage Security Rules

```javascript
rules_version = '2';
service firebase.storage {
  match /b/{bucket}/o {
    
    // Profile images
    match /profile_images/{userId}/{fileName} {
      allow read: if request.auth != null;
      allow write: if request.auth != null && request.auth.uid == userId
        && request.resource.size < 5 * 1024 * 1024 // 5MB limit
        && request.resource.contentType.matches('image/.*');
    }
    
    // Appointment files
    match /appointment_files/{appointmentId}/{fileName} {
      allow read: if request.auth != null;
      allow write: if request.auth != null
        && request.resource.size < 10 * 1024 * 1024; // 10MB limit
    }
  }
}
```

## Environment Configuration

### Generate Firebase Options

Run the FlutterFire CLI to generate configuration:

```bash
flutterfire configure
```

This creates `lib/firebase_options.dart` with platform-specific configuration.

### Multiple Environments

For different environments (dev, staging, prod), create separate Firebase projects:

```bash
# Development
flutterfire configure --project=qr-meetapp-dev --out=lib/firebase_options_dev.dart

# Staging
flutterfire configure --project=qr-meetapp-staging --out=lib/firebase_options_staging.dart

# Production
flutterfire configure --project=qr-meetapp-prod --out=lib/firebase_options.dart
```

Then use environment variables or build flavors to select the appropriate configuration.

## Testing Firebase Connection

### Verify Configuration

Run the app and check for Firebase initialization:

```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  
  print('Firebase initialized successfully!');
  
  runApp(MyApp());
}
```

### Test Authentication

```dart
// Test anonymous sign-in (enable in Firebase Console first)
try {
  await FirebaseAuth.instance.signInAnonymously();
  print('Signed in anonymously');
} catch (e) {
  print('Auth error: $e');
}
```

### Test Firestore

```dart
// Test Firestore connection
try {
  final snapshot = await FirebaseFirestore.instance
      .collection('appointments')
      .limit(1)
      .get();
  print('Firestore connected! Docs: ${snapshot.docs.length}');
} catch (e) {
  print('Firestore error: $e');
}
```

## Troubleshooting

### Common Issues

#### "No Firebase App '[DEFAULT]' has been created"

**Solution:** Ensure `Firebase.initializeApp()` is called before `runApp()`:

```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}
```

#### "google-services.json not found" (Android)

**Solution:** 
1. Ensure the file is in `android/app/google-services.json`
2. Verify the package name matches your app

#### "GoogleService-Info.plist not found" (iOS)

**Solution:**
1. Open project in Xcode
2. Ensure the plist is added to the Runner target
3. Check "Copy items if needed" when adding

#### "Permission denied" errors

**Solution:** Check your Firestore/Storage security rules match your authentication state.

#### Firestore indexes required

**Solution:** 
1. Check the error message for the index URL
2. Click the link to create the required index
3. Wait for index creation to complete

### Debug Tips

1. **Enable debug logging:**
   ```dart
   FirebaseFirestore.instance.settings = Settings(
     persistenceEnabled: true,
     cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED,
   );
   ```

2. **Use Firebase Emulator Suite for local development:**
   ```bash
   firebase emulators:start
   ```

3. **Check Firebase Console logs** for backend errors

4. **Monitor usage and quotas** in Firebase Console

## Additional Resources

- [Firebase Documentation](https://firebase.google.com/docs)
- [FlutterFire Documentation](https://firebase.flutter.dev/docs/overview)
- [Firebase CLI Reference](https://firebase.google.com/docs/cli)
- [Firestore Security Rules](https://firebase.google.com/docs/firestore/security/get-started)
