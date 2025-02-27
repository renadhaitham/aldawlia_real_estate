import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserProvider with ChangeNotifier {
  String? userId;
  String? propertyAddress;

  UserProvider() {
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user == null) return;

      userId = user.uid;

      DocumentSnapshot<Map<String, dynamic>> userDoc =
      await FirebaseFirestore.instance.collection('users').doc(userId).get();

      if (userDoc.exists) {
        propertyAddress = userDoc.data()?['address'] ?? '';
      }

      notifyListeners();
    } catch (e) {
      debugPrint('Error fetching user data: $e');
    }
  }
}
