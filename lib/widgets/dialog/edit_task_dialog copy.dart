// ignore: file_names
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:todo_app/controllers/new_task_controller.dart';
import 'package:todo_app/models/category_task_model.dart';
import 'package:todo_app/utils/utils.dart';
import 'package:todo_app/widgets/task/time_picker.dart';

class EditTaskDialogCopy extends StatelessWidget {
  final String id;
  final String title;
  final CategoryTaskType categoryTask;
  final String? subtitle;
  final bool isDone;
  final String date;

  final String details;
  final String time;
  const EditTaskDialogCopy({
    super.key,
    required this.id,
    required this.title,
    required this.categoryTask,
    this.subtitle,
    required this.isDone,
    required this.date,
    required this.details,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    final NewTaskController newTaskController = Get.put(NewTaskController());
    newTaskController.titleTaskController.value.text = title;
    newTaskController.detailsTaskController.value.text = details;
    newTaskController.hour.value = int.parse(time.split(":")[0]);
    newTaskController.minute.value =
        int.parse(time.split(" ")[0].split(":")[1]);
    newTaskController.timeFormat.value = time.split(" ")[1];
    newTaskController.selectedCategoryTasks.value = categoryTask;
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
                          newTaskController.resetFormCreateTask();
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
                        controller: newTaskController.titleTaskController.value,
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
                        controller:
                            newTaskController.detailsTaskController.value,
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
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Edit to category",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: newTaskController.categoryTaskss
                              .asMap()
                              .entries
                              .map((entry) {
                            // int index = entry.key;
                            CategoryTaskModel category = entry.value;
                            return Obx(
                              () => ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      // newTaskController.checkSelectedCategoryTasks()
                                      newTaskController.selectedCategoryTasks
                                                  .value ==
                                              category.category
                                          ? category.color
                                          : category.color.withOpacity(0.3),
                                  foregroundColor: newTaskController
                                              .selectedCategoryTasks.value ==
                                          category.category
                                      ? Colors.white
                                      : Colors.grey.shade300,
                                  shadowColor: Colors.black54,
                                  elevation: 10,
                                ),
                                onPressed: () {
                                  // newTaskController.selectedCategoryTasks.value =
                                  //     category.category;
                                  newTaskController.setSelectedCategoryTasks(
                                      category.category);
                                },
                                child: Text(
                                  category.category.name,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    RoundedLoadingButton(
                      successColor: Colors.green,
                      controller:
                          newTaskController.loadingButtonController.value,
                      onPressed: () {
                        if (newTaskController
                            .titleTaskController.value.text.isEmpty) {
                          showSnackbar(message: "Title task is required.");
                          newTaskController.loadingButtonController.value
                              .reset();
                        } else {
                          // newTaskController.createTask(context);
                          newTaskController.updateTaskById(id);
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
