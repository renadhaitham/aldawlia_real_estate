import 'package:aldawlia_real_estate/core/theme/my_theme_data.dart';
import 'package:aldawlia_real_estate/screens/home/HomePage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'add_property.dart';

class MyProperties extends StatelessWidget {
  static const String routeName = "/myProperties";

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () => Navigator.popAndPushNamed(context, HomePage.routeName),
        ),
        title: Text("My Properties", style: Theme.of(context).textTheme.bodyLarge),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('properties')
            .where('userId', isEqualTo: user?.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text("No Properties Found."));
          }

          var properties = snapshot.data!.docs;

          return ListView.builder(
            itemCount: properties.length,
            itemBuilder: (context, index) {
              var property = properties[index].data() as Map<String, dynamic>;

              return Card(
                margin: EdgeInsets.all(8),
                child: ListTile(
                  leading: Icon(Icons.home, size: 50),
                  title: Text(property['p_name'] ?? "No Name"),
                  subtitle: Text(property['location'] ?? "No Location"),
                  trailing: Text(
                    property['status'] ?? "Unknown",
                    style: TextStyle(
                      color: property['status'] == "For Sale" ? Colors.green : Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onTap: () {},
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AddProperty()),
        ),
        child: Icon(Icons.add),
        tooltip: "Add Property",
      ),
    );
  }
}