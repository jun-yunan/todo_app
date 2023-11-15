import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/controllers/task_controller.dart';
import 'package:todo_app/screens/home_screen.dart';
import 'package:todo_app/widgets/task/search_task_result.dart';

class SearchTaskDialog extends StatelessWidget {
  const SearchTaskDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final TaskController taskController = Get.find();
    return Dialog.fullscreen(
      backgroundColor: Colors.white,
      child: ListView(
        children: [
          Container(
            color: Colors.white,
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () {
                  Get.back();
                  taskController.searchTaskListResult.clear();
                  taskController.searchTask.value = "";
                  taskController.searchTaskController.value.text = "";
                },
                icon: const Icon(Icons.arrow_back),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  padding: const EdgeInsets.symmetric(),
                  decoration: const BoxDecoration(color: Colors.white),
                  child: TextField(
                    onChanged: (value) {
                      taskController.searchTask.value = value;
                      if (value.isNotEmpty) {
                        // taskController.handleSearchTaskToFirebase(value);
                        taskController.handleSearchTask(value);
                      } else {
                        taskController.searchTaskListResult.clear();
                      }
                    },
                    style: const TextStyle(fontSize: 18),
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 18, horizontal: 10),
                      hintText: "Enter keyword search task here...",
                      suffixIcon: IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.search),
                      ),
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const Divider(
            color: Colors.grey,
            thickness: 2,
          ),
          Container(
            height: 15,
            color: Colors.white,
          ),
          const SearchTaskResult()
        ],
      ),
    );
  }
}
