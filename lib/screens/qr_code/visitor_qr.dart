import 'dart:io';

import 'package:aldawlia_real_estate/Widgets/custom_button.dart';
import 'package:aldawlia_real_estate/Widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:share_plus/share_plus.dart';

import '../../Widgets/calender.dart';
import '../../core/theme/my_theme_data.dart';

class VisitorQr extends StatefulWidget {
  static const String routeName = "/visitorQr";

  const VisitorQr({super.key});

  @override
  State<VisitorQr> createState() => _VisitorQrState();
}

class _VisitorQrState extends State<VisitorQr> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  DateTime? _selectedDate;
  String? _qrData;

  void _generateQrCode() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _qrData =
            "${_nameController.text}|${_selectedDate.toString()}|${_addressController.text}";
      });
    }
  }

  Future<void> _shareQrCode() async {
    if (_qrData == null) return;

    try {
      final tempDir = await getTemporaryDirectory();
      final file = File('${tempDir.path}/visitor_qr.png');

      final qrPainter = QrPainter(
        data: _qrData!,
        version: QrVersions.auto,
        color: Color(0xFF000000),
        gapless: true,
      );

      final picData = await qrPainter.toImageData(200);
      final buffer = picData!.buffer.asUint8List();
      await file.writeAsBytes(buffer);

      Share.shareXFiles([XFile(file.path)], text: "My Visitor QR Code");
    } catch (e) {
      print("Error sharing QR Code: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to share QR Code.")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Visitor QR Code",
              style: Theme.of(context).textTheme.bodyLarge)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(0.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    CustomTextField(
                      controller: _nameController,
                      labelText: "Visitor Name",
                      obscureText: false,
                      validator: (value) =>
                          value!.isEmpty ? "Enter visitor name" : null,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    CustomTextField(
                      controller: _addressController,
                      labelText: "Property Address",
                      obscureText: false,
                      validator: (value) =>
                          value!.isEmpty ? "Enter property address" : null,
                    ),
                    SizedBox(height: 30),
                    CustomButton(
                      text: _selectedDate == null
                          ? "Pick Visit Date"
                          : "Date: ${_selectedDate!.toLocal()}".split(' ')[0],
                      onTap: () async {
                        DateTime? pickedDate = await myCalendar(context);
                        if (pickedDate != null) {
                          setState(() {
                            _selectedDate = pickedDate;
                          });
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: MyThemeData.blackColor,
                  textStyle: Theme.of(context).textTheme.displaySmall),
              onPressed: _generateQrCode,
              child: Text("Visitor QR Code"),
            ),
            SizedBox(height: 10),
            if (_qrData != null)
              Column(
                children: [
                  QrImageView(data: _qrData!, size: 200),
                  SizedBox(height: 5),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: MyThemeData.blackColor,
                        textStyle: Theme.of(context).textTheme.displaySmall),
                    onPressed: _shareQrCode,
                    child: Text("Share QR Code"),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
