import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:todo_app/controllers/task_controller.dart';

class DeleteAlertDialog extends StatelessWidget {
  final void Function()? onPressed;
  const DeleteAlertDialog({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final TaskController taskController = Get.find();

    return AlertDialog(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        // mainAxisSize: MainAxisSize.max,
        children: [
          Row(
            children: [
              Icon(
                Icons.warning,
                color: Colors.red.shade600,
                size: 26,
              ),
              const SizedBox(
                width: 6,
              ),
              Text(
                "Delete Task",
                style: TextStyle(
                  color: Colors.red.shade600,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.close,
              size: 26,
            ),
          )
        ],
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      content: const Text(
        "Are you sure you want to delete it?",
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
      actions: [
        RoundedLoadingButton(
          color: Colors.red.shade600,
          successColor: Colors.green,
          controller: taskController.loadingButtonController.value,
          onPressed: onPressed,
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.delete,
                size: 26,
                color: Colors.white,
              ),
              SizedBox(
                width: 6,
              ),
              Text(
                "Delete",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
