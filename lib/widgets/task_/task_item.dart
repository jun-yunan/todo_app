import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/controllers/new_task_controller.dart';
import 'package:todo_app/models/category_task_model.dart';
import 'package:todo_app/screens/task/details_task_screen.dart';
import 'package:todo_app/utils/utils.dart';
import 'package:todo_app/widgets/dialog/edit_task_dialog%20copy.dart';
import 'package:todo_app/widgets/task_/task_options.dart';
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

            Get.dialog(TaskOptions(
              index: index,
            ));
          });
        },
        // onTap: () {
        //   Get.dialog(
        //     EditTaskDialogCopy(
        //       id: newTaskController.taskListByUser[index].id!,
        //       title: newTaskController.taskListByUser[index].title!,
        //       categoryTask: CategoryTaskType.values.firstWhere((element) =>
        //           element.toString() ==
        //           "CategoryTaskType.${newTaskController.taskListByUser[index].categoryTask!}"),
        //       isDone: newTaskController.taskListByUser[index].isDone!,
        //       date: newTaskController.taskListByUser[index].date!,
        //       details: newTaskController.taskListByUser[index].details!,
        //       time: newTaskController.taskListByUser[index].time!,
        //     ),
        //   );
        // },
        onTap: () {
          // showSnackbar(message: "message");
          Get.to(() => DetailsTaskScreen(
                taskId: newTaskController.taskListByUser[index].id!,
              ));
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.symmetric(vertical: 10),
          // padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
          // height: 160,
          height: index == 0
              ? 160
              : index == 1
                  ? 160
                  : 60,
          decoration: BoxDecoration(
            color: newTaskController.isOnLongPress.value
                ? Color(int.parse(
                        "0xFF${newTaskController.taskListByUser[index].hexColor}"))
                    .withOpacity(0.2)
                : Color(int.parse(
                    "0xFF${newTaskController.taskListByUser[index].hexColor}")),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Stack(
            children: [
              if (index == 0 || index == 1)
                Positioned(
                  bottom: index == 0 ? -120 : 60,
                  right: index == 0 ? -80 : -80,
                  child: Container(
                    height: 250,
                    width: 250,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(1000),
                      border: Border.all(
                        width: 50,
                        color: newTaskController
                                    .taskListByUser[index].categoryTask ==
                                CategoryTaskType.Personal.name
                            ? const Color(0xff7fc8ed)
                            : newTaskController
                                        .taskListByUser[index].categoryTask ==
                                    CategoryTaskType.Work.name
                                ? const Color(0xffe7534d)
                                : Colors.purple,
                      ),
                    ),
                  ),
                ),
              if (index != 0 && index != 1)
                Positioned(
                  right: 30,
                  bottom: -25,
                  top: -25,
                  child: Transform.rotate(
                    angle: -0.3,
                    child: Container(
                      width: 35,
                      height: 120,
                      decoration: const BoxDecoration(color: Colors.white24),
                    ),
                  ),
                ),
              if (index != 0 && index != 1)
                Positioned(
                  right: 65,
                  bottom: -25,
                  top: -25,
                  child: Transform.rotate(
                    angle: -0.3,
                    child: Container(
                      width: 35,
                      height: 120,
                      decoration: const BoxDecoration(
                        color: Colors.white10,
                      ),
                    ),
                  ),
                ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                child: Column(
                  mainAxisAlignment: index == 0 || index == 1
                      ? MainAxisAlignment.spaceBetween
                      : MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          newTaskController.taskListByUser[index].title!,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        if (newTaskController
                                .taskListByUser[index].details!.isNotEmpty &&
                            (index == 0 || index == 1))
                          Text(
                            newTaskController.taskListByUser[index].details!,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style: TextStyle(
                              color: Colors.grey.shade200,
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                      ],
                    ),
                    // const SizedBox(
                    //   height: 25,
                    // ),
                    if (index == 0 || index == 1)
                      TextButton(
                        onPressed: () {},
                        style: TextButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: Color(int.parse(
                                "0xFF${newTaskController.taskListByUser[index].hexColor}"))),
                        child: Text(
                          newTaskController.taskListByUser[index].time!,
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
              if (newTaskController.taskListByUser[index].isDone!)
                Positioned(
                  right: 15,
                  top: 15,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.green.shade700,
                      borderRadius: BorderRadius.circular(15000),
                    ),
                    child: const Row(
                      children: [
                        Icon(
                          Icons.check,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 6,
                        ),
                        Text(
                          "Completed",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        )
                      ],
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
