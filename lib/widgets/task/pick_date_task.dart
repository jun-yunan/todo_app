import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/controllers/task_controller.dart';

class PickDateTask extends StatelessWidget {
  const PickDateTask({super.key});

  @override
  Widget build(BuildContext context) {
    final TaskController taskController = Get.find();
    return TextFormField(
      readOnly: true,
      controller: taskController.dateController.value,
      style: TextStyle(color: Theme.of(context).colorScheme.primary),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(vertical: 5),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(
            width: 2,
            color: Colors.grey,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(
            width: 2,
            color: Colors.grey,
          ),
        ),
        prefixIcon: Icon(
          Icons.calendar_today,
          color: Theme.of(context).colorScheme.primary,
        ),
        hintText: "Today",
      ),
      onTap: () {
        taskController.selectedDate(context);
      },
    );
  }
}
