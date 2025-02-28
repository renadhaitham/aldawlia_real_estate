import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthProvider with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User? get user => _auth.currentUser;

  AuthProvider() {
    _auth.authStateChanges().listen((User? user) {
      notifyListeners();
    });
  }

  Future<void> _saveUserToFirestore(User user, {String? phoneNumber}) async {
    final userDoc = FirebaseFirestore.instance.collection('users').doc(user.uid);
    final snapshot = await userDoc.get();

    if (!snapshot.exists) {
      await userDoc.set({
        'uid': user.uid,
        'email': user.email,
        'displayName': user.displayName ?? '',
        'createdAt': FieldValue.serverTimestamp(),
        'propertyIds': [],
        'phoneNumber': phoneNumber ?? user.phoneNumber ?? '',
        'profileImageUrl': user.photoURL ?? '',
      });
    }
  }

  Future<UserCredential?> signUp(String name, String email, String password, String phone) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );

      User? user = userCredential.user;
      if (user != null) {
        await user.updateDisplayName(name.trim());
        await _saveUserToFirestore(user, phoneNumber: phone);
        notifyListeners();
        return userCredential;
      }
    } catch (e) {
      throw Exception("Sign Up Failed: ${e.toString()}");
    }
    return null;
  }

  Future<void> signIn(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email.trim(), password: password.trim());
      notifyListeners();
    } catch (e) {
      throw Exception("Sign In Failed: ${e.toString()}");
    }
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();
      await GoogleSignIn().signOut();
      notifyListeners();
    } catch (e) {
      print("Sign Out Error: $e");
    }
  }

  Future<UserCredential?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) return null;

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential userCredential = await _auth.signInWithCredential(credential);
      User? user = userCredential.user;

      if (user != null) {
        await _saveUserToFirestore(user);
      }

      notifyListeners();
      return userCredential;
    } catch (e) {
      print("Google Sign-In Failed: $e");
      throw Exception("Google Sign-In Failed: ${e.toString()}");
    }
  }

}
