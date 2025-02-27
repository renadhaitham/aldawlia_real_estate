import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/services/Auth_service.dart';
import '../../Widgets/custom_text_field.dart';
import '../../Widgets/custom_button.dart';
import '../../Widgets/aldawlia_logo.dart';
import '../../core/theme/my_theme_data.dart';

class SignUp extends StatefulWidget {
  static const String routeName = "/signup";

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool isMatch = true;
  String errorMSG = "";

  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final TextEditingController phoneNumController = TextEditingController();

  void signUp() async {
    setState(() {
      isMatch = passwordController.text == confirmPasswordController.text;
      errorMSG = isMatch ? "" : "Passwords don't match!";
    });

    if (!isMatch) return;

    try {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      var userCredential = await authProvider.signUp(
        nameController.text,
        emailController.text,
        passwordController.text,
        phoneNumController.text,
      );

      if (userCredential != null) {
        Navigator.pushReplacementNamed(context, "/login");
      }
    } catch (e) {
      setState(() {
        errorMSG = "Sign-up Failed: ${e.toString()}";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Form(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 30),
                  DawliaLogo(),
                  CustomTextField(controller: nameController, labelText: "Name", obscureText: false),
                  SizedBox(height: 20),
                  CustomTextField(controller: emailController, labelText: "Email", obscureText: false),
                  SizedBox(height: 20),
                  CustomTextField(controller: passwordController, labelText: "Password", obscureText: true),
                  SizedBox(height: 20),
                  CustomTextField(controller: confirmPasswordController, labelText: "Confirm Password", obscureText: true),
                  if (errorMSG.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(errorMSG, style: TextStyle(color: Colors.red)),
                        ],
                      ),
                    ),
                  SizedBox(height: 10),
                  CustomTextField(controller: phoneNumController, labelText: "Phone Number", obscureText: false),
                  SizedBox(height: 30),
                  CustomButton(
                    text: "Register",
                    onTap: signUp,
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Already a member?"),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, "/login");
                        },
                        child: Text("Login!", style: TextStyle(color: MyThemeData.darky)),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
