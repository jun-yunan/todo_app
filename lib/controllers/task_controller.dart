import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:todo_app/models/category_task_model.dart';
import 'package:todo_app/models/task_model.dart';
// import 'package:todo_app/models/task_type_model.dart';
// import 'package:todo_app/models/task_type_model.dart';
// import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/utils/utils.dart';
// import 'package:todo_app/widgets/task/task_list.dart';

enum CategoryTask { Personal, Work }

class TaskController extends GetxController {
  final firebaseAuth = Rx<FirebaseAuth>(FirebaseAuth.instance);
  final firebaseFirestore = Rx<FirebaseFirestore>(FirebaseFirestore.instance);
  final firebaseStorage = Rx<FirebaseStorage>(FirebaseStorage.instance);

  final loadingButtonController =
      Rx<RoundedLoadingButtonController>(RoundedLoadingButtonController());

  final taskController = Rx<TextEditingController>(TextEditingController());

  final detailsTaskController =
      Rx<TextEditingController>(TextEditingController(text: ""));

  final hour = Rx<int>(int.parse(DateFormat("HH").format(DateTime.now())));
  final minute = Rx<int>(int.parse(DateFormat('mm').format(DateTime.now())));
  final timeFormat = Rx<String>(DateFormat('a').format(DateTime.now()));

  final listCategoryTask =
      RxList<CategoryTask>([CategoryTask.Personal, CategoryTask.Work]);

  final selectedCategoryTasks = Rx<CategoryTaskType>(CategoryTaskType.Personal);

  final imageFile = Rx<File?>(null);

  final file = Rx<File?>(null);

  final dateController = Rx<TextEditingController>(TextEditingController());

  final taskModel = Rx<TaskModel?>(null);

  final isDone = Rx<bool>(false);

  final imageUrl = Rx<String>("");

  final isLoading = Rx<bool>(false);

  final task = Rx<TaskModel?>(null);

  final isSelectedPersonal = Rx<bool>(true);

  final isSelectedBusiness = Rx<bool>(false);

  final taskList = RxList<TaskModel>([]);

  final isLoadingSearchTask = Rx<bool>(false);

  final searchTaskController =
      Rx<TextEditingController>(TextEditingController());

  final searchTask = Rx<String>("");

  final filterPersonal = Rx<bool>(false);
  final filterBusiness = Rx<bool>(false);

  StreamSubscription? subscription;
  @override
  void onInit() {
    subscription = getListTaskRealTime().listen((tasks) {
      taskList.assignAll(tasks);
    });
    super.onInit();
  }

  @override
  void onClose() {
    subscription?.cancel();
    super.onClose();
  }

  void setHour(value) {
    hour.value = value;
    update();
  }

  void setMinute(value) {
    minute.value = value;
    update();
  }

  void setTimeFormat(value) {
    timeFormat.value = value;
    update();
  }

  void resetFormCreateTask() {
    taskController.value.text = "";
    detailsTaskController.value.text = "";
    selectedCategoryTasks.value = CategoryTaskType.Personal;
    hour.value = int.parse(DateFormat("HH").format(DateTime.now()));
    minute.value = int.parse(DateFormat('mm').format(DateTime.now()));
    timeFormat.value = DateFormat('a').format(DateTime.now());
  }

  final searchTaskListResult = RxList<TaskModel>([]);

