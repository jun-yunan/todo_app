import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/controllers/navigation_bar_controller.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onPressed;
  final IconData icon;

  const CustomButton({
    super.key,
    required this.onPressed,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final NavigationBarAction controller = Get.put(NavigationBarAction());
    return Container(
        child: Obx(
      () => IconButton(
        onPressed: onPressed,
        icon: Icon(icon),
        // padding: EdgeInsets.all(15),
        iconSize: 30,
        style: IconButton.styleFrom(
          backgroundColor: controller.selectButton.value == true
              ? Colors.cyan
              : Colors.white,
        ),
      ),
    ));
  }
}
