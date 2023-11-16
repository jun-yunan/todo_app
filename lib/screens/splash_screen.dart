import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:todo_app/controllers/auth_controller.dart';
// import 'package:todo_app/controllers/task_controller.dart';
import 'package:todo_app/screens/home_screen.dart';
// import 'package:todo_app/screens/home_screen copy.dart';
import 'package:get/get.dart';
// import 'package:todo_app/screens/home_screen_1.dart';
import 'package:todo_app/screens/auth/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    final AuthController controller = Get.put(AuthController());
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    Future.delayed(
      const Duration(seconds: 4),
      () async {
        bool isLoggedIn = await controller.isLoggedIn();
        if (isLoggedIn == true) {
          // ignore: use_build_context_synchronously
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              // builder: (context) => const HomeScreen(),
              builder: (context) => const HomeScreen(),
            ),
          );
        } else {
          // ignore: use_build_context_synchronously
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const LoginScreen(),
            ),
          );
        }
      },
    );
    super.initState();
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              colors: [Colors.cyan, Colors.purple],
              begin: Alignment.topRight,
              end: Alignment.bottomLeft),
        ),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Welcome to",
              style: TextStyle(
                fontSize: 30,
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              "Todo App",
              style: TextStyle(
                fontSize: 65,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: 4,
              ),
            ),
            Icon(
              Icons.check,
              color: Colors.white,
              size: 95,
            )
          ],
        ),
      ),
    );
  }
}
