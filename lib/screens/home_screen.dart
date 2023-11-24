import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/controllers/auth_controller.dart';
import 'package:todo_app/controllers/notification_controller.dart';
import 'package:todo_app/controllers/profile_controller.dart';
import 'package:todo_app/controllers/task_controller.dart';
import 'package:todo_app/controllers/theme_controller.dart';
// import 'package:todo_app/screens/task/add_task.dart';
// import 'package:todo_app/screens/time_picker_screen.dart';
// import 'package:todo_app/utils/utils.dart';
import 'package:todo_app/widgets/dialog/create_task_dialog copy.dart';
import 'package:todo_app/widgets/dialog/search_task_dialog.dart';
import 'package:todo_app/widgets/home/home_body.dart';
// import 'package:todo_app/widgets/home/home_body_task.dart';
import 'package:todo_app/widgets/home/home_drawer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int currentIndex = 0;
  final themeController = Get.put<ThemeController>(ThemeController());
  final profileController = Get.put<ProfileController>(ProfileController());
  final authController = Get.put<AuthController>(AuthController());
  final TaskController taskController = Get.put(TaskController());
  final NotificationController notificationsController =
      Get.put(NotificationController());
  // final TaskController taskController = Get.find();
  // List<Widget> bodys = [
  //   Icon(Icons.home),
  //   Icon(Icons.checklist),
  //   Icon(Icons.add),
  //   Icon(Icons.favorite),
  //   // const ProfileScreen(),
  //   const ProfileScreen1()
  // ];
  // CollectionReference users = FirebaseFirestore.instance.collection('users');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        leading: IconButton(
          onPressed: () {
            _scaffoldKey.currentState?.openDrawer();
          },
          icon: Icon(
            Icons.menu,
            size: 26,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Get.dialog(const SearchTaskDialog());
            },
            icon: Icon(
              Icons.search,
              size: 26,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          IconButton(
            onPressed: () {
              notificationsController.scheduleNotification(
                id: 3,
                title: "title",
                body: "body",
                payload: "payload",
                time: DateTime(
                  DateTime.now().year,
                  DateTime.now().month,
                  DateTime.now().day,
                  16,
                  57,
                ),
              );
            },
            icon: Icon(
              Icons.notifications_outlined,
              size: 26,
              color: Theme.of(context).colorScheme.primary,
            ),
          )
        ],
      ),
      body: const HomeBody(),
      // body: const HomeBodyTask(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Get.to(() => const AddTask());

          Get.dialog(const CreateTaskDialog());
        },
        backgroundColor: Colors.purple,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(1000),
        ),
        child: const Icon(
          Icons.add,
          size: 26,
          color: Colors.white,
        ),
      ),
      drawer: const HomeDrawer(),
    );
  }
}
