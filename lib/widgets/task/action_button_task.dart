import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/controllers/task_controller.dart';
import 'package:todo_app/widgets/action_add_task.dart';

class ActionButtonTask extends StatelessWidget {
  const ActionButtonTask({super.key});

  @override
  Widget build(BuildContext context) {
    final TaskController taskController = Get.find();

    return Row(
      children: [
        ActionAddTask(
          icon: Icons.add_photo_alternate_outlined,
          onPressed: () {
            taskController.selectedImage();
          },
        ),
        ActionAddTask(
          icon: Icons.upload_file,
          onPressed: () {},
        ),
        ActionAddTask(
          icon: Icons.mood,
          onPressed: () {},
        ),
        ActionAddTask(
          icon: Icons.flag_outlined,
          onPressed: () {},
        ),
        ActionAddTask(
          onPressed: () {},
          icon: Icons.dark_mode_outlined,
        ),
      ],
    );
  }
}
