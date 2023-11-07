import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:todo_app/controllers/add_task_controller.dart';
import 'package:todo_app/utils/utils.dart';
import 'package:todo_app/widgets/action_add_task.dart';

class AddTask extends StatelessWidget {
  const AddTask({super.key});

  @override
  Widget build(BuildContext context) {
    final AddTaskController addTaskController = Get.put(AddTaskController());
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
                      () => addTaskController.imageFile.value == null
                          ? const SizedBox()
                          : Stack(
                              clipBehavior: Clip.none,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: Image.file(
                                    addTaskController.imageFile.value!,
                                    height: 300,
                                    width: 300,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Positioned(
                                  right: -20,
                                  bottom: -20,
                                  child: IconButton(
                                    tooltip: "Delete image",
                                    onPressed: () {
                                      addTaskController.imageFile.value = null;
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
                      controller: addTaskController.taskController.value,
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
                    TextFormField(
                      readOnly: true,
                      controller: addTaskController.dateController.value,
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
                        addTaskController.selectedDate(context);
                      },
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.radio_button_unchecked,
                        color: Colors.purple,
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        ActionAddTask(
                          icon: Icons.add_photo_alternate_outlined,
                          onPressed: () {
                            addTaskController.selectedImage();
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
                // ElevatedButton(
                //   onPressed: () {
                //     Get.dialog(
                //       Dialog(
                //         child: Obx(
                //           () => addTaskController.isLoading.value == true
                //               ? Container(
                //                   width: 300,
                //                   height: 200,
                //                   decoration: BoxDecoration(
                //                     color: Colors.white,
                //                     borderRadius: BorderRadius.circular(15),
                //                   ),
                //                   child: const Center(
                //                     child: Column(
                //                       mainAxisAlignment:
                //                           MainAxisAlignment.center,
                //                       children: [
                //                         CircularProgressIndicator(
                //                           color: Colors.grey,
                //                         ),
                //                         SizedBox(
                //                           height: 22,
                //                         ),
                //                         Text(
                //                           "Add task loading...",
                //                           style: TextStyle(
                //                             fontSize: 20,
                //                             fontWeight: FontWeight.bold,
                //                             color: Colors.grey,
                //                           ),
                //                         ),
                //                       ],
                //                     ),
                //                   ),
                //                 )
                //               : Container(
                //                   width: 300,
                //                   height: 200,
                //                   decoration: BoxDecoration(
                //                     borderRadius: BorderRadius.circular(15),
                //                     color: Colors.green.shade100,
                //                   ),
                //                   child: Column(
                //                     mainAxisAlignment: MainAxisAlignment.center,
                //                     children: [
                //                       Icon(
                //                         Icons.check_circle,
                //                         size: 45,
                //                         color: Colors.green.shade800,
                //                       ),
                //                       const SizedBox(
                //                         height: 22,
                //                       ),
                //                       Text(
                //                         "Add task successfully",
                //                         style: TextStyle(
                //                           fontSize: 20,
                //                           fontWeight: FontWeight.bold,
                //                           color: Colors.green.shade800,
                //                         ),
                //                       ),
                //                     ],
                //                   ),
                //                 ),
                //         ),
                //       ),
                //     );
                //   },
                //   style: ElevatedButton.styleFrom(
                //     backgroundColor: Colors.purple,
                //     foregroundColor: Colors.white,
                //   ),
                //   child: const Row(
                //     mainAxisAlignment: MainAxisAlignment.center,
                //     children: [
                //       Text(
                //         "Add task",
                //         style: TextStyle(
                //           fontSize: 20,
                //           fontWeight: FontWeight.bold,
                //         ),
                //       ),
                //       Icon(
                //         Icons.expand_less,
                //         size: 30,
                //       )
                //     ],
                //   ),
                // )
                RoundedLoadingButton(
                  controller: addTaskController.loadingButtonController.value,
                  successColor: Colors.green,
                  onPressed: () {
                    if (addTaskController.taskController.value.text.isEmpty) {
                      return showSnackbar(message: "Title task is required!");
                    }
                    addTaskController.addTask(context);
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
