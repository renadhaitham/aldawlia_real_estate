import 'package:aldawlia_real_estate/core/theme/my_theme_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyRequests extends StatelessWidget {
  static const String routeName = "/myService";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('service_requests')
            .where('userId', isEqualTo: FirebaseAuth.instance.currentUser?.uid)
            .orderBy('createdAt', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No service requests found.'));
          }

          var requests = snapshot.data!.docs;

          return ListView.builder(
            itemCount: requests.length,
            itemBuilder: (context, index) {
              var request = requests[index].data() as Map<String, dynamic>;
              return Card(
                color: MyThemeData.whiteColor,
                margin: EdgeInsets.all(8.0),
                child: ListTile(
                  title: Text(request['serviceType'],
                      style: Theme.of(context).textTheme.bodyMedium),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Address: ${request['propertyAddress']}',
                          style: Theme.of(context).textTheme.bodySmall),
                      Text('Preferred Date: ${request['preferredDate']}',
                          style: Theme.of(context).textTheme.bodySmall),
                      Text('Status: ${request['status']}',
                          style: TextStyle(
                            color: request['status'] == 'Approved'
                                ? Colors.green
                                : request['status'] == 'Rejected'
                                ? Colors.red
                                : Colors.orange,
                            fontWeight: FontWeight.bold,
                          )),
                    ],
                  ),
                  trailing: request['status'] == 'Pending'
                      ? CircularProgressIndicator()
                      : Icon(
                    request['status'] == 'Approved'
                        ? Icons.check_circle
                        : Icons.cancel,
                    color: request['status'] == 'Approved'
                        ? Colors.green
                        : Colors.red,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
