import 'package:aldawlia_real_estate/models/project_model.dart';
import 'package:flutter/material.dart';

class ProjectDetails extends StatelessWidget {
  static const String routeName = "/project";
  final ProjectModel project;

  const ProjectDetails({Key? key, required this.project}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(project.title, style: Theme
          .of(context)
          .textTheme
          .bodyLarge,)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (project.imageUrl.isNotEmpty)
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  project.imageUrl[0],
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            const SizedBox(height: 16),
            Text(
              project.title,
              style: Theme
                  .of(context)
                  .textTheme
                  .bodyLarge,
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 379),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      project.description,
                      style: Theme
                          .of(context)
                          .textTheme
                          .titleMedium,
                      textAlign: TextAlign.justify,
                      overflow: TextOverflow.ellipsis,
                      softWrap: true,
                      maxLines: 20,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
              const Icon(Icons.location_on, color: Colors.red),
              Text("Location:",style: Theme.of(context).textTheme.titleMedium,)
            ],),
            Text(
              project.location,
              style: Theme
                  .of(context)
                  .textTheme
                  .bodyMedium,
              overflow: TextOverflow.ellipsis,
              softWrap: true,
              maxLines: 2,

            ),

          ],
        ),
      ),
    );
  }


}
