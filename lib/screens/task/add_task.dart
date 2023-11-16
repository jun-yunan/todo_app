import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:todo_app/controllers/task_controller.dart';
import 'package:todo_app/utils/utils.dart';
import 'package:todo_app/widgets/task/action_button_task.dart';
import 'package:todo_app/widgets/task/choice_chip_task.dart';
import 'package:todo_app/widgets/task/close_button_task.dart';
import 'package:todo_app/widgets/task/pick_date_task.dart';

class AddTask extends StatelessWidget {
  const AddTask({super.key});

  @override
  Widget build(BuildContext context) {
    final TaskController taskController = Get.put(TaskController());
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(25),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: Theme.of(context).colorScheme.background,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            // mainAxisSize: MainAxisSize.max,
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [SizedBox(), CloseButtonTask()],
              ),
              Column(
                children: [
                  Obx(
                    () => taskController.imageFile.value == null
                        ? const SizedBox()
                        : Stack(
                            clipBehavior: Clip.none,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: Image.file(
                                  taskController.imageFile.value!,
                                  height: 300,
                                  width: 350,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Positioned(
                                right: -20,
                                bottom: -20,
                                child: IconButton(
                                  tooltip: "Delete image",
                                  onPressed: () {
                                    taskController.imageFile.value = null;
                                  },
                                  style: IconButton.styleFrom(
                                    backgroundColor: Colors.red.shade100,
                                  ),
                                  icon: const Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                    size: 30,
                                  ),
                                ),
                              )
                            ],
                          ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  TextFormField(
                    style: const TextStyle(fontSize: 20),
                    controller: taskController.taskController.value,
                    decoration: const InputDecoration(
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      hintText: "Enter new task ...",
                      hintStyle: TextStyle(fontSize: 20),
                    ),
                  ),
                  const SizedBox(
                    height: 35,
                  ),
                  const ActionButtonTask(),
                  const SizedBox(
                    height: 15,
                  ),
                  const PickDateTask(),
                  const SizedBox(
                    height: 15,
                  ),
                  const ChoiceChipTask(),
                  const SizedBox(
                    height: 15,
                  ),
                ],
              ),
              RoundedLoadingButton(
                controller: taskController.loadingButtonController.value,
                successColor: Colors.green,
                onPressed: () {
                  if (taskController.taskController.value.text.isEmpty) {
                    taskController.loadingButtonController.value.reset();
                    return showSnackbar(message: "Title task is required!");
                  }

                  taskController.addTask(context);
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Add task",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Icon(
                      Icons.expand_less,
                      color: Colors.white,
                      size: 30,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
