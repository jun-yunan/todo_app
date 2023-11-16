import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/controllers/task_controller.dart';
// import 'package:rounded_loading_button/rounded_loading_button.dart';
// import 'package:todo_app/controllers/task_controller.dart';

import 'package:todo_app/models/task_type_model.dart';
import 'package:todo_app/screens/task/update_task.dart';
// import 'package:todo_app/utils/utils.dart';
import 'package:todo_app/widgets/dialog/delete_alert_dialog.dart';
// import 'package:todo_app/widgets/task/dialog_update_task.dart';

class TaskItem extends StatelessWidget {
  final String id;
  final String title;
  final TaskType taskType;
  final String? subtitle;
  final bool isDone;
  final String date;
  final String imageUrl;
  const TaskItem({
    super.key,
    required this.taskType,
    required this.title,
    required this.id,
    this.subtitle,
    required this.isDone,
    required this.date,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    final TaskController taskController = Get.find();

    return Column(
      children: [
        const SizedBox(
          height: 15,
        ),
        ListTile(
          subtitle: subtitle?.isEmpty == false
              ? Text(
                  subtitle!,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey,
                  ),
                )
              : null,
          leading: isDone
              ? IconButton(
                  onPressed: () {
                    taskController.notDoneTaskById(id);
                  },
                  icon: Icon(
                    Icons.check_circle,
                    color: taskType == TaskType.personal
                        ? Colors.cyan
                        : Colors.purple,
                  ),
                )
              : IconButton(
                  onPressed: () {
                    taskController.isDoneTaskById(id);
                  },
                  icon: Icon(
                    Icons.radio_button_unchecked,
                    color: taskType == TaskType.personal
                        ? Colors.cyan
                        : Colors.purple,
                  ),
                ),
          // tileColor: isDone ? Colors.green.shade100 : Colors.white,
          tileColor: Theme.of(context).colorScheme.primaryContainer,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          trailing: PopupMenuButton<String>(
            offset: const Offset(0, 45),
            itemBuilder: (BuildContext context) {
              return <PopupMenuEntry<String>>[
                PopupMenuItem<String>(
                  onTap: () {
                    Get.to(
                      () => UpdateTask(
                        id: id,
                        date: date,
                        imageUrl: imageUrl,
                        taskType: taskType,
                        title: title,
                      ),
                    );
                  },
                  child: const ListTile(
                    leading: Icon(Icons.edit),
                    title: Text("Edit Task"),
                  ),
                ),
                PopupMenuItem(
                    onTap: () {},
                    child: const ListTile(
                      leading: Icon(Icons.content_copy),
                      title: Text("Duplicate Task"),
                    )),
                PopupMenuItem(
                    onTap: () {},
                    child: const ListTile(
                      leading: Icon(Icons.timer),
                      title: Text("Set Reminder"),
                    )),
                PopupMenuItem(
                  onTap: () {
                    Get.dialog(
                      DeleteAlertDialog(
                        onPressed: () {
                          taskController.deleteTaskById(id);
                          Get.back();
                        },
                      ),
                    );
                  },
                  child: ListTile(
                    leading: Icon(
                      Icons.delete,
                      color: Colors.red.shade600,
                    ),
                    title: Text(
                      "Delete Task",
                      style: TextStyle(
                        color: Colors.red.shade600,
                      ),
                    ),
                  ),
                ),
              ];
            },
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 5),
          title: isDone
              ? Stack(
                  clipBehavior: Clip.none,
                  alignment: Alignment.center,
                  children: [
                    Positioned(
                      left: 0,
                      child: Text(
                        title,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ),
                    Divider(
                      color: Theme.of(context).colorScheme.primary,
                      thickness: 1,
                    ),
                    Positioned(
                      right: 0,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 5,
                          horizontal: 10,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: taskType == TaskType.personal
                              ? Colors.cyan.shade100
                              : Colors.purple.shade100,
                        ),
                        child: Text(
                          "Completed",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: taskType == TaskType.personal
                                ? Colors.cyan.shade700
                                : Colors.purple,
                          ),
                        ),
                      ),
                    )
                  ],
                )
              : Text(
                  title,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
          onTap: () {},
        ),
      ],
    );
  }
}
