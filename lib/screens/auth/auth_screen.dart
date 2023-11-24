import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:todo_app/controllers/auth_controller.dart';
import 'package:todo_app/utils/utils.dart';
import 'package:todo_app/widgets/auth/auth_text_field.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.put(AuthController());
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
                height: 80,
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
              Obx(() => Text(
                    authController.variant.value == VARIANT.login
                        ? "Sign In"
                        : "Sign Up",
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  )),
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
              Obx(
                () => RoundedLoadingButton(
                  width: MediaQuery.of(context).size.width,
                  controller: authController.loadingButtonController.value,
                  color: Colors.white,
                  successColor: Colors.green,
                  onPressed: () {
                    if (authController.variant.value == VARIANT.login) {
                      if (authController.emailAddress.value.text.isNotEmpty &&
                          authController.password.value.text.isNotEmpty) {
                        authController.signInWithEmailAndPassword(
                          email: authController.emailAddress.value.text.trim(),
                          password: authController.password.value.text.trim(),
                        );
                      } else {
                        showSnackbar(
                            message:
                                "Field email address or password is required.");
                        authController.loadingButtonController.value.reset();
                      }
                    } else {
                      if (authController.emailAddress.value.text.isNotEmpty &&
                          authController.password.value.text.isNotEmpty) {
                        authController.signUpWithEmailAndPassword(
                            email:
                                authController.emailAddress.value.text.trim(),
                            password:
                                authController.password.value.text.trim());
                      } else {
                        showSnackbar(
                            message:
                                "Field email address or password is required.");
                        authController.loadingButtonController.value.reset();
                      }
                    }
                  },
                  child: Text(
                    authController.variant.value == VARIANT.login
                        ? "Sign In"
                        : "Sign Up",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.purple,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(
                      height: 2,
                      color: Colors.grey.shade100,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 15),
                    child: const Text(
                      "OR",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: 2,
                      width: 150,
                      color: Colors.grey.shade100,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              RoundedLoadingButton(
                controller: authController.loadingButtonController.value,
                onPressed: () {
                  authController.signInWithGoogle();
                },
                color: Colors.white,
                successColor: Colors.green,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/google.png',
                      width: 30,
                      height: 30,
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    const Text(
                      "Sign in with Google",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        // color: Color(0xFF444444),
                        color: Colors.purple,
                      ),
                    )
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Obx(
                    () => Text(
                      authController.variant.value == VARIANT.login
                          ? "Don't have an account?"
                          : "Already have an account?",
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Obx(
                    () => TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        foregroundColor: Colors.purple,
                      ),
                      onPressed: () {
                        if (authController.variant.value == VARIANT.login) {
                          authController.variant.value = VARIANT.register;
                          authController.emailAddress.value.text = "";
                          authController.password.value.text = "";
                          authController.loadingButtonController.value.reset();
                        } else {
                          authController.variant.value = VARIANT.login;
                          authController.emailAddress.value.text = "";
                          authController.password.value.text = "";
                          authController.loadingButtonController.value.reset();
                        }
                      },
                      child: authController.variant.value == VARIANT.login
                          ? const Text(
                              "Sign Up",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            )
                          : const Text(
                              "Sign In",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
