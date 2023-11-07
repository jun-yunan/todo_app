import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

enum SnackBarType { error, success }

void showSnackbar(
    {required String message, SnackBarType? type = SnackBarType.error}) {
  switch (type) {
    case SnackBarType.success:
      Get.snackbar(
        "Sucesss",
        message,
        icon: Icon(
          Icons.done,
          size: 30,
          color: Colors.green[800],
        ),
        backgroundColor: Colors.green[100],
        colorText: Colors.green[800],
        messageText: Text(
          message,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.green[800],
          ),
        ),
      );
      break;
    default:
      Get.snackbar(
        'Error',
        message,
        backgroundColor: Colors.red,
        icon: const Icon(
          Icons.error,
          size: 30,
          color: Colors.white,
        ),
        colorText: Colors.white,
        // Thay đổi vị trí của Snackbar tùy theo nhu cầu
      );
      break;
  }
}

Future<File?> pickImage() async {
  File? image;
  try {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      image = File(pickedImage.path);
    }
  } catch (e) {
    showSnackbar(message: e.toString());
  }
  return image;
}
