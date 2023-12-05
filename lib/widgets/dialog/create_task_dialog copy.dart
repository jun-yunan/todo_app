import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:todo_app/controllers/new_task_controller.dart';
import 'package:todo_app/controllers/notification_controller.dart';
import 'package:todo_app/controllers/task_controller.dart';
// import 'package:todo_app/controllers/task_controller.dart';
// import 'package:todo_app/models/category_task_model.dart';
import 'package:todo_app/utils/utils.dart';
import 'package:todo_app/widgets/task/choice_chip_task.dart';
import 'package:todo_app/widgets/task/time_picker.dart';

class CreateTaskDialogCopy extends StatelessWidget {
  const CreateTaskDialogCopy({super.key});

  @override
  Widget build(BuildContext context) {
    final NewTaskController newTaskController = Get.put(NewTaskController());
    final TaskController taskController = Get.find();
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
                    TextField(
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
                    const SizedBox(
                      height: 15,
                    ),
                    TextField(
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
                          "Add to category",
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
                    Obx(
                      () => RoundedLoadingButton(
                        successColor: Colors.green,
                        controller:
                            taskController.loadingButtonController.value,
                        onPressed: () async {
                          if (taskController
                              .taskController.value.text.isEmpty) {
                            showSnackbar(message: "Title task is required.");
                            taskController.loadingButtonController.value
                                .reset();
                          } else if (DateTime(
                                      DateTime.now().year,
                                      DateTime.now().month,
                                      DateTime.now().day,
                                      taskController.hour.value,
                                      taskController.minute.value)
                                  .isBefore(DateTime.now()) &&
                              DateTime(
                                int.parse(DateFormat("yyyy").format(
                                    newTaskController.daysOfWeek[
                                        newTaskController
                                            .selectedDayIndex.value])),
                                int.parse(DateFormat("MM").format(
                                    newTaskController.daysOfWeek[
                                        newTaskController
                                            .selectedDayIndex.value])),
                                int.parse(DateFormat("dd").format(
                                    newTaskController.daysOfWeek[
                                        newTaskController
                                            .selectedDayIndex.value])),
                                newTaskController.hour.value,
                                newTaskController.minute.value,
                              ).isBefore(DateTime.now())) {
                            showSnackbar(
                                message:
                                    "You selected a time in the past. Please choose a time again");
                            taskController.loadingButtonController.value
                                .reset();
                          } else {
                            // newTaskController.createTask(context);

                            await taskController.addTask(context).then((value) {
                              notificationController.scheduleNotification(
                                  id: 10,
                                  title: "Reminder: It's time to work!",
                                  body:
                                      "Don't forget the ${taskController.taskController.value.text} job at ${taskController.hour.value}:${taskController.minute.value} today. Do it as soon as you can!",
                                  payload: "",
                                  time: DateTime(
                                    DateTime.now().year,
                                    DateTime.now().month,
                                    DateTime.now().day,
                                    taskController.hour.value,
                                    taskController.minute.value,
                                  ));
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
