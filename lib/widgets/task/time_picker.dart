import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:todo_app/controllers/new_task_controller.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:todo_app/controllers/task_controller.dart';

class TimePicker extends StatelessWidget {
  const TimePicker({super.key});

  @override
  Widget build(BuildContext context) {
    // final NewTaskController newTaskController = Get.find();
    final TaskController taskController = Get.find();

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Obx(
          () => Text(
            "Pick your time! ${taskController.hour.value.toString().padLeft(2, "0")}:${taskController.minute.value.toString().padLeft(2, "0")} ${taskController.timeFormat.value}",
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            // color: Colors.white,
            color: Theme.of(context).colorScheme.background,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Obx(
                () => NumberPicker(
                  minValue: 0,
                  maxValue: 23,
                  value: taskController.hour.value,
                  zeroPad: true,
                  infiniteLoop: true,
                  itemWidth: 80,
                  itemHeight: 50,
                  onChanged: (value) {
                    taskController.setHour(value);
                  },
                  textStyle: const TextStyle(color: Colors.grey, fontSize: 16),
                  selectedTextStyle: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 26),
                  decoration: const BoxDecoration(
                    border: Border(
                      top: BorderSide(color: Colors.white),
                      bottom: BorderSide(color: Colors.white),
                    ),
                  ),
                ),
              ),
              const Text(
                ":",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Obx(
                () => NumberPicker(
                  minValue: 0,
                  maxValue: 59,
                  value: taskController.minute.value,
                  zeroPad: true,
                  infiniteLoop: true,
                  itemWidth: 80,
                  itemHeight: 50,
                  onChanged: (value) {
                    taskController.setMinute(value);
                  },
                  textStyle: const TextStyle(color: Colors.grey, fontSize: 16),
                  selectedTextStyle: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 26),
                  decoration: const BoxDecoration(
                    border: Border(
                      top: BorderSide(color: Colors.white),
                      bottom: BorderSide(color: Colors.white),
                    ),
                  ),
                ),
              ),
              Column(
                children: [
                  Obx(
                    () => GestureDetector(
                      onTap: () {
                        taskController.setTimeFormat("AM");
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: taskController.timeFormat.value == "AM"
                              ? Colors.grey.shade800
                              : Colors.grey.shade600,
                        ),
                        child: const Text(
                          "AM",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Obx(
                    () => GestureDetector(
                      onTap: () {
                        taskController.setTimeFormat("PM");
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: taskController.timeFormat.value == "PM"
                              ? Colors.grey.shade800
                              : Colors.grey.shade600,
                        ),
                        child: const Text(
                          "PM",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        )
      ],
    );
  }
}
