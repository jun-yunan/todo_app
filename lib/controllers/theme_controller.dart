import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/theme/theme.dart';

class ThemeController extends GetxController {
  final themeData = Rx<ThemeData>(lightMode);
  final isDarkMode = Rx(false);
  void setDarkMode(value) {
    isDarkMode.value = value;
    update();
  }

  void toggleTheme() {
    if (isDarkMode.value == true) {
      themeData.value = darkMode;
      update();
    } else {
      themeData.value = lightMode;
      update();
    }
  }
}
