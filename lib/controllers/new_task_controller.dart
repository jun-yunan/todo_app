import 'dart:async';
// import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:todo_app/models/category_task_model.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/models/task_model.dart';
import 'package:todo_app/utils/utils.dart';

class NewTaskController extends GetxController {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  final loadingButtonController =
      Rx<RoundedLoadingButtonController>(RoundedLoadingButtonController());

  final titleTaskController =
      Rx<TextEditingController>(TextEditingController());

  final detailsTaskController =
      Rx<TextEditingController>(TextEditingController(text: ""));

  final hour = Rx<int>(int.parse(DateFormat('h').format(DateTime.now())));
  final minute = Rx<int>(int.parse(DateFormat('mm').format(DateTime.now())));
  final timeFormat = Rx<String>(DateFormat('a').format(DateTime.now()));

  final categoryTasks = RxList(["Personal", "Metting", "Work"]);
  final categoryTaskss = RxList<CategoryTaskModel>([
    CategoryTaskModel(
        category: CategoryTaskType.Personal, color: const Color(0xFF3c0a9c)),
    CategoryTaskModel(
        category: CategoryTaskType.Metting, color: const Color(0xFFe7534d)),
    CategoryTaskModel(
        category: CategoryTaskType.Work, color: const Color(0xFFefb452)),
  ]);

  final selectedCategoryTasks = Rx<CategoryTaskType>(CategoryTaskType.Personal);

  final taskModel = Rx<TaskModel?>(null);

  final selectedDayIndex = Rx<int>(0);

  final daysOfWeek = RxList<DateTime>([]);

  final taskList = RxList<TaskModel>([]);

  final isOnLongPress = Rx<bool>(false);

  StreamSubscription? subscription;

  @override
  void onInit() {
    // TODO: implement onInit
    // subscription = getTaskList().listen((tasks) {
    //   taskList.assignAll(tasks);
    // });

    daysOfWeek.value = getDaysOfWeek(DateTime.now());
    super.onInit();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    // subscription?.cancel();
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

  void setSelectedCategoryTasks(value) {
    selectedCategoryTasks.value = value;
    update();
  }

  List<DateTime> getDaysOfWeek(DateTime currentDate) {
    List<DateTime> days = [];
    int currentDayOfWeek = currentDate.weekday;
    for (int i = 1; i <= 7; i++) {
      int difference = i - currentDayOfWeek;
      DateTime newDay = currentDate.add(Duration(days: difference));
      days.add(newDay);
    }
    return days;
  }

  bool checkSelectedCategoryTasks() {
    bool flag = false;
    categoryTaskss.map((element) {
      if (element.category == selectedCategoryTasks.value) {
        return flag = true;
      } else {
        return flag = false;
      }
    });

    return flag;
  }

  void resetFormCreateTask() {
    titleTaskController.value.text = "";
    detailsTaskController.value.text = "";
    selectedCategoryTasks.value = CategoryTaskType.Personal;
    hour.value = int.parse(DateFormat('h').format(DateTime.now()));
    minute.value = int.parse(DateFormat('mm').format(DateTime.now()));
    timeFormat.value = DateFormat('a').format(DateTime.now());
  }

  String selectedHexColor() {
    String hexColor = "";

    CategoryTaskModel? selectedCategory = categoryTaskss.firstWhereOrNull(
        (element) => element.category == selectedCategoryTasks.value);

    if (selectedCategory == null) {
      return hexColor;
    }
    return selectedCategory.color.value
        .toRadixString(16)
        .padLeft(8, '0')
        .substring(2);
  }

  Future<void> createTask(BuildContext context) async {
    try {
      DocumentSnapshot documentSnapshotCurrentUser = await firestore
          .collection("users")
          .doc(firebaseAuth.currentUser?.uid)
          .get();

      if (!documentSnapshotCurrentUser.exists) {
        return showSnackbar(message: "User does not exist.");
      }
      taskModel.value = TaskModel(
        title: titleTaskController.value.text,
        details: detailsTaskController.value.text,
        date: DateFormat("EEE dd MMMM yyyy")
            .format(daysOfWeek[selectedDayIndex.value]),
        fileUrl: "",
        id: "",
        imageUrl: "",
        isDone: false,
        categoryTask: selectedCategoryTasks.value.name,
        time: "${hour.value}:${minute.value} ${timeFormat.value}",
        uid: firebaseAuth.currentUser?.uid,
        hexColor: selectedHexColor(),
        createdAt: DateTime.now().millisecondsSinceEpoch.toString(),
      );

      await firestore
          .collection("tasks")
          .add(taskModel.toJson())
          .then((value) async {
        await firestore
            .collection("tasks")
            .doc(value.id)
            .update({"id": value.id}).then((value) {
          showSnackbar(
              message: "Create task successfully.", type: SnackBarType.success);
          loadingButtonController.value.success();
          Future.delayed(const Duration(milliseconds: 500), () {
            Navigator.of(context).pop();
            resetFormCreateTask();
          });
        });
      });
    } catch (e) {
      loadingButtonController.value.reset();
      print(e);
      showSnackbar(message: e.toString());
    }
  }

  Stream<List<TaskModel>> getTaskList() {
    return firestore
        .collection("tasks")
        .where("uid", isEqualTo: firebaseAuth.currentUser?.uid)
        .orderBy("createdAt", descending: true)
        .snapshots()
        .map((querySnapshot) {
      return querySnapshot.docs.map((doc) {
        return TaskModel.fromJson(doc.data());
      }).toList();
    });
  }

  Future<void> deleteTaskById({required String id}) async {
    try {
      await firestore.collection("tasks").doc(id).get().then((value) async {
        if (value.exists) {
          await firestore.collection("tasks").doc(id).delete().then((value) {
            showSnackbar(
              message: "Delete task successfully.",
              type: SnackBarType.success,
            );
            loadingButtonController.value.success();
          });
        } else {
          showSnackbar(message: "Task does not exists.");
          loadingButtonController.value.reset();
        }
      });
    } catch (e) {
      print(e);
      showSnackbar(message: e.toString());
      loadingButtonController.value.reset();
    }
  }
}
