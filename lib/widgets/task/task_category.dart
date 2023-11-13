import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/controllers/task_controller.dart';

class TaskCategory extends StatelessWidget {
  const TaskCategory({super.key});

  @override
  Widget build(BuildContext context) {
    final TaskController taskController = Get.find();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "CATEGORIES",
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: Colors.grey.shade500,
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
                flex: 1,
                child: Obx(
                  () => GestureDetector(
                    onTap: () {
                      // showSnackbar(message: "message");
                      taskController.filterBusiness.value =
                          !taskController.filterBusiness.value;
                    },
                    child: Container(
                      // width: 150,
                      height: 125,
                      decoration: BoxDecoration(
                          color: taskController.filterBusiness.value
                              ? Colors.purple.shade100
                              : Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: const [
                            BoxShadow(color: Colors.black12, blurRadius: 15)
                          ]),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 15),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Obx(
                              () => Text(
                                  "${taskController.countTaskTypeBusiness()} tasks"),
                            ),
                            Text(
                              "Business",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                            const Divider(
                              color: Colors.purple,
                              thickness: 4,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                )),
            const SizedBox(
              width: 25,
            ),
            Expanded(
              flex: 1,
              child: Obx(
                () => GestureDetector(
                  onTap: () {
                    taskController.filterPersonal.value =
                        !taskController.filterPersonal.value;
                  },
                  child: Container(
                    // width: 150,
                    height: 125,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 15,
                        )
                      ],
                      // color: Colors.white,
                      color: taskController.filterPersonal.value
                          ? Colors.cyan.shade100
                          : Colors.white,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 15),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Obx(
                            () => Text(
                                "${taskController.countTaskTypePersonal()} tasks"),
                          ),
                          Text(
                            "Personal",
                            style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).colorScheme.primary),
                          ),
                          const Divider(
                            color: Colors.cyan,
                            thickness: 4,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ],
    );
  }
}
