import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:todo_app/controllers/task_controller.dart';
import 'package:todo_app/models/task_type_model.dart';
import 'package:todo_app/utils/utils.dart';
import 'package:todo_app/widgets/task/action_button_task.dart';
import 'package:todo_app/widgets/task/choice_chip_task.dart';
import 'package:todo_app/widgets/task/close_button_task.dart';
import 'package:todo_app/widgets/task/pick_date_task.dart';

class UpdateTask extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String date;
  final TaskType taskType;
  final String id;
  const UpdateTask({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.date,
    required this.taskType,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    final TaskController taskController = Get.put(TaskController());
    taskController.taskController.value.text = title;
    taskController.isSelectedPersonal.value =
        taskType == TaskType.personal ? true : false;
    taskController.isSelectedBusiness.value =
        taskType == TaskType.business ? true : false;
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(25),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: Theme.of(context).colorScheme.background,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [SizedBox(), CloseButtonTask()],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  imageUrl.isEmpty
                      ? const SizedBox()
                      : Stack(
                          clipBehavior: Clip.none,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Image.network(
                                imageUrl,
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
                  const SizedBox(
                    height: 25,
                  ),
                  TextField(
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                    controller: taskController.taskController.value,
                    maxLines: 3,
                    decoration: const InputDecoration(
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      hintText: "Enter new task ...",
                      hintStyle: TextStyle(fontSize: 20),
                    ),
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

                  taskController.updateTaskById(id).then((value) {
                    Future.delayed(const Duration(milliseconds: 500), () {
                      Navigator.of(context).pop();
                    });
                  });
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Update Task",
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
