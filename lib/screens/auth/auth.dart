import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../home/HomePage.dart';
import 'login.dart';

class Authentication extends StatelessWidget {
  const Authentication({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          return snapshot.hasData ? HomePage() : Login();
        },
      ),
    );
  }
}
