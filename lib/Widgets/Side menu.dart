import 'package:aldawlia_real_estate/screens/requests/myRequests.dart';
import 'package:aldawlia_real_estate/core/theme/my_theme_data.dart';
import 'package:aldawlia_real_estate/screens/project/my_properties.dart';
import 'package:aldawlia_real_estate/screens/service/service_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../screens/auth/login.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  final user = FirebaseAuth.instance.currentUser!;
  bool _qrMenuExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: MyThemeData.whiteColor,
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(
              user.displayName ?? "User",
              style: TextStyle(color: MyThemeData.blackColor),
            ),
            accountEmail: Text(
              user.email!,
              style: TextStyle(color: MyThemeData.blackColor),
            ),
            currentAccountPicture: const CircleAvatar(
              backgroundImage: AssetImage('lib/assets/images/profile.png'),
            ),
            decoration: BoxDecoration(
              color: MyThemeData.primary,
            ),
          ),
          ListTile(
            leading: Icon(Icons.other_houses, color: MyThemeData.blackColor),
            title: Text('My Properties', style: Theme.of(context).textTheme.bodySmall),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushReplacementNamed(context, MyProperties.routeName);
            },
          ),
          ListTile(
            leading: Icon(Icons.qr_code, color: MyThemeData.blackColor),
            title: Text('QR Code', style: Theme.of(context).textTheme.bodySmall),
            trailing: Icon(color:MyThemeData.darky ,
                _qrMenuExpanded ? Icons.expand_less : Icons.expand_more),
            onTap: () {
              setState(() {
                _qrMenuExpanded = !_qrMenuExpanded;
              });
            },
          ),
          if (_qrMenuExpanded) ...[
            ListTile(
              leading: Icon(Icons.person, color: MyThemeData.blackColor),
              title: Text('Visitor QR Code', style: Theme.of(context).textTheme.bodySmall),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, "/visitorQr");
              },
            ),
            ListTile(
              leading: Icon(Icons.home, color: MyThemeData.blackColor),
              title: Text('Owner QR Code', style: Theme.of(context).textTheme.bodySmall),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, "/ownerQr");
              },
            ),
          ],
          ListTile(
            leading: Image.asset('lib/assets/images/services.png', scale: 16),
            title: Text('Services', style: Theme.of(context).textTheme.bodySmall),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushReplacementNamed(context, ServiceScreen.routeName);
            },
          ),SizedBox(height: 20,),
          const Divider(thickness: 0.5,color:MyThemeData.darky ,),
          ListTile(
            title: Center(child: Text('Log out', style: Theme.of(context).textTheme.bodySmall)),
            onTap: () async {
              await FirebaseAuth.instance.signOut();
              if (mounted) {
                Navigator.pop(context);
                Navigator.pushReplacementNamed(context, Login.routeName);
              }
            },
          ),
        ],
      ),
    );
  }
}
