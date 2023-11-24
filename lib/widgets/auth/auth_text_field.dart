import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/controllers/auth_controller.dart';

enum TypeAuthTextField { email, password }

class AuthTextField extends StatelessWidget {
  final bool? isFieldPassword;
  final String? hintText;
  final IconData? prefixIcon;
  final TextEditingController? controller;
  final TypeAuthTextField typeAuthTextField;

  const AuthTextField({
    super.key,
    this.hintText,
    this.controller,
    this.prefixIcon,
    this.isFieldPassword,
    required this.typeAuthTextField,
  });

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.find();
    return Obx(
      () => TextField(
        controller: typeAuthTextField == TypeAuthTextField.email
            ? authController.emailAddress.value
            : authController.password.value,
        cursorColor: Colors.white,
        obscureText: isFieldPassword! && authController.obscureText.value,
        style: const TextStyle(color: Colors.white, fontSize: 18),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey.shade100),
          prefixIcon: Icon(
            prefixIcon,
            color: Colors.white,
          ),
          suffixIcon: isFieldPassword == false
              ? null
              : authController.obscureText.value == true
                  ? IconButton(
                      onPressed: () {
                        authController.toggleObscureText();
                      },
                      icon: const Icon(
                        Icons.visibility,
                        color: Colors.white,
                      ),
                    )
                  : IconButton(
                      onPressed: () {
                        authController.toggleObscureText();
                      },
                      icon: const Icon(
                        Icons.visibility_off,
                        color: Colors.white,
                      ),
                    ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(width: 2, color: Colors.white),
            borderRadius: BorderRadius.circular(30),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(width: 2, color: Colors.white),
            borderRadius: BorderRadius.circular(30),
          ),
        ),
      ),
    );
  }
}
