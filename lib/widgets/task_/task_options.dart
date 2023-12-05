import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:todo_app/controllers/new_task_controller.dart';
import 'package:todo_app/models/category_task_model.dart';
import 'package:todo_app/widgets/dialog/delete_alert_dialog.dart';
import 'package:todo_app/widgets/dialog/edit_task_dialog%20copy.dart';

class TaskOptions extends StatelessWidget {
  final int index;
  const TaskOptions({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    final NewTaskController newTaskController = Get.find();

    return SimpleDialog(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            "Select Options",
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.close,
              size: 30,
            ),
          )
        ],
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      contentPadding: const EdgeInsets.symmetric(vertical: 0),
      children: [
        SimpleDialogOption(
          padding: const EdgeInsets.symmetric(vertical: 5),
          onPressed: () {
            Navigator.of(context).pop();
            newTaskController
                .isDoneTaskById(newTaskController.taskListByUser[index].id!);
          },
          child: const ListTile(
            leading: Icon(
              Icons.check,
              size: 24,
            ),
            title: Text(
              "Task Completed",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                // color: Colors.green.shade700,
              ),
            ),
          ),
        ),
        SimpleDialogOption(
          padding: EdgeInsets.symmetric(vertical: 5),
          onPressed: () {
            Navigator.of(context).pop();
            Get.dialog(
              EditTaskDialogCopy(
                id: newTaskController.taskListByUser[index].id!,
                title: newTaskController.taskListByUser[index].title!,
                categoryTask: CategoryTaskType.values.firstWhere((element) =>
                    element.toString() ==
                    "CategoryTaskType.${newTaskController.taskListByUser[index].categoryTask!}"),
                isDone: newTaskController.taskListByUser[index].isDone!,
                date: newTaskController.taskListByUser[index].date!,
                details: newTaskController.taskListByUser[index].details!,
                time: newTaskController.taskListByUser[index].time!,
              ),
            );
          },
          child: const ListTile(
            leading: Icon(
              Icons.edit,
              size: 24,
            ),
            title: Text(
              "Edit Task",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
        SimpleDialogOption(
          padding: EdgeInsets.symmetric(vertical: 5),
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const ListTile(
            leading: Icon(
              Icons.timer,
              size: 24,
            ),
            title: Text(
              "Set Reminder",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
        SimpleDialogOption(
          padding: EdgeInsets.symmetric(vertical: 5),
          onPressed: () {
            Navigator.of(context).pop();
            // Get.dialog(
            //   DeleteAlertDialog(
            //     onPressed: () {
            //       newTaskController.deleteTaskById(
            //           context: context,
            //           id: newTaskController.taskListByUser[index].id!);
            //     },
            //   ),
            // );
            Get.dialog(AlertDialog(
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
                  controller: newTaskController.loadingButtonController.value,
                  onPressed: () async {
                    await newTaskController
                        .deleteTaskById(
                          context: context,
                          id: newTaskController.taskListByUser[index].id!,
                        )
                        .then(
                          (value) => Get.back(),
                        );
                  },
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
            ));
          },
          child: ListTile(
            leading: Icon(
              Icons.delete,
              color: Colors.red.shade800,
              size: 24,
            ),
            title: Text(
              "Delete Task",
              style: TextStyle(
                fontSize: 16,
                color: Colors.red.shade800,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
