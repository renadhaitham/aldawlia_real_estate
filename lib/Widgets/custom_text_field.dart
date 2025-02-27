import 'package:flutter/material.dart';
import 'package:aldawlia_real_estate/core/theme/my_theme_data.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String labelText;
  final bool obscureText;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final void Function(String?)? onSaved;
  final void Function(String?)? onChanged;
  final int? maxLines;

  const CustomTextField({
    super.key,
    this.controller,
    required this.labelText,
    required this.obscureText,
    this.keyboardType,
    this.validator,
    this.onSaved,
    this.onChanged,
    this.maxLines,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        cursorColor: Colors.grey[500],
        keyboardType: keyboardType,
        maxLines: obscureText ? 1 : (maxLines ?? 1),
        validator: validator,
        onSaved: onSaved,
        onChanged: onChanged,
        style: Theme.of(context).textTheme.bodySmall,
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: Theme.of(context).textTheme.bodyMedium,
          filled: true,
          fillColor: MyThemeData.primary,
          border: _borderStyle(MyThemeData.primary),
          focusedBorder: _borderStyle(MyThemeData.darky, width: 2),
        ),
      ),
    );
  }

  OutlineInputBorder _borderStyle(Color color, {double width = 1}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(20),
      borderSide: BorderSide(color: color, width: width),
    );
  }
}
