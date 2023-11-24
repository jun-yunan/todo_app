import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/controllers/new_task_controller.dart';
// import 'package:todo_app/utils/utils.dart';
// import 'package:todo_app/models/category_task_model.dart';

class TaskItem extends StatelessWidget {
  // final bool isLongPress;
  final int index;
  const TaskItem({
    super.key,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final NewTaskController newTaskController = Get.find();
    return Obx(
      () => GestureDetector(
        onLongPress: () {
          newTaskController.isOnLongPress.value = true;
          Future.delayed(const Duration(milliseconds: 500), () {
            newTaskController.isOnLongPress.value = false;

            Get.dialog(
              SimpleDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                // title: Row(
                //   children: [Text('Chọn một lựa chọn')],
                // ),
                contentPadding: const EdgeInsets.symmetric(vertical: 0),
                children: [
                  SimpleDialogOption(
                    padding: EdgeInsets.symmetric(vertical: 5),
                    onPressed: () {
                      Navigator.of(context).pop();
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
              ),
            );
          });
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.symmetric(vertical: 10),
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
          // height: 160,
          decoration: BoxDecoration(
            color: newTaskController.isOnLongPress.value
                ? Color(int.parse(
                        "0xFF${newTaskController.taskList[index].hexColor}"))
                    .withOpacity(0.2)
                : Color(int.parse(
                    "0xFF${newTaskController.taskList[index].hexColor}")),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    newTaskController.taskList[index].title!,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    newTaskController.taskList[index].details!,
                    style: TextStyle(
                      color: Colors.grey.shade200,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 25,
              ),
              TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Color(int.parse(
                        "0xFF${newTaskController.taskList[index].hexColor}"))),
                child: Text(
                  newTaskController.taskList[index].time!,
                  style: const TextStyle(
                    // color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
