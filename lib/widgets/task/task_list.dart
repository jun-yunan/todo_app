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
    return StreamBuilder<List<TaskModel>>(
      stream: taskController.getTasksRealTime(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (snapshot.hasError) {
          return const Center(
            child: Text("Something went wrong!"),
          );
        }
        if (!snapshot.hasData) {
          return const Center(
            child: Text("No data available"),
          );
        }
        List<TaskModel> tasks = snapshot.data!;
        return ListView.builder(
          shrinkWrap: true,
          itemCount: tasks.length,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return TaskItem(
              taskType: tasks[index].taskType == "personal"
                  ? TaskType.personal
                  : TaskType.business,
              title: tasks[index].title!,
            );
          },
        );
      },
    );
  }
}
