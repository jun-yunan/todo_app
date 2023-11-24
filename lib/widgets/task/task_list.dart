import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/controllers/task_controller.dart';
import 'package:todo_app/models/task_model.dart';
import 'package:todo_app/models/task_type_model.dart';
import 'package:todo_app/widgets/task/task_item.dart';

class TaskList extends StatelessWidget {
  const TaskList({super.key});

  @override
  Widget build(BuildContext context) {
    final TaskController taskController = Get.find();
    return Obx(() {
      if (taskController.filterPersonal.value &&
          taskController.filterBusiness.value == false) {
        final List<TaskModel> taskListPeronal = taskController.taskList
            .where((task) => task.taskType == "personal")
            .toList();
        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: taskListPeronal.length,
          itemBuilder: (context, index) {
            return TaskItem(
              taskType: taskListPeronal[index].taskType == "personal"
                  ? TaskType.personal
                  : TaskType.business,
              title: taskListPeronal[index].title ?? "",
              id: taskListPeronal[index].id ?? "",
              isDone: taskListPeronal[index].isDone ?? false,
              date: taskListPeronal[index].date ?? "",
              imageUrl: taskListPeronal[index].imageUrl ?? "",
              subtitle: taskListPeronal[index].date ?? "",
              details: taskController.taskList[index].details ?? "",
              time: taskController.taskList[index].time ?? "",
            );
          },
        );
      } else if (taskController.filterBusiness.value &&
          taskController.filterPersonal.value == false) {
        final List<TaskModel> taskListBusiness = taskController.taskList
            .where((task) => task.taskType == "business")
            .toList();
        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: taskListBusiness.length,
          itemBuilder: (context, index) {
            return TaskItem(
              taskType: taskListBusiness[index].taskType == "personal"
                  ? TaskType.personal
                  : TaskType.business,
              title: taskListBusiness[index].title ?? "",
              id: taskListBusiness[index].id ?? "",
              isDone: taskListBusiness[index].isDone ?? false,
              date: taskListBusiness[index].date ?? "",
              imageUrl: taskListBusiness[index].imageUrl ?? "",
              subtitle: taskListBusiness[index].date ?? "",
              details: taskController.taskList[index].details ?? "",
              time: taskController.taskList[index].time ?? "",
            );
          },
        );
      }

      return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: taskController.taskList.length,
        itemBuilder: (context, index) {
          return TaskItem(
            taskType: taskController.taskList[index].taskType == "personal"
                ? TaskType.personal
                : TaskType.business,
            title: taskController.taskList[index].title ?? "",
            id: taskController.taskList[index].id ?? "",
            isDone: taskController.taskList[index].isDone ?? false,
            date: taskController.taskList[index].date ?? "",
            imageUrl: taskController.taskList[index].imageUrl ?? "",
            subtitle: taskController.taskList[index].date ?? "",
            details: taskController.taskList[index].details ?? "",
            time: taskController.taskList[index].time ?? "",
          );
        },
      );
    });
  }
}
