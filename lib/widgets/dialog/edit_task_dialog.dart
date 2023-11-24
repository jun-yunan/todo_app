import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
// import 'package:todo_app/controllers/new_task_controller.dart';
import 'package:todo_app/controllers/task_controller.dart';
import 'package:todo_app/models/task_type_model.dart';
// import 'package:todo_app/controllers/task_controller.dart';
// import 'package:todo_app/models/category_task_model.dart';
import 'package:todo_app/utils/utils.dart';
import 'package:todo_app/widgets/task/choice_chip_task.dart';
import 'package:todo_app/widgets/task/time_picker.dart';

class EditTaskDialog extends StatelessWidget {
  final String id;
  final String title;
  final TaskType taskType;
  final String? subtitle;
  final bool isDone;
  final String date;
  final String imageUrl;
  final String details;
  final String time;
  const EditTaskDialog({
    super.key,
    required this.id,
    required this.title,
    required this.taskType,
    this.subtitle,
    required this.isDone,
    required this.date,
    required this.imageUrl,
    required this.details,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    // final NewTaskController newTaskController = Get.put(NewTaskController());
    final TaskController taskController = Get.put(TaskController());
    taskController.taskController.value.text = title;
    taskController.detailsTaskController.value.text = details;
    taskController.hour.value = int.parse(time.split(":")[0]);
    taskController.minute.value = int.parse(time.split(" ")[0].split(":")[1]);
    taskController.timeFormat.value = time.split(" ")[1];
    taskController.isSelectedPersonal.value =
        taskType == TaskType.personal ? true : false;
    taskController.isSelectedBusiness.value =
        taskType == TaskType.business ? true : false;
    return Dialog(
      child: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          // height: 600,
          decoration: BoxDecoration(
            // color: Colors.white,
            color: Theme.of(context).colorScheme.background,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                  width: MediaQuery.of(context).size.width,
                  height: 60,
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  decoration: const BoxDecoration(
                    color: Colors.purple,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Edit Task",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          taskController.resetFormCreateTask();
                          Get.back();
                        },
                        icon: const Icon(
                          Icons.close,
                          size: 30,
                          color: Colors.white,
                        ),
                      )
                    ],
                  )),
              Container(
                padding: const EdgeInsets.all(15),
                child: Column(
                  children: [
                    Obx(
                      () => TextField(
                        controller: taskController.taskController.value,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                        decoration: const InputDecoration(
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                          ),
                          hintText: "Write title task here...",
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Obx(
                      () => TextField(
                        controller: taskController.detailsTaskController.value,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                        decoration: const InputDecoration(
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                          ),
                          hintText: "Write details task here...",
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    const TimePicker(),
                    const SizedBox(
                      height: 15,
                    ),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Edit to category",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        ChoiceChipTask()
                      ],
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    RoundedLoadingButton(
                      successColor: Colors.green,
                      controller: taskController.loadingButtonController.value,
                      onPressed: () {
                        if (taskController.taskController.value.text.isEmpty) {
                          showSnackbar(message: "Title task is required.");
                          taskController.loadingButtonController.value.reset();
                        } else {
                          // newTaskController.createTask(context);
                          taskController.updateTaskById(id);
                        }
                      },
                      child: const Text(
                        "Update Task",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
