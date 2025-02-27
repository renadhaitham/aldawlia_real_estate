import 'package:aldawlia_real_estate/screens/auth/login.dart';
import 'package:aldawlia_real_estate/screens/auth/sign_up.dart';
import 'package:aldawlia_real_estate/screens/home/HomePage.dart';
import 'package:aldawlia_real_estate/screens/qr_code/owner_qr.dart';
import 'package:aldawlia_real_estate/screens/qr_code/visitor_qr.dart';
import 'package:aldawlia_real_estate/screens/service/Services.dart';
import 'package:aldawlia_real_estate/screens/requests/myRequests.dart';
import 'package:aldawlia_real_estate/screens/project/my_properties.dart';
import 'package:aldawlia_real_estate/core/theme/my_theme_data.dart';
import 'package:aldawlia_real_estate/screens/service/service_screen.dart';
import 'package:aldawlia_real_estate/screens/splash/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:aldawlia_real_estate/core/services/Auth_service.dart' as myAuth;

import 'core/services/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => myAuth.AuthProvider())],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: MyThemeData.lightTheme,
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
     // initialRoute: Login.routeName,
      routes: {
        "/home": (context) => HomePage(),
        "/login": (context) => Login(),
        "/signup": (context) => SignUp(),
        "/service": (context) => Services(),
        "/service_screen": (context) => ServiceScreen(),
        "/myService": (context) => MyRequests(),
        "/visitorQr": (context) => VisitorQr(),
        "/ownerQr": (context) => OwnerQr(),
        "/myProperties": (context) => MyProperties(),
      },
    );
  }
}