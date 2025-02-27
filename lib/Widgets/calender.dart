import 'package:flutter/material.dart';

import '../core/theme/my_theme_data.dart';

Future<DateTime?> myCalendar(BuildContext context) async {
  return await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime.now(),
    lastDate: DateTime(2100),
    builder: (context, child) {
      return Theme(
        data: ThemeData.light().copyWith(
          primaryColor: MyThemeData.whiteColor,
          hintColor: MyThemeData.darky,// Accent color
          colorScheme: ColorScheme.light(
              primary: MyThemeData.blackColor,
              onPrimary: MyThemeData.whiteColor,
              onSurface: MyThemeData.darky),// Date numbers color
          ),

        child: child!,
      );
    },
  );
}
