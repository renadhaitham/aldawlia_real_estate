import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyThemeData {
  static const Color whiteColor = Color(0xFFFFFFFF);
  static const Color primary = Color(0xFFE0E0E0);
  static const Color darky = Color(0xFF616161);
  static const Color blackColor = Color(0xFF3B3B3C);
  static const Color yellowColor = Color(0xFFBDA278);

  static ThemeData lightTheme = ThemeData(
      scaffoldBackgroundColor: Colors.grey[300],
      colorScheme: const ColorScheme(
          brightness: Brightness.light,
          primary: primary,
          onPrimary: Colors.black,
          secondary: yellowColor,
          onSecondary: blackColor,
          error: Colors.red,
          onError: whiteColor,
          surface: Colors.black,
          onSurface: Colors.white),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(color: blackColor),
        iconTheme: IconThemeData(
          color: blackColor,
          size: 30,
        ),
      ),
      textTheme: TextTheme(
        bodyLarge: GoogleFonts.elMessiri(
          fontSize: 30,
          fontWeight: FontWeight.bold,
          color: blackColor,
        ),
        bodyMedium: GoogleFonts.elMessiri(
          fontSize: 20,
          fontWeight: FontWeight.w500,
          color: blackColor,
        ),
        bodySmall: GoogleFonts.elMessiri(
          fontSize: 14,
          fontWeight: FontWeight.w100,
          color: blackColor,
        ),
        titleLarge: GoogleFonts.elMessiri(
          fontSize: 30,
          fontWeight: FontWeight.w600,
          color: darky,
        ),
        titleMedium: GoogleFonts.elMessiri(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: darky,
        ),
        titleSmall: GoogleFonts.elMessiri(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: darky,
        ),
        displayLarge: GoogleFonts.elMessiri(
          fontSize: 30,
          fontWeight: FontWeight.w300,
          color: whiteColor,
        ),
        displayMedium: GoogleFonts.elMessiri(
          fontSize: 20,
          fontWeight: FontWeight.w300,
          color: whiteColor,
        ),
        displaySmall: GoogleFonts.elMessiri(
          fontSize: 14,
          fontWeight: FontWeight.w300,
          color: whiteColor,
        ),
      ),

    tabBarTheme: const TabBarTheme(
      labelColor: yellowColor,
      unselectedLabelColor: darky,
      indicator: UnderlineTabIndicator(
        borderSide: BorderSide(color: blackColor, width: 2.0),
      ),
    ),
  );
}
