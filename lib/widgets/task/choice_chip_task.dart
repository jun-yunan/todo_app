import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/controllers/task_controller.dart';

class ChoiceChipTask extends StatelessWidget {
  const ChoiceChipTask({super.key});

  @override
  Widget build(BuildContext context) {
    final TaskController taskController = Get.find();
    return Row(
      children: [
        Obx(
          () => ChoiceChip(
            backgroundColor: Colors.transparent,
            selectedColor: Colors.cyan,
            showCheckmark: false,
            side: const BorderSide(
              width: 2,
              color: Colors.cyan,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            label: Text(
              "Personal",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: taskController.isSelectedPersonal.value == true
                    ? Colors.white
                    : Theme.of(context).colorScheme.primary,
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
          width: 15,
        ),
        Obx(
          () => ChoiceChip(
            backgroundColor: Colors.transparent,
            showCheckmark: false,
            selectedColor: Colors.purple,
            side: const BorderSide(width: 2, color: Colors.purple),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            label: Text(
              "Business",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: taskController.isSelectedBusiness.value
                    ? Colors.white
                    : Theme.of(context).colorScheme.primary,
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
    );
  }
}
