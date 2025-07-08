import 'dart:io'; // Needed for File
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:qr_meetapp/data/models/user_model.dart';

class ProfileRepository {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _firebaseAuth;
  final FirebaseStorage _storage;

  ProfileRepository({
    FirebaseFirestore? firestore,
    FirebaseAuth? auth,
    FirebaseStorage? storage,
  })  : _firestore = firestore ?? FirebaseFirestore.instance,
        _firebaseAuth = auth ?? FirebaseAuth.instance,
        _storage = storage ?? FirebaseStorage.instance;

  CollectionReference get _usersCollection => _firestore.collection('users');

  Future<UserModel> getUserProfile(String userId) async {
    try {
      final doc = await _usersCollection.doc(userId).get();
      if (doc.exists) {
        final data = doc.data();
        if (data != null) {
          return UserModel.fromMap(data as Map<String, dynamic>);
        } else {
          throw Exception('Document exists but has no data');
        }
      } else {
        return UserModel(
          id: userId,
          name: _firebaseAuth.currentUser?.displayName ?? '',
          email: _firebaseAuth.currentUser?.email ?? '',
          createdAt: DateTime.now(),
        );
      }
    } catch (e) {
      throw Exception('Failed to get user profile: $e');
    }
  }

  Future<void> updateUserProfile(UserModel user) async {
    try {
      await _usersCollection.doc(user.id).set(user.toMap(), SetOptions(merge: true));

      // Update Firebase Auth profile if name changed
      if (_firebaseAuth.currentUser != null &&
          _firebaseAuth.currentUser!.displayName != user.name) {
        await _firebaseAuth.currentUser!.updateDisplayName(user.name);
      }
    } catch (e) {
      throw Exception('Failed to update profile: $e');
    }
  }

  Future<String> uploadProfileImage(String userId, String filePath) async {
    try {
      final ref = _storage.ref().child('profile_images/$userId.jpg');
      final file = File(filePath); // <-- FIX: Convert filePath to File
      await ref.putFile(file);
      return await ref.getDownloadURL();
    } catch (e) {
      throw Exception('Failed to upload profile image: $e');
    }
  }

  Future<void> deleteAccount(String userId) async {
    try {
      // Delete user data
      await _usersCollection.doc(userId).delete();

      // Delete authentication account
      if (_firebaseAuth.currentUser != null) {
        await _firebaseAuth.currentUser!.delete();
      }
    } catch (e) {
      throw Exception('Failed to delete account: $e');
    }
  }

  Future<int> getAppointmentCount(String userId) async {
    try {
      final snapshot = await _firestore
          .collection('appointments')
          .where('hostId', isEqualTo: userId)
          .get();

      return snapshot.docs.length;
    } catch (e) {
      throw Exception('Failed to get appointment count: $e');
    }
  }

  Future<List<UserModel>> searchUsers(String query) async {
    try {
      final nameQuery = _usersCollection
          .where('name', isGreaterThanOrEqualTo: query)
          .where('name', isLessThan: query + 'z')
          .limit(10);

      final emailQuery = _usersCollection
          .where('email', isGreaterThanOrEqualTo: query)
          .where('email', isLessThan: query + 'z')
          .limit(10);

      final results = await Future.wait([
        nameQuery.get(),
        emailQuery.get(),
      ]);

      final users = <UserModel>[];

      for (final snapshot in results) {
        for (final doc in snapshot.docs) {
          final data = doc.data();
          if (data != null) {
            users.add(UserModel.fromMap(data as Map<String, dynamic>));
          } else {
            // Handle the case where the document exists but has no data
            throw Exception('Document exists but has no data');
          }
        }
      }

      // Remove duplicates using user ID
      final uniqueUsers = {
        for (var u in users) u.id: u,
      }.values.toList();

      return uniqueUsers;
    } catch (e) {
      throw Exception('Failed to search users: $e');
    }
  }
}