import 'package:flutter/material.dart';

class TextGradient extends StatelessWidget {
  final String text;
  const TextGradient({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.w700,
        letterSpacing: 2,
        foreground: Paint()
          ..shader = const LinearGradient(colors: [Colors.cyan, Colors.purple])
              .createShader(
            const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0),
          ),
      ),
      textAlign: TextAlign.center,
    );
  }
}
