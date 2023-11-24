import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/controllers/profile_controller.dart';
// import 'package:todo_app/controllers/task_controller.dart';
// import 'package:todo_app/models/user_model.dart';
import 'package:todo_app/widgets/task/task_category.dart';
import 'package:todo_app/widgets/task/task_list.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    final ProfileController profileController = Get.find();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: const BoxDecoration(),
      child: ListView(
        children: [
          const SizedBox(
            height: 15,
          ),
          Obx(
            () => Text(
              "What's up, ${profileController.currentUser.value?.name}!",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          const TaskCategory(),
          const SizedBox(
            height: 25,
          ),
          Text(
            "TODAY'S TASKS",
            style: TextStyle(
                color: Colors.grey.shade500, fontWeight: FontWeight.w500),
          ),
          const TaskList(),
          const SizedBox(
            height: 85,
          )
        ],
      ),
    );
  }
}
