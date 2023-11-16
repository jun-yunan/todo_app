import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/controllers/auth_controller.dart';
import 'package:todo_app/screens/auth/login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final AuthController controller = Get.put(AuthController());
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 15),
          decoration: const BoxDecoration(),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  CircleAvatar(
                    radius: 85,
                    backgroundColor:
                        Colors.deepPurpleAccent.shade100.withOpacity(0.4),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Todo App",
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 2,
                            foreground: Paint()
                              ..shader = const LinearGradient(
                                      colors: [Colors.cyan, Colors.purple])
                                  .createShader(
                                const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0),
                              ),
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const Icon(
                          Icons.check,
                          size: 50,
                          color: Colors.purple,
                        ),
                      ],
                    ),
                  ),
                  Text(
                    "Sign up a new account",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 2,
                      foreground: Paint()
                        ..shader = const LinearGradient(
                            colors: [Colors.cyan, Colors.purple]).createShader(
                          const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0),
                        ),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 45,
                  ),
                  TextFormField(
                    controller: emailController,
                    decoration: const InputDecoration(
                        hintText: "Email", hintStyle: TextStyle(fontSize: 16)),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    controller: passwordController,
                    obscureText: _obscureText,
                    decoration: InputDecoration(
                      hintText: "Passowrd",
                      hintStyle: const TextStyle(fontSize: 16),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        },
                        icon: Icon(
                          _obscureText
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (emailController.text.isEmpty ||
                          passwordController.text.isEmpty) {
                        Get.snackbar(
                          "Error",
                          "Email or password is required!",
                          icon: const Icon(
                            Icons.error,
                            color: Colors.white,
                          ),
                          backgroundColor: Colors.red,
                          colorText: Colors.white,
                        );
                      } else {
                        controller.signUpWithEmailAndPassword(
                          email: emailController.text.trim(),
                          password: passwordController.text.trim(),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.purple,
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100),
                      ),
                    ),
                    child: const Text(
                      "Sign Up",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
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
                          // width: 150,
                          color: Colors.black.withOpacity(0.2),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 15),
                        child: const Text(
                          "OR",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.black54),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          height: 2,
                          width: 150,
                          color: Colors.black.withOpacity(0.2),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(),
                    child: ElevatedButton(
                      onPressed: () {
                        controller.signInWithGoogle();
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.purple,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                            side: const BorderSide(
                                width: 2, color: Colors.purple)),
                      ),
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
                                fontSize: 18, fontWeight: FontWeight.w600),
                          )
                        ],
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Already have an account?"),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LoginScreen(),
                            ),
                          );
                        },
                        child: const Text(
                          "Sign In",
                          style: TextStyle(color: Colors.purple),
                        ),
                      )
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
