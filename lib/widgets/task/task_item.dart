import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/controllers/task_controller.dart';
// import 'package:rounded_loading_button/rounded_loading_button.dart';
// import 'package:todo_app/controllers/task_controller.dart';

import 'package:todo_app/models/task_type_model.dart';
import 'package:todo_app/screens/update_task.dart';
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
        Stack(
          alignment: Alignment.center,
          children: [
            // if (isDone)
            //   const Divider(
            //     color: Colors.black87,
            //   ),
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
              // leading: Icon(
              //   Icons.radio_button_unchecked,
              //   size: 30,
              //   color:
              //       taskType == TaskType.personal ? Colors.cyan : Colors.purple,
              // ),
              leading: isDone
                  ? IconButton(
                      onPressed: () {
                        taskController.notDoneTaskById(id);
                      },
                      icon: Icon(
                        Icons.check,
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
              tileColor: isDone ? Colors.green.shade100 : Colors.white,
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
                              taskController.deleteTaskById(id);
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
              contentPadding: const EdgeInsets.symmetric(vertical: 12),
              title: Stack(
                children: [
                  Text(
                    title,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF444444).withOpacity(0.8),
                    ),
                  ),
                  if (isDone)
                    Positioned(
                      right: 0,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 10),
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
              ),
              onTap: () {},
            ),
          ],
        )
      ],
    );
  }
}
