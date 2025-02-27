class ProjectModel {
  final String id;
  final String title;
  final String description;
  final String location;
  final List<String> imageUrl;

  ProjectModel({
    required this.id,
    required this.title,
    required this.description,
    required this.location,
    required this.imageUrl,
  });

  factory ProjectModel.fromFirestore(Map<String, dynamic> data, String docId) {
    return ProjectModel(
      id: docId,
      title: data['title'] ?? 'No Title',
      description: data['description'] ?? 'No Description',
      location: data['location'] ?? 'No Location',
      imageUrl: (data['imageUrl'] as List?)?.map((e) => e.toString()).toList() ?? [],
    );
  }
}
