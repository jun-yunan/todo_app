import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:rounded_loading_button/rounded_loading_button.dart';
// import 'package:todo_app/controllers/task_controller.dart';

import 'package:todo_app/models/task_type_model.dart';
// import 'package:todo_app/utils/utils.dart';
import 'package:todo_app/widgets/dialog/delete_alert_dialog.dart';

class TaskItem extends StatelessWidget {
  final String title;
  final TaskType taskType;
  const TaskItem({
    super.key,
    required this.taskType,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    // final TaskController taskController = Get.find();

    return Column(
      children: [
        const SizedBox(
          height: 15,
        ),
        ListTile(
          leading: Icon(
            Icons.radio_button_unchecked,
            size: 30,
            color: taskType == TaskType.personal ? Colors.cyan : Colors.purple,
          ),
          tileColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          trailing: PopupMenuButton<String>(
            itemBuilder: (BuildContext context) {
              return <PopupMenuEntry<String>>[
                PopupMenuItem<String>(
                  onTap: () {
                    Get.dialog(
                      DeleteAlertDialog(
                        onPressed: () {
                          Get.back();
                        },
                      ),
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.delete,
                        size: 26,
                        color: Colors.red.shade600,
                      ),
                      const SizedBox(
                        width: 6,
                      ),
                      Text(
                        "Delete",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.red.shade600,
                        ),
                      )
                    ],
                  ),
                ),
                PopupMenuItem<String>(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.edit,
                        size: 26,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      const SizedBox(
                        width: 6,
                      ),
                      Text(
                        "Edit",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      )
                    ],
                  ),
                )
              ];
            },
          ),
          title: Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF444444).withOpacity(0.8),
            ),
          ),
          onTap: () {},
        ),
      ],
    );
  }
}
