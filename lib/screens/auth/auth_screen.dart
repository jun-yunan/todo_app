import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/controllers/auth_controller.dart';
import 'package:todo_app/widgets/auth/auth_text_field.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.find();
    return Scaffold(
        body: SafeArea(
            child: Container(
      width: double.infinity,
      height: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 25),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [const Color(0xFF715aff), Colors.purple.shade100],
          tileMode: TileMode.mirror,
          begin: Alignment.topCenter,
          end: Alignment.bottomRight,
        ),
      ),
      child: ListView(
        children: [
          const SizedBox(
            height: 65,
          ),
          const Text(
            "Welcome",
            style: TextStyle(
              fontSize: 45,
              fontWeight: FontWeight.w500,
              letterSpacing: 1.4,
              color: Colors.white,
            ),
          ),
          const Text(
            "Back",
            style: TextStyle(
              fontSize: 45,
              fontWeight: FontWeight.w500,
              letterSpacing: 1.4,
              color: Colors.white,
            ),
          ),
          const SizedBox(
            height: 60,
          ),
          authController.variant.value == VARIANT.login
              ? const Text(
                  "Login",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                )
              : const Text(
                  "Register",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
          const SizedBox(
            height: 25,
          ),
          const AuthTextField(
            typeAuthTextField: TypeAuthTextField.email,
            hintText: "Email Address",
            prefixIcon: Icons.email,
            isFieldPassword: false,
          ),
          const SizedBox(
            height: 25,
          ),
          AuthTextField(
            typeAuthTextField: TypeAuthTextField.password,
            hintText: "Password",
            prefixIcon: Icons.lock,
            isFieldPassword: true,
            controller: authController.emailAddress.value,
          ),
          const SizedBox(
            height: 25,
          ),
          ElevatedButton(onPressed: () {}, child: const Text("Login")),
          ListTile(
            onTap: () {},
          )
        ],
      ),
    )));
  }
}
