import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DialogUpdateTask extends StatelessWidget {
  final String title;
  const DialogUpdateTask({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text("Task"),
          IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.close,
              size: 26,
            ),
          )
        ],
      ),
      content: Text(title),
      // content: Column(
      //   crossAxisAlignment: CrossAxisAlignment.start,
      //   mainAxisSize: MainAxisSize.min,
      //   children: [
      //     TextFormField(
      //       controller: taskUpdateController,
      //       maxLines: 10,
      //     )
      //   ],
      // ),
      // actions: [
      //   RoundedLoadingButton(
      //     controller: taskController.loadingButtonController.value,
      //     onPressed: () {
      //       Get.snackbar("title", taskUpdateController.text);
      //     },
      //     successColor: Colors.green,
      //     child: const Text(
      //       "Update Task",
      //       style: TextStyle(
      //         fontSize: 18,
      //         fontWeight: FontWeight.bold,
      //         color: Colors.white,
      //       ),
      //     ),
      //   )
      // ],
    );
  }
}
