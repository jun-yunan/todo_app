import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  // final String hintText;
  const AuthForm({super.key});

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _obscureText = true;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          TextFormField(
            controller: emailController,
            // keyboardAppearance: true,
            decoration: InputDecoration(hintText: "Email"),
          ),
          const SizedBox(
            height: 30,
          ),
          TextFormField(
            controller: passwordController,
            obscureText: _obscureText,
            decoration: InputDecoration(
              hintText: "Password",
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
                icon: Icon(
                    _obscureText ? Icons.visibility : Icons.visibility_off),
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Container(
            width: double.infinity,
            decoration: const BoxDecoration(),
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 12)),
              child: const Text(
                "Sign In",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
              ),
            ),
          )
        ],
      ),
    );
  }
}
