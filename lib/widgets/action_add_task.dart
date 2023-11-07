import 'package:flutter/material.dart';

class ActionAddTask extends StatelessWidget {
  final void Function()? onPressed;
  final IconData icon;
  const ActionAddTask({super.key, this.onPressed, required this.icon});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: Icon(
        icon,
        size: 28,
      ),
      style: IconButton.styleFrom(),
    );
  }
}
