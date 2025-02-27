import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:aldawlia_real_estate/Widgets/custom_button.dart';
import 'package:aldawlia_real_estate/Widgets/custom_text_field.dart';
import 'package:aldawlia_real_estate/core/theme/my_theme_data.dart';
import 'package:aldawlia_real_estate/core/services/Auth_service.dart' as myAuth;
import '../../Widgets/aldawlia_logo.dart';
import '../home/HomePage.dart';

class Login extends StatelessWidget {
  static const String routeName = "/login";

  Login({super.key});

  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void _showDialog(BuildContext context, String title, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }

  void signIn(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      try {
        await context.read<myAuth.AuthProvider>().signIn(
          emailController.text.trim(),
          passwordController.text.trim(),
        );
        Navigator.pushReplacementNamed(context, HomePage.routeName);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Login failed: ${e.toString()}")),
        );
      }
    }
  }

  void resetPassword(BuildContext context) async {
    if (emailController.text.isEmpty) {
      _showDialog(context, "Error", "Please enter your email to reset password.");
      return;
    }

    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: emailController.text.trim());
      _showDialog(context, "Success", "Check your email for reset instructions.");
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: ${e.toString()}")),
      );
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
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 40),
                  DawliaLogo(),
                  const SizedBox(height: 40),
                  CustomTextField(
                    controller: emailController,
                    labelText: "Email",
                    obscureText: false,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter your email";
                      } else if (!RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$").hasMatch(value)) {
                        return "Enter a valid email";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  CustomTextField(
                    controller: passwordController,
                    labelText: "Password",
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter your password";
                      } else if (value.length < 6) {
                        return "Password must be at least 6 characters";
                      }
                      return null;
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () => resetPassword(context),
                          child: Text("Forgot Password?", style: TextStyle(color: MyThemeData.darky)),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  CustomButton(
                    text: "Login",
                    onTap: () => signIn(context),
                  ),
                  const SizedBox(height: 30),
                  Row(
                    children: [
                      Expanded(
                        child: Divider(thickness: 0.8, color: MyThemeData.darky, indent: 30, endIndent: 20),
                      ),
                      Text("Or", style: TextStyle(fontSize: 18, color: MyThemeData.blackColor)),
                      Expanded(
                        child: Divider(thickness: 0.8, color: MyThemeData.darky, indent: 30, endIndent: 20),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  InkWell(
                    onTap: () => context.read<myAuth.AuthProvider>().signInWithGoogle(),
                    child: SizedBox(
                      width: 50,
                      height: 50,
                      child: Image.asset('lib/assets/images/google.png'),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Not a Member?"),
                      TextButton(
                        onPressed: () => Navigator.pushNamed(context, "/signup"),
                        child: Text("Register Now!", style: TextStyle(color: MyThemeData.darky)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
