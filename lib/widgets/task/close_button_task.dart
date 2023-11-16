import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/controllers/task_controller.dart';

class CloseButtonTask extends StatelessWidget {
  const CloseButtonTask({super.key});

  @override
  Widget build(BuildContext context) {
    final TaskController taskController = Get.find();
    return IconButton(
      style: IconButton.styleFrom(
        padding: const EdgeInsets.all(10),
      ),
      onPressed: () {
        Get.back();
        taskController.taskController.value.text = "";
        taskController.dateController.value.text = "";
        taskController.imageFile.value = null;
      },
      icon: Icon(
        Icons.close,
        size: 30,
        color: Theme.of(context).colorScheme.primary,
      ),
    );
  }
}
