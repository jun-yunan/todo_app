import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:todo_app/controllers/task_controller.dart';
import 'package:todo_app/utils/utils.dart';
import 'package:todo_app/widgets/action_add_task.dart';

class AddTask extends StatelessWidget {
  const AddTask({super.key});

  @override
  Widget build(BuildContext context) {
    final TaskController taskController = Get.put(TaskController());
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(25),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              // mainAxisSize: MainAxisSize.max,
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
                    Row(
                      children: [
                        Obx(
                          () => ChoiceChip(
                            avatar:
                                taskController.isSelectedPersonal.value == true
                                    ? null
                                    : const Icon(
                                        Icons.radio_button_unchecked,
                                      ),
                            backgroundColor:
                                Colors.cyan.shade100.withOpacity(0.2),
                            selectedColor:
                                Colors.cyan.shade100.withOpacity(0.2),
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
                                      ),
                            backgroundColor:
                                Colors.purple.shade100.withOpacity(0.2),
                            selectedColor:
                                Colors.purple.shade100.withOpacity(0.2),
                            side: const BorderSide(
                                width: 2, color: Colors.purple),
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
                    TextFormField(
                      readOnly: true,
                      controller: taskController.dateController.value,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(
                            width: 2,
                            color: Colors.purple,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(
                            width: 2,
                            color: Colors.purple,
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
                    )
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
                // const SizedBox(
                //   height: 15,
                // )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
