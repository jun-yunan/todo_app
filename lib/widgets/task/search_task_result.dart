import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/controllers/task_controller.dart';
import 'package:todo_app/models/task_type_model.dart';
import 'package:todo_app/widgets/task/task_item.dart';

class SearchTaskResult extends StatelessWidget {
  const SearchTaskResult({super.key});

  @override
  Widget build(BuildContext context) {
    final TaskController taskController = Get.find();
    return Obx(
      () => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: taskController.searchTaskListResult.length,
          itemBuilder: (context, index) {
            if (taskController.searchTaskListResult.isNotEmpty &&
                taskController.searchTask.value.isNotEmpty) {
              return TaskItem(
                taskType: taskController.searchTaskListResult[index].taskType ==
                        "personal"
                    ? TaskType.personal
                    : TaskType.business,
                title: taskController.searchTaskListResult[index].title ?? "",
                id: taskController.searchTaskListResult[index].id ?? "",
                isDone:
                    taskController.searchTaskListResult[index].isDone ?? false,
                date: taskController.searchTaskListResult[index].date ?? "",
                imageUrl:
                    taskController.searchTaskListResult[index].imageUrl ?? "",
                subtitle: taskController.searchTaskListResult[index].date ?? "",
              );
            }
            return Text("loading");
          },
        ),
      ),
    );
  }
}
