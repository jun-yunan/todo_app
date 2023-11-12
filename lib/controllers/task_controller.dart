import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:todo_app/models/task_model.dart';
// import 'package:todo_app/models/task_type_model.dart';
// import 'package:todo_app/models/task_type_model.dart';
// import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/utils/utils.dart';

class TaskController extends GetxController {
  final firebaseAuth = Rx<FirebaseAuth>(FirebaseAuth.instance);
  final firebaseFirestore = Rx<FirebaseFirestore>(FirebaseFirestore.instance);
  final firebaseStorage = Rx<FirebaseStorage>(FirebaseStorage.instance);

  final loadingButtonController =
      Rx<RoundedLoadingButtonController>(RoundedLoadingButtonController());

  final taskController = Rx<TextEditingController>(TextEditingController());

  final imageFile = Rx<File?>(null);

  final file = Rx<File?>(null);

  final dateController = Rx<TextEditingController>(TextEditingController());

  final taskModel = Rx<TaskModel?>(null);

  final isDone = Rx<bool>(false);

  final imageUrl = Rx<String>("");

  final isLoading = Rx<bool>(false);

  // final TaskType? taskType = Rx(null);

  final isSelectedPersonal = Rx<bool>(true);
  final isSelectedBusiness = Rx<bool>(false);

  Future<void> selectedImage() async {
    imageFile.value = await pickImage();
    update();
  }

  Future<void> selectedDate(BuildContext context) async {
    DateTime? pickDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2023),
      lastDate: DateTime(2050),
    );

    if (pickDate != null) {
      dateController.value.text = pickDate.toString().split(" ")[0];
      update();
    }
  }

  Future<String> uploadImage(String ref) async {
    String downloadUrl = "";
    try {
      UploadTask uploadTask =
          firebaseStorage.value.ref().child(ref).putFile(imageFile.value!);
      TaskSnapshot taskSnapshot = await uploadTask;
      downloadUrl = await taskSnapshot.ref.getDownloadURL();

      return downloadUrl;
    } catch (e) {
      print(e);
      showSnackbar(message: "Upload image failed!");
      return downloadUrl;
    }
  }

  Future<void> addTask(BuildContext context) async {
    try {
      isLoading.value = true;

      if (imageFile.value != null) {
        imageUrl.value = await uploadImage(
            'photo_task/${DateTime.now().millisecondsSinceEpoch.toString()}');
      }

      taskModel.value = TaskModel(
        date: dateController.value.text,
        uid: firebaseAuth.value.currentUser?.uid,
        title: taskController.value.text,
        isDone: isDone.value,
        imageUrl: imageUrl.value,
        createdAt: DateTime.now().millisecondsSinceEpoch.toString(),
        // taskType: taskType.b
        taskType: isSelectedPersonal.value == true ? "personal" : "business",
      );

      update();

      await firebaseFirestore.value
          .collection("tasks")
          .add(taskModel.toJson())
          .then(
        (value) async {
          await firebaseFirestore.value
              .collection("tasks")
              .doc(value.id)
              .update({"id": value.id}).then(
            (value) {
              showSnackbar(
                message: "Add task successfully!",
                type: SnackBarType.success,
              );
              isLoading.value = false;
              loadingButtonController.value.success();
              taskController.value.text = "";
              dateController.value.text = "";
              imageFile.value = null;
              Future.delayed(
                const Duration(milliseconds: 100),
                () {
                  Navigator.of(context).pop();
                },
              );
            },
          );
        },
      );
    } catch (e) {
      loadingButtonController.value.reset();
      print(e);
      showSnackbar(message: e.toString());
    }
  }

  Stream<List<TaskModel>> getTasksRealTime() {
    final StreamController<List<TaskModel>> taskController =
        StreamController<List<TaskModel>>.broadcast();

    final query = firebaseFirestore.value
        .collection("tasks")
        .where("uid", isEqualTo: firebaseAuth.value.currentUser?.uid)
        .orderBy("createdAt", descending: true);

    final documentStream = query.snapshots();

    documentStream.listen(
      (QuerySnapshot querySnapshot) {
        final taskList = querySnapshot.docs.map((document) {
          return TaskModel(
            uid: document["uid"],
            date: document["date"],
            imageUrl: document["imageUrl"],
            fileUrl: document["fileUrl"],
            id: document["id"],
            isDone: document["isDone"],
            title: document["title"],
            taskType: document["taskType"],
            createdAt: document["createdAt"],
          );
        }).toList();

        taskController.add(taskList);
      },
    );

    return taskController.stream;
  }
}