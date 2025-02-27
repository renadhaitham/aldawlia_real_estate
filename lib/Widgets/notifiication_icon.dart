import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../core/theme/my_theme_data.dart';

class NotificationIcon extends StatelessWidget {
  final String userId;

  const NotificationIcon({super.key, required this.userId});

  Stream<QuerySnapshot> getUserNotifications() {
    return FirebaseFirestore.instance
        .collection('notifications')
        .where('userId', isEqualTo: userId)
        .orderBy('deliverdAt', descending: true)
        .snapshots();
  }

  Future<void> markAsRead(String notificationId) async {
    await FirebaseFirestore.instance
        .collection('notifications')
        .doc(notificationId)
        .update({'status': 'read'});
  }

  Future<void> deleteNotification(String notificationId) async {
    await FirebaseFirestore.instance
        .collection('notifications')
        .doc(notificationId)
        .delete();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: getUserNotifications(),
      builder: (context, snapshot) {
        int unreadCount = snapshot.hasData
            ? snapshot.data!.docs.where((doc) => doc['status'] == 'unread').length
            : 0;

        return PopupMenuButton(
          icon: Stack(
            children: [
              const Icon(
                Icons.notifications_none_outlined,
                size: 30,
              ),
              if (unreadCount > 0)
                Positioned(
                  right: 0,
                  top: 0,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      '$unreadCount',
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(color: MyThemeData.whiteColor),
                    ),
                  ),
                ),
            ],
          ),
          itemBuilder: (context) {
            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return [
                PopupMenuItem(
                  child: Text("No notifications",
                      style: Theme.of(context).textTheme.titleSmall),
                ),
              ];
            }

            return snapshot.data!.docs.map((doc) {
              var data = doc.data() as Map<String, dynamic>;
              return PopupMenuItem(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: MyThemeData.whiteColor,
                  ),
                  child: ListTile(
                    title: Text(data['notification']),
                    subtitle: Text(data['status']),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () => deleteNotification(doc.id),
                    ),
                    onTap: () => markAsRead(doc.id),
                  ),
                ),
              );
            }).toList();
          },
        );
      },
    );
  }
}
