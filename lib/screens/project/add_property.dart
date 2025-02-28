import 'package:aldawlia_real_estate/Widgets/custom_button.dart';
import 'package:aldawlia_real_estate/Widgets/custom_text_field.dart';
import 'package:aldawlia_real_estate/core/theme/my_theme_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AddProperty extends StatefulWidget {
  @override
  _AddPropertyState createState() => _AddPropertyState();
}

class _AddPropertyState extends State<AddProperty> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  String _status = 'For Sale';
  String? _selectedProjectId;
  List<Map<String, dynamic>> _projects = [];
  bool _isLoadingProjects = true;

  @override
  void initState() {
    super.initState();
    _fetchProjects();
  }

  Future<void> _fetchProjects() async {
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('projects').get();
      if (mounted) {
        setState(() {
          _projects = snapshot.docs.map((doc) => {
            "id": doc.id,
            "name": doc['project_name']
          }).toList();
          _isLoadingProjects = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoadingProjects = false);
      }
    }
  }

  void _addProperty() async {
    if (_formKey.currentState!.validate() && _selectedProjectId != null) {
      User? user = FirebaseAuth.instance.currentUser;
      await FirebaseFirestore.instance.collection('properties').add({
        'id': DateTime.now().millisecondsSinceEpoch.toString(),
        'userId': user?.uid,
        'p_name': _nameController.text.trim(),
        'location': _locationController.text.trim(),
        'status': _status,
        'projectId': _selectedProjectId,
        'createdAt': FieldValue.serverTimestamp(),
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Property added successfully!")),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Property", style: Theme.of(context).textTheme.bodyLarge),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(26.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextField(
                controller: _nameController,
                labelText: "Property Name",
                obscureText: false,
                validator: (value) => value!.isEmpty ? "Enter property name" : null,
              ),
              SizedBox(height: 15),
              CustomTextField(
                controller: _locationController,
                labelText: "Location",
                obscureText: false,
                validator: (value) => value!.isEmpty ? "Enter location" : null,
              ),
              SizedBox(height: 15),
              DropdownButtonFormField<String>(
                dropdownColor: MyThemeData.whiteColor,
                value: _status,
                items: ["For Sale", "For Rent"].map((status) =>
                    DropdownMenuItem(value: status, child: Text(status))).toList(),
                onChanged: (value) => setState(() => _status = value!),
                decoration: InputDecoration(
                  labelText: "Status",
                  contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: MyThemeData.primary),
                  ),
                ),
                focusColor: MyThemeData.darky,
              ),
              SizedBox(height: 15),
              _isLoadingProjects
                  ? Center(child: CircularProgressIndicator())
                  : DropdownButtonFormField<String>(
                value: _projects.isNotEmpty ? _selectedProjectId : null,
                items: _projects.map((project) => DropdownMenuItem<String>(
                  value: project["id"].toString(),
                  child: Text(project["name"].toString(),
                      style: Theme.of(context).textTheme.bodySmall),
                )).toList(),
                onChanged: _projects.isEmpty ? null : (String? newValue) {
                  setState(() {
                    _selectedProjectId = newValue;
                  });
                },
                decoration: InputDecoration(
                  labelText: _isLoadingProjects ? "Loading Projects..." : "Select Project",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: MyThemeData.darky),
                  ),
                  contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                ),
                validator: (value) => value == null ? "Please select a project" : null,
                dropdownColor: MyThemeData.darky,
              ),
              SizedBox(height: 25),
              Center(
                child: CustomButton(text: "Add Property", onTap: _addProperty),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
