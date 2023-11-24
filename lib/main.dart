import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:todo_app/api/firebase_api.dart';
import 'package:todo_app/controllers/notification_controller.dart';
import 'package:todo_app/controllers/theme_controller.dart';
import 'package:todo_app/screens/notification_screen.dart';
// import 'package:todo_app/screens/home_screen.dart';
import 'package:todo_app/screens/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

final navigatorKey = GlobalKey<NavigatorState>();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // await FirebaseApi().initNotifications();
  await NotificationController().initLocalNotification();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final themeController = Get.put<ThemeController>(ThemeController());
    return Obx(
      () => GetMaterialApp(
        title: 'Todo App',
        debugShowCheckedModeBanner: false,
        // theme: ThemeData(
        //   colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        //   useMaterial3: true,
        // ),
        navigatorKey: navigatorKey,
        theme: themeController.themeData.value,
        // darkTheme: darkMode,
        home: const SplashScreen(),
        routes: {
          NotificationScreen.route: (context) => const NotificationScreen()
        },
      ),
    );
  }
}
