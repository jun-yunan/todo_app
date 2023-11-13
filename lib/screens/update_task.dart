import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:todo_app/controllers/task_controller.dart';
import 'package:todo_app/models/task_type_model.dart';
import 'package:todo_app/utils/utils.dart';
import 'package:todo_app/widgets/action_add_task.dart';

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
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(),
                  IconButton(
                    style: IconButton.styleFrom(
                      padding: const EdgeInsets.all(10),
                      backgroundColor: Colors.grey.shade200,
                    ),
                    onPressed: () {
                      Get.back();
                      taskController.taskController.value.text = "";
                      taskController.dateController.value.text = "";
                      taskController.imageFile.value = null;
                    },
                    icon: const Icon(
                      Icons.close,
                      size: 30,
                    ),
                  )
                ],
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
                  Row(
                    children: [
                      ActionAddTask(
                        icon: Icons.add_photo_alternate_outlined,
                        onPressed: () {
                          taskController.selectedImage();
                        },
                      ),
                      ActionAddTask(
                        icon: Icons.upload_file,
                        onPressed: () {},
                      ),
                      ActionAddTask(
                        icon: Icons.mood,
                        onPressed: () {},
                      ),
                      ActionAddTask(
                        icon: Icons.flag_outlined,
                        onPressed: () {},
                      ),
                      ActionAddTask(
                        onPressed: () {},
                        icon: Icons.dark_mode_outlined,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    readOnly: true,
                    controller: taskController.dateController.value,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey.shade100,
                      contentPadding: const EdgeInsets.symmetric(vertical: 5),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(
                          width: 2,
                          color: Colors.grey,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(
                          width: 2,
                          color: Colors.grey,
                        ),
                      ),
                      prefixIcon: const Icon(Icons.calendar_today),
                      hintText: "Today",
                    ),
                    onTap: () {
                      taskController.selectedDate(context);
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      Obx(
                        () => ChoiceChip(
                          avatar:
                              taskController.isSelectedPersonal.value == true
                                  ? null
                                  : const Icon(
                                      Icons.radio_button_unchecked,
                                      color: Colors.cyan,
                                    ),
                          backgroundColor:
                              Colors.cyan.shade100.withOpacity(0.2),
                          selectedColor: Colors.cyan.shade100.withOpacity(0.2),
                          side: const BorderSide(
                            width: 2,
                            color: Colors.cyan,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          label: const Text(
                            "Personal",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: Colors.cyan,
                            ),
                          ),
                          selected: taskController.isSelectedPersonal.value,
                          onSelected: (value) {
                            taskController.isSelectedPersonal.value = value;
                            taskController.isSelectedBusiness.value = !value;
                          },
                        ),
                      ),
                      const SizedBox(
                        width: 35,
                      ),
                      Obx(
                        () => ChoiceChip(
                          avatar:
                              taskController.isSelectedBusiness.value == true
                                  ? null
                                  : const Icon(
                                      Icons.radio_button_unchecked,
                                      color: Colors.purple,
                                    ),
                          backgroundColor:
                              Colors.purple.shade100.withOpacity(0.2),
                          selectedColor:
                              Colors.purple.shade100.withOpacity(0.2),
                          side:
                              const BorderSide(width: 2, color: Colors.purple),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          label: const Text(
                            "Business",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: Colors.purple,
                            ),
                          ),
                          selected: taskController.isSelectedBusiness.value,
                          onSelected: (value) {
                            taskController.isSelectedBusiness.value = value;
                            taskController.isSelectedPersonal.value = !value;
                          },
                        ),
                      ),
                    ],
                  ),
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
