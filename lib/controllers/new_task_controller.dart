import 'dart:async';
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

  final hour = Rx<int>(int.parse(DateFormat('HH').format(DateTime.now())));
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
  final taskListByUser = RxList<TaskModel>([]);

  final taskIds = RxList<dynamic>([]);

  final isOnLongPress = Rx<bool>(false);

  StreamSubscription? subscription;

  @override
  void onInit() async {
    // TODO: implement onInit

    subscription = getTasksByUserStream().listen((event) {
      taskListByUser.assignAll(event);
    });

    // await getTasksByUser().then((value) => taskListByUser.assignAll(value));

    daysOfWeek.value = getDaysOfWeek(DateTime.now());
    super.onInit();
  }

  @override
  void onClose() {
    // TODO: implement onClose
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
    hour.value = int.parse(DateFormat('HH').format(DateTime.now()));
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

  // Future<void> onReorderTaskList(oldIndex, newIndex) async {
  //   if (newIndex > oldIndex) {
  //     newIndex -= 1;
  //   }

  //   DocumentSnapshot userSnapshot = await firestore
  //       .collection("users")
  //       .doc(firebaseAuth.currentUser?.uid)
  //       .get();

  //   if (userSnapshot.exists) {
  //     List<String> taskIds = List<String>.from(
  //         (userSnapshot.data() as Map<String, dynamic>)["taskIds"] ?? []);

  //     final String item = taskIds.removeAt(oldIndex);
  //     taskIds.insert(newIndex, item);

  //     await firestore
  //         .collection("users")
  //         .doc(firebaseAuth.currentUser?.uid)
  //         .update({"taskIds": taskList});
  //   }
  // }

  Future<List<TaskModel>> getTasksByUser() async {
    // Lấy danh sách công việc từ Firestore
    DocumentSnapshot userSnapshot = await firestore
        .collection("users")
        .doc(firebaseAuth.currentUser?.uid)
        .get();

    if (userSnapshot.exists) {
      List<String> taskIds = List<String>.from(
          (userSnapshot.data() as Map<String, dynamic>)["taskIds"] ?? []);

      // Lấy ra các tasks dựa vào mảng ID
      QuerySnapshot tasksSnapshot = await firestore
          .collection("tasks")
          .where(FieldPath.documentId, whereIn: taskIds)
          .get();

      // Chuyển đổi dữ liệu từ QuerySnapshot sang List<TaskModel>
      List<TaskModel> tasks = tasksSnapshot.docs
          .map((doc) => TaskModel.fromJson(doc.data() as Map<String, dynamic>))
          .toList();

      return tasks;
    } else {
      return [];
    }
  }

  Future<void> updateTaskOrderInFirestore(List<TaskModel> updatedTasks) async {
    try {
      // Tạo danh sách cập nhật thứ tự
      List<String?> updatedTasksData =
          updatedTasks.map((task) => task.id).toList();

      // Cập nhật thứ tự mới vào Firestore
      await firestore
          .collection("users")
          .doc(firebaseAuth.currentUser?.uid)
          .update({"taskIds": updatedTasksData});
    } catch (e) {
      print("Lỗi khi cập nhật thứ tự công việc: $e");
    }
  }

  Future<void> onReorderTaskList(int oldIndex, int newIndex) async {
    if (newIndex > oldIndex) {
      newIndex -= 1;
    }

    DocumentSnapshot userSnapshot = await firestore
        .collection("users")
        .doc(firebaseAuth.currentUser?.uid)
        .get();

    if (userSnapshot.exists) {
      List<String> taskIds = List<String>.from(
          (userSnapshot.data() as Map<String, dynamic>)["taskIds"] ?? []);

      if (oldIndex >= 0 &&
          oldIndex < taskIds.length &&
          newIndex >= 0 &&
          newIndex < taskIds.length) {
        final String item = taskIds.removeAt(oldIndex);
        taskIds.insert(newIndex, item);

        await firestore
            .collection("users")
            .doc(firebaseAuth.currentUser?.uid)
            .update({"taskIds": taskIds}).then((value) {
          showSnackbar(
            message: "message",
            type: SnackBarType.success,
          );
        });
      }
    }
  }

  // Stream<List<TaskModel>> getTasksByUserStream() {
  //   return firestore
  //       .collection("users")
  //       .doc(firebaseAuth.currentUser?.uid)
  //       .snapshots()
  //       .asyncMap((userSnapshot) async {
  //     if (!userSnapshot.exists) {
  //       return [];
  //     }

  //     List<String> taskIds = List<String>.from(
  //         (userSnapshot.data() as Map<String, dynamic>)["taskIds"] ?? []);

  //     if (taskIds.isNotEmpty) {
  //       QuerySnapshot tasksSnapshot = await firestore
  //           .collection("tasks")
  //           .where(FieldPath.documentId, whereIn: taskIds)
  //           .orderBy("createdAt", descending: true)
  //           .get();

  //       return tasksSnapshot.docs.map((doc) {
  //         return TaskModel.fromJson(doc.data() as Map<String, dynamic>);
  //       }).toList();
  //     } else {
  //       return [];
  //     }
  //   });
  // }

  Stream<List<TaskModel>> getTasksByUserStream() {
    return firestore
        .collection("users")
        .doc(firebaseAuth.currentUser?.uid)
        .snapshots()
        .asyncMap((userSnapshot) async {
      if (!userSnapshot.exists) {
        return [];
      }

      List<String> taskIds = List<String>.from(
          (userSnapshot.data() as Map<String, dynamic>)["taskIds"] ?? []);

      if (taskIds.isNotEmpty) {
        QuerySnapshot tasksSnapshot = await firestore
            .collection("tasks")
            .where(FieldPath.documentId, whereIn: taskIds)
            .get();

        // Sắp xếp danh sách tasks theo thứ tự của taskIds
        List<TaskModel> sortedTasks = taskIds
            .map((taskId) =>
                tasksSnapshot.docs.firstWhere((doc) => doc.id == taskId).data())
            .map((data) => TaskModel.fromJson(data as Map<String, dynamic>))
            .toList();

        return sortedTasks;
      } else {
        return [];
      }
    });
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
        final String taskId = value.id;
        await firestore
            .collection("tasks")
            .doc(value.id)
            .update({"id": value.id}).then((value) async {
          await firestore
              .collection("tasks")
              .doc(taskId)
              .get()
              .then((DocumentSnapshot documentSnapshot) async {
            if (documentSnapshot.exists) {
              await firestore
                  .collection("users")
                  .doc(firebaseAuth.currentUser?.uid)
                  .update({
                "taskIds": FieldValue.arrayUnion([taskId])
              }).then((value) {
                showSnackbar(
                    message: "Create task successfully.",
                    type: SnackBarType.success);
                loadingButtonController.value.success();
                Future.delayed(const Duration(milliseconds: 500), () {
                  Navigator.of(context).pop();
                  resetFormCreateTask();
                });
              });
            }
          });
        });
      });
    } catch (e) {
      loadingButtonController.value.reset();
      print(e);
      showSnackbar(message: e.toString());
    }
  }

  Future<List<TaskModel>> getTaskListToFirebase() async {
    QuerySnapshot querySnapshot = await firestore.collection("tasks").get();
    return querySnapshot.docs
        .map((doc) => TaskModel.fromJson(doc.data() as Map<String, dynamic>))
        .toList();
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

  Future<void> updateTaskById(String id) async {
    try {
      DocumentSnapshot documentSnapshot =
          await firestore.collection("tasks").doc(id).get();

      if (documentSnapshot.exists) {
        await firestore.collection("tasks").doc(id).update({
          "title": titleTaskController.value.text,
          // "date": dateController.value.text,
          "taskType": selectedCategoryTasks.value.name,
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
}
