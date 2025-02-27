import 'package:aldawlia_real_estate/Widgets/custom_button.dart';
import 'package:aldawlia_real_estate/Widgets/custom_text_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../Widgets/calender.dart';

class ServiceRequest extends StatefulWidget {
  final String selectedService;

  const ServiceRequest({Key? key, required this.selectedService}) : super(key: key);

  @override
  _ServiceRequestState createState() => _ServiceRequestState();
}

class _ServiceRequestState extends State<ServiceRequest> {
  final _formKey = GlobalKey<FormState>();
  String? _propertyAddress;
  String? _description;
  DateTime? _selectedDate;

  void _submitRequest() async {
    if (!_formKey.currentState!.validate()) return;

    _formKey.currentState!.save();
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    await FirebaseFirestore.instance.collection('service_requests').add({
      'userId': user.uid,
      'serviceType': widget.selectedService,
      'propertyAddress': _propertyAddress,
      'description': _description,
      'preferredDate': _selectedDate?.toIso8601String(),
      'status': 'Pending',
      'createdAt': Timestamp.now(),
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Service request submitted successfully!')),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Request a Service', style: Theme.of(context).textTheme.bodyLarge)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(widget.selectedService, style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 10),
                CustomTextField(
                  labelText: 'Property Address',
                  obscureText: false,
                  onSaved: (value) => _propertyAddress = value,
                  validator: (value) => value!.isEmpty ? 'Enter property address' : null,
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  labelText: 'Description',
                  obscureText: false,
                  onSaved: (value) => _description = value,
                  validator: (value) => value!.isEmpty ? 'Enter a description' : null,
                  maxLines: null,
                ),
                const SizedBox(height: 30),
                CustomButton(
                  text: _selectedDate == null
                      ? 'Pick a Date'
                      : 'Date: ${_selectedDate!.toLocal()}'.split(' ')[0],
                  onTap: () async {
                    DateTime? pickedDate = await myCalendar(context);
                    if (pickedDate != null) {
                      setState(() => _selectedDate = pickedDate);
                    }
                  },
                ),
                const SizedBox(height: 20),
                CustomButton(text: "Submit Request", onTap: _submitRequest),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
