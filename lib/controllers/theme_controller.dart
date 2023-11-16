import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/theme/theme.dart';

class ThemeController extends GetxController {
  final themeData = Rx<ThemeData>(lightMode);
  final isDarkMode = Rx(false);

  @override
  void onInit() async {
    // TODO: implement onInit
    initTheme();
    super.onInit();
  }

  Future<void> initTheme() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    isDarkMode.value = sharedPreferences.getBool("isDarkMode") ?? false;
    if (isDarkMode.value) {
      themeData.value = darkMode;
    } else {
      themeData.value = lightMode;
    }
    update();
  }

  void setDarkMode(value) {
    isDarkMode.value = value;
    update();
  }

  void toggleTheme() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    if (isDarkMode.value == true) {
      sharedPreferences.setBool("isDarkMode", true);
      themeData.value = darkMode;
      update();
    } else {
      sharedPreferences.setBool("isDarkMode", false);
      themeData.value = lightMode;
      update();
    }
  }
}