  Future<void> handleSearchTaskToFirebase(String searchText) async {
    try {
      isLoadingSearchTask.value = true;
      QuerySnapshot querySnapshot = await firebaseFirestore.value
          .collection("tasks")
          .where("uid", isEqualTo: firebaseAuth.value.currentUser?.uid)
          .where("title", isGreaterThanOrEqualTo: searchText.trim())
          .where("title", isLessThanOrEqualTo: '${searchText.trim()}\uf8ff')
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        searchTaskListResult.assignAll(querySnapshot.docs.map((doc) {
          return TaskModel.fromJson(doc.data() as Map<String, dynamic>);
        }).toList());
      } else {
        searchTaskListResult.clear();
      }
      isLoadingSearchTask.value = false;
    } catch (e) {
      isLoadingSearchTask.value = false;
      print(e);
      showSnackbar(message: e.toString());
    }
  }

  void handleSearchTask(String searchText) {
    searchTaskListResult.value = taskList
        .where((task) =>
            task.title!.toLowerCase().contains(searchText.toLowerCase()))
        .toList();
  }

  int countTaskTypePersonal() {
    return taskList
        .where((task) => task.taskType == "personal")
        .toList()
        .length;
  }

  int countTaskTypeBusiness() {
    return taskList
        .where((task) => task.taskType == "business")
        .toList()
        .length;
  }

  Stream<List<TaskModel>> getListTaskRealTime() {
    return firebaseFirestore.value
        .collection("tasks")
        .where("uid", isEqualTo: firebaseAuth.value.currentUser?.uid)
        .orderBy("createdAt", descending: true)
        .snapshots()
        .map((querySnapshot) {
      return querySnapshot.docs.map((doc) {
        return TaskModel.fromJson(doc.data());
      }).toList();
    });
  }

  Future<void> getTaskList() async {
    try {
      await firebaseFirestore.value
          .collection("tasks")
          .get()
          .then((QuerySnapshot querySnapshot) {
        if (querySnapshot.docs.isNotEmpty) {
          taskList.assignAll(querySnapshot.docs.map((doc) {
            return TaskModel.fromJson(doc.data() as Map<String, dynamic>);
          }).toList());
        }
      });
    } catch (e) {
      print(e);
    }
  }

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
      // if (imageFile.value != null) {
      //   imageUrl.value = await uploadImage(
      //       'photo_task/${DateTime.now().millisecondsSinceEpoch.toString()}');
      // }

      taskModel.value = TaskModel(
        // date: dateController.value.text,
        date: DateFormat("EEE dd MM yyyy").format(DateTime.now()),
        details: detailsTaskController.value.text,
        time: "${hour.value}:${minute.value} ${timeFormat.value}",
        uid: firebaseAuth.value.currentUser?.uid,
        title: taskController.value.text,
        isDone: isDone.value,
        imageUrl: imageUrl.value,
        createdAt: DateTime.now().millisecondsSinceEpoch.toString(),
        id: "",
        fileUrl: "",

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
              // isLoading.value = false;
              loadingButtonController.value.success();
              // taskController.value.text = "";
              // dateController.value.text = "";
              // imageFile.value = null;
              Future.delayed(
                const Duration(milliseconds: 500),
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

  Future<void> updateTaskById(String id) async {
    try {
      DocumentSnapshot documentSnapshot =
          await firebaseFirestore.value.collection("tasks").doc(id).get();

      if (documentSnapshot.exists) {
        await firebaseFirestore.value.collection("tasks").doc(id).update({
          "title": taskController.value.text,
          "date": dateController.value.text,
          "taskType":
              isSelectedPersonal.value == true ? "personal" : "business",
          "details": detailsTaskController.value.text,
          "time": "${hour.value}:${minute.value} ${timeFormat.value}",
        }).then((value) {
          loadingButtonController.value.success();
          showSnackbar(
            message: "Update task successfully!",
            type: SnackBarType.success,
          );
        });
      } else {
        showSnackbar(message: "Task does not exists.");
        loadingButtonController.value.reset();
      }
    } catch (e) {
      print(e);
      loadingButtonController.value.reset();

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

  Stream<int> countPersonal() {
    return FirebaseFirestore.instance
        .collection("tasks")
        .where("taskType", isEqualTo: "personal")
        .snapshots()
        .map((querySnapshot) => querySnapshot.docs.length);
  }

  Stream<int> countBusiness() {
    return firebaseFirestore.value
        .collection("tasks")
        .where("taskType", isEqualTo: "business")
        .snapshots()
        .map((querySnapshot) => querySnapshot.docs.length);
  }

  Future deleteTaskById(String id) async {
    try {
      DocumentSnapshot documentSnapshot =
          await firebaseFirestore.value.collection("tasks").doc(id).get();

      if (documentSnapshot.exists) {
        await firebaseFirestore.value
            .collection("tasks")
            .doc(id)
            .delete()
            .then((value) {
          loadingButtonController.value.success();
          showSnackbar(
            message: "delete task succeessfully!",
            type: SnackBarType.success,
          );
        });
      } else {
        showSnackbar(message: "Task does not exist.");
        loadingButtonController.value.reset();
      }
    } catch (e) {
      print(e);
      loadingButtonController.value.reset();
      showSnackbar(message: e.toString());
    }
  }

  Future<void> isDoneTaskById(String id) async {
    try {
      DocumentSnapshot documentSnapshot =
          await firebaseFirestore.value.collection("tasks").doc(id).get();

      if (documentSnapshot.exists) {
        await firebaseFirestore.value
            .collection("tasks")
            .doc(id)
            .update({"isDone": true}).then((value) {
          showSnackbar(
            message: "🎉🎉🎉 Congratulations on completing the task.",
            type: SnackBarType.success,
          );
        });
      } else {
        showSnackbar(message: "Task does not exist.");
      }
    } catch (e) {
      print(e);
      showSnackbar(message: e.toString());
    }
  }

  Future<void> notDoneTaskById(String id) async {
    try {
      DocumentSnapshot documentSnapshot =
          await firebaseFirestore.value.collection("tasks").doc(id).get();

      if (documentSnapshot.exists) {
        await firebaseFirestore.value
            .collection("tasks")
            .doc(id)
            .update({"isDone": false});
      } else {
        showSnackbar(message: "Task does not exist.");
      }
    } catch (e) {
      print(e);
      showSnackbar(message: e.toString());
    }
  }
}
