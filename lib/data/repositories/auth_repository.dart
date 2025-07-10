import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:qr_meetapp/data/models/user_model.dart';

class AuthRepository {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firestore;

  AuthRepository({
    FirebaseAuth? firebaseAuth,
    FirebaseFirestore? firestore,
  })  : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _firestore = firestore ?? FirebaseFirestore.instance;

  
  /// Login with email and password
  Future<UserModel> login(String email, String password) async {
    try {
      final credential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      
      if (credential.user != null) {
        return await _getUserFromFirestore(credential.user!.uid);
      } else {
        throw Exception('Login failed');
      }
    } on FirebaseAuthException catch (e) {
      throw Exception(_getAuthErrorMessage(e.code));
    } catch (e) {
      throw Exception('Login failed: $e');
    }
  }

  /// Register with email and password
  Future<UserModel> register(String email, String password, String name) async {
    try {
      final credential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      
      if (credential.user != null) {
        // Update display name
        await credential.user!.updateDisplayName(name);
        
        // Create user document in Firestore
        final user = UserModel(
          id: credential.user!.uid,
          name: name,
          email: email,
          createdAt: DateTime.now(),
        );
        
        await _firestore.collection('users').doc(user.id).set(user.toMap());
        
        return user;
      } else {
        throw Exception('Registration failed');
      }
    } on FirebaseAuthException catch (e) {
      throw Exception(_getAuthErrorMessage(e.code));
    } catch (e) {
      throw Exception('Registration failed: $e');
    }
  }

  /// Logout current user
  Future<void> logout() async {
    try {
      await _firebaseAuth.signOut();
    } catch (e) {
      throw Exception('Logout failed: $e');
    }
  }

  /// Reset password
  Future<void> resetPassword(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw Exception(_getAuthErrorMessage(e.code));
    } catch (e) {
      throw Exception('Password reset failed: $e');
    }
  }

  /// Check if user is authenticated
  Future<bool> isAuthenticated() async {
    return _firebaseAuth.currentUser != null;
  }

  /// Get current user
  User? get currentUser => _firebaseAuth.currentUser;

  /// Check onboarding status
  Future<bool> checkOnboardingStatus() async {
    // For now, assume onboarding is always complete
    // You can implement this based on your app's logic
    return true;
  }

  /// Set onboarding as complete
  Future<void> setOnboardingComplete() async {
    // Implementation depends on your app's logic
    // You might want to store this in SharedPreferences or Firestore
  }

  /// Get user from Firestore
  Future<UserModel> _getUserFromFirestore(String userId) async {
    try {
      final doc = await _firestore.collection('users').doc(userId).get();
      if (doc.exists && doc.data() != null) {
        return UserModel.fromMap(doc.data()!);
      } else {
        // Create a new user document if it doesn't exist
        final user = UserModel(
          id: userId,
          name: _firebaseAuth.currentUser?.displayName ?? '',
          email: _firebaseAuth.currentUser?.email ?? '',
          createdAt: DateTime.now(),
        );
        await _firestore.collection('users').doc(userId).set(user.toMap());
        return user;
      }
    } catch (e) {
      throw Exception('Failed to get user data: $e');
    }
  }

  /// Get user-friendly error messages
  String _getAuthErrorMessage(String code) {
    switch (code) {
      case 'user-not-found':
        return 'No user found with this email';
      case 'wrong-password':
        return 'Incorrect password';
      case 'email-already-in-use':
        return 'Email is already registered';
      case 'weak-password':
        return 'Password is too weak';
      case 'invalid-email':
        return 'Invalid email address';
      case 'user-disabled':
        return 'This account has been disabled';
      case 'too-many-requests':
        return 'Too many failed attempts. Try again later';
      default:
        return 'Authentication failed. Please try again';
    }
  }
}
