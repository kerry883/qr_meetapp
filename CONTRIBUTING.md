# Contributing to QR MeetApp

Thank you for your interest in contributing to QR MeetApp! This document provides guidelines and instructions for contributing to the project.

## Table of Contents

- [Code of Conduct](#code-of-conduct)
- [Getting Started](#getting-started)
- [Development Setup](#development-setup)
- [Making Changes](#making-changes)
- [Pull Request Process](#pull-request-process)
- [Coding Standards](#coding-standards)
- [Testing Guidelines](#testing-guidelines)
- [Documentation](#documentation)

## Code of Conduct

By participating in this project, you agree to maintain a respectful and inclusive environment. We expect all contributors to:

- Be respectful of differing viewpoints and experiences
- Accept constructive criticism gracefully
- Focus on what is best for the community
- Show empathy towards other community members

## Getting Started

### Prerequisites

Before contributing, ensure you have:

- Flutter SDK (>=3.0.0 <4.0.0) installed
- Dart SDK
- An IDE (Android Studio, VS Code, or IntelliJ)
- Git for version control
- A GitHub account

### Fork and Clone

1. Fork the repository on GitHub
2. Clone your fork locally:
   ```bash
   git clone https://github.com/YOUR_USERNAME/qr_meetapp.git
   cd qr_meetapp
   ```
3. Add the upstream remote:
   ```bash
   git remote add upstream https://github.com/ORIGINAL_OWNER/qr_meetapp.git
   ```

## Development Setup

1. **Install dependencies:**
   ```bash
   flutter pub get
   ```

2. **Configure Firebase:**
   - Follow the Firebase setup instructions in README.md
   - Create your own Firebase project for development

3. **Run the app:**
   ```bash
   flutter run
   ```

4. **Run tests:**
   ```bash
   flutter test
   ```

## Making Changes

### Branch Naming Convention

Create a branch with a descriptive name:

- `feature/` - New features (e.g., `feature/add-calendar-view`)
- `fix/` - Bug fixes (e.g., `fix/login-validation`)
- `docs/` - Documentation updates (e.g., `docs/update-readme`)
- `refactor/` - Code refactoring (e.g., `refactor/appointment-service`)
- `test/` - Test additions or updates (e.g., `test/auth-state`)

### Workflow

1. **Sync with upstream:**
   ```bash
   git fetch upstream
   git checkout main
   git merge upstream/main
   ```

2. **Create a feature branch:**
   ```bash
   git checkout -b feature/your-feature-name
   ```

3. **Make your changes:**
   - Write clean, well-documented code
   - Follow the coding standards
   - Add tests for new functionality

4. **Commit your changes:**
   ```bash
   git add .
   git commit -m "feat: add your feature description"
   ```

5. **Push to your fork:**
   ```bash
   git push origin feature/your-feature-name
   ```

6. **Open a Pull Request**

## Pull Request Process

### Before Submitting

- [ ] Code compiles without errors
- [ ] All tests pass (`flutter test`)
- [ ] Code follows the project's style guidelines
- [ ] Documentation is updated if needed
- [ ] Commit messages follow the conventional format

### PR Description Template

```markdown
## Description
Brief description of the changes.

## Type of Change
- [ ] Bug fix
- [ ] New feature
- [ ] Breaking change
- [ ] Documentation update

## Testing
Describe how you tested your changes.

## Screenshots (if applicable)
Add screenshots for UI changes.

## Checklist
- [ ] My code follows the project's style guidelines
- [ ] I have performed a self-review of my code
- [ ] I have added tests that prove my fix/feature works
- [ ] New and existing tests pass locally
```

### Review Process

1. At least one maintainer must review and approve the PR
2. All CI checks must pass
3. Conflicts with the base branch must be resolved
4. Reviewers may request changes before approval

## Coding Standards

### Dart/Flutter Style Guide

Follow the official [Dart style guide](https://dart.dev/guides/language/effective-dart/style):

- Use `lowerCamelCase` for variables and functions
- Use `UpperCamelCase` for classes and types
- Use `lowercase_with_underscores` for file names
- Prefer `const` constructors where possible
- Use meaningful, descriptive names

### File Organization

```dart
// 1. Imports (sorted alphabetically within groups)
import 'dart:async';                    // Dart imports
import 'package:flutter/material.dart'; // Flutter imports
import 'package:provider/provider.dart'; // Package imports
import '../models/user_model.dart';     // Relative imports

// 2. Constants (if any)

// 3. Class definition
class MyWidget extends StatelessWidget {
  // Fields
  final String title;

  // Constructor
  const MyWidget({super.key, required this.title});

  // Build method
  @override
  Widget build(BuildContext context) {
    // ...
  }

  // Private methods
  Widget _buildContent() {
    // ...
  }
}
```

### Widget Guidelines

- Keep widgets small and focused
- Extract reusable widgets to separate files
- Use `const` widgets when possible
- Prefer composition over inheritance

### State Management

- Use Provider for global state
- Keep state classes in the `state/` directory
- Call `notifyListeners()` after state changes
- Avoid direct UI manipulation in state classes

### Error Handling

```dart
try {
  await someAsyncOperation();
} catch (e) {
  // Log the error
  debugPrint('Error: $e');
  // Handle gracefully
  setError(e.toString());
}
```

## Testing Guidelines

### Unit Tests

Test individual functions and classes:

```dart
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('UserModel', () {
    test('should create from map', () {
      final map = {'id': '1', 'name': 'Test', 'email': 'test@example.com'};
      final user = UserModel.fromMap(map);
      expect(user.name, 'Test');
    });
  });
}
```

### Widget Tests

Test widget rendering and interactions:

```dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('should display title', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(home: MyWidget(title: 'Test')),
    );
    expect(find.text('Test'), findsOneWidget);
  });
}
```

### Test File Naming

- Place tests in the `test/` directory
- Mirror the `lib/` directory structure
- Use `_test.dart` suffix for test files

## Documentation

### Code Comments

- Add doc comments to public APIs
- Explain complex logic with inline comments
- Keep comments up to date with code changes

```dart
/// A service for handling QR code operations.
///
/// This service provides methods to generate and scan QR codes
/// for appointments and user profiles.
class QRService {
  /// Generates a QR code string for the given [appointment].
  ///
  /// Returns a JSON-encoded string suitable for QR code generation.
  String generateAppointmentQR(AppointmentModel appointment) {
    // Implementation
  }
}
```

### README Updates

Update the README when:
- Adding new features
- Changing configuration requirements
- Modifying the project structure
- Adding new dependencies

## Questions or Issues?

If you have questions or run into issues:

1. Check existing [Issues](https://github.com/ORIGINAL_OWNER/qr_meetapp/issues)
2. Search closed issues for similar problems
3. Open a new issue with detailed information

Thank you for contributing to QR MeetApp! 🎉
