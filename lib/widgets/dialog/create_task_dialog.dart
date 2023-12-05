import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:todo_app/controllers/new_task_controller.dart';
import 'package:todo_app/controllers/notification_controller.dart';
// import 'package:todo_app/controllers/task_controller.dart';
// import 'package:todo_app/controllers/task_controller.dart';
import 'package:todo_app/models/category_task_model.dart';
// import 'package:todo_app/models/task_model.dart';
import 'package:todo_app/utils/utils.dart';
import 'package:todo_app/widgets/task/time_picker.dart';

class CreateTaskDialog extends StatelessWidget {
  const CreateTaskDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final NewTaskController newTaskController = Get.put(NewTaskController());
    // final TaskController taskController = Get.find();
    final NotificationController notificationController = Get.find();
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
                        "Create a new task",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          Get.back();
                          newTaskController.resetFormCreateTask();
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
                    TextField(
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
                    const SizedBox(
                      height: 15,
                    ),
                    TextField(
                      controller: newTaskController.detailsTaskController.value,
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
                          "Add to category",
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
                    Obx(
                      () => RoundedLoadingButton(
                        successColor: Colors.green,
                        controller:
                            newTaskController.loadingButtonController.value,
                        onPressed: () async {
                          if (newTaskController
                              .titleTaskController.value.text.isEmpty) {
                            showSnackbar(message: "Title task is required.");
                            newTaskController.loadingButtonController.value
                                .reset();
                          } else if (DateTime(
                                  DateTime.now().year,
                                  DateTime.now().month,
                                  DateTime.now().day,
                                  newTaskController.hour.value,
                                  newTaskController.minute.value)
                              .isBefore(DateTime.now())) {
                            showSnackbar(
                                message:
                                    "You selected a time in the past. Please choose a time again.");
                            newTaskController.loadingButtonController.value
                                .reset();
                          } else if (DateTime(
                            newTaskController
                                .daysOfWeek[
                                    newTaskController.selectedDayIndex.value]
                                .year,
                            newTaskController
                                .daysOfWeek[
                                    newTaskController.selectedDayIndex.value]
                                .month,
                            newTaskController
                                .daysOfWeek[
                                    newTaskController.selectedDayIndex.value]
                                .day,
                            newTaskController.hour.value,
                            newTaskController.minute.value,
                          ).isBefore(DateTime.now())) {
                            showSnackbar(
                                message:
                                    "You have selected a date in the past. Please choose again");

                            Future.delayed(const Duration(milliseconds: 500),
                                () {
                              newTaskController.loadingButtonController.value
                                  .reset();
                              Navigator.of(context).pop();
                              newTaskController.resetFormCreateTask();
                            });
                          } else {
                            await newTaskController
                                .createTask(context)
                                .then((value) {
                              notificationController.scheduleNotification(
                                id: 4,
                                title: "It's time to work!",
                                body:
                                    "Don't forget the ${newTaskController.titleTaskController.value.text} job at ${newTaskController.hour.value}:${newTaskController.minute.value} today. Do it as soon as you can!",
                                payload: "",
                                time: DateTime(
                                  DateTime.now().year,
                                  DateTime.now().month,
                                  DateTime.now().day,
                                  newTaskController.hour.value,
                                  newTaskController.minute.value,
                                ),
                              );
                            });
                          }
                        },
                        child: const Text(
                          "Create Task",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    )
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
