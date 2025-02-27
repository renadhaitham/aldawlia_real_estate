import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:qr_flutter/qr_flutter.dart';

class OwnerQr extends StatefulWidget {
  static const String routeName = "/ownerQr";

  @override
  _OwnerQrState createState() => _OwnerQrState();
}

class _OwnerQrState extends State<OwnerQr> {
  String? _qrData;

  @override
  void initState() {
    super.initState();
    _generateQrCode();
  }

  Future<void> _generateQrCode() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    final snapshot = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
    if (!snapshot.exists) return;

    final userData = snapshot.data();
    if (userData == null) return;

    setState(() {
      _qrData = "Owner: ${user.displayName ?? 'Unknown'} | Properties: ${userData['propertyIds'] ?? 'None'}";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Owner QR Code", style: Theme.of(context).textTheme.bodyLarge)),
      body: Center(
        child: _qrData == null
            ? CircularProgressIndicator()
            : Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            QrImageView(data: _qrData!, size: 200),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
