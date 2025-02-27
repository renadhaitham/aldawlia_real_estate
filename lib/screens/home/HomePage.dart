
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../Widgets/Side menu.dart';
import '../../Widgets/aldawlia_logo.dart';
import '../../Widgets/notifiication_icon.dart';
import '../../core/theme/my_theme_data.dart';
import '../../models/project_model.dart';
import '../project/project_details.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  static const String routeName = "/home";
  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NavBar(),
      backgroundColor: MyThemeData.primary,
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: NotificationIcon(userId: user.uid),
          )
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await Future.delayed(const Duration(seconds: 1));
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              const DawliaLogo(),
              _buildSectionTitle("New Announcement"),
              _buildAnnouncementsSection(context),
              _buildSectionTitle("Our Projects"),
              _buildProjectsSection(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Row(
      children: [
        Expanded(child: Divider(thickness: 1, color: MyThemeData.yellowColor, indent: 30, endIndent: 20)),
        Text(title, style: MyThemeData.lightTheme.textTheme.bodyMedium),
        Expanded(child: Divider(thickness: 1, color: MyThemeData.yellowColor, indent: 30, endIndent: 20)),
      ],
    );
  }

  Widget _buildAnnouncementsSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('announcements').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return const Center(child: Text("Error loading announcements"));
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(
              child: Text("No Announcements Available", style: Theme.of(context).textTheme.bodySmall),
            );
          }

          var announcements = snapshot.data!.docs;
          return ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: announcements.length,
            itemBuilder: (context, index) {
              var announcement = announcements[index].data() as Map<String, dynamic>;
              return _buildAnnouncementCard(context,announcement);
            },
          );
        },
      ),
    );
  }

  Widget _buildAnnouncementCard(BuildContext context,Map<String, dynamic> announcement) {
    return Card(
      color: MyThemeData.whiteColor,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
            child: Image.network(
              announcement['imageUrl'],
              width: double.infinity,
              height: 150,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(announcement['title'], style:Theme.of(context).textTheme.bodyMedium),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
            child: Text(
              announcement['description'],
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProjectsSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('Projects').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return const Center(child: Text("Error loading projects"));
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(
              child: Text("No Available Projects", style: Theme.of(context).textTheme.bodySmall),
            );
          }

          var projects = snapshot.data!.docs;
          return SizedBox(
            height: 250,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: projects.length,
              itemBuilder: (context, index) {
                var project = projects[index].data() as Map<String, dynamic>;
                return _buildProjectCard(context, project, projects[index].id);
              },
            ),
          );
        },
      ),
    );
  }

  Widget _buildProjectCard(BuildContext context, Map<String, dynamic> project, String docId) {
    return GestureDetector(
      onTap: () {
        var selectedProject = ProjectModel.fromFirestore(project, docId);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ProjectDetails(project: selectedProject)),
        );
      },
      child: Card(
        color: MyThemeData.whiteColor,
        margin: const EdgeInsets.symmetric(horizontal: 10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
              child: Image.network(
                project['imageUrl'][0],
                width: 200,
                height: 150,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(project['title'], style: Theme.of(context).textTheme.bodyMedium),
                  const SizedBox(height: 4),
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 200),
                    child: Text(
                      project['description'],
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
