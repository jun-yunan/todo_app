import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class CustomDialog extends StatelessWidget {
  final String title;
  final TextEditingController? controller;
  final RoundedLoadingButtonController loadingButtonController;
  final String? label;
  final String? hintText;
  final int? maxLines;
  final Icon? prefixIcon;
  final bool readOnly;
  final VoidCallback? onTap;
  final void Function()? onPressed;
  final String? initialValue;
  final void Function(String)? onChanged;
  const CustomDialog({
    super.key,
    required this.title,
    this.controller,
    this.label,
    this.hintText,
    this.maxLines,
    this.prefixIcon,
    this.readOnly = false,
    this.onTap,
    required this.loadingButtonController,
    required this.onPressed,
    this.initialValue,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          ),
          IconButton(
            onPressed: () {
              // profileController.imageFile.value = null;
              Get.back();
            },
            style: IconButton.styleFrom(
                backgroundColor: const Color(0xFF444444).withOpacity(0.1),
                padding: const EdgeInsets.all(10)),
            icon: const Icon(
              Icons.close,
              size: 26,
            ),
          )
        ],
      ),
      content: TextFormField(
        initialValue: initialValue,
        onChanged: onChanged,
        onTap: onTap,
        readOnly: readOnly,
        controller: controller,
        maxLines: maxLines,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w500,
          color: Theme.of(context).colorScheme.primary,
        ),
        cursorColor: Colors.purple,
        decoration: InputDecoration(
          prefixIcon: prefixIcon,
          // suffixIcon: suffixIcon,
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.purple, width: 2),
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.purple, width: 2),
          ),
          hintText: hintText,
        ),
      ),
      actions: [
        RoundedLoadingButton(
          color: Colors.purple,
          successColor: Colors.green,
          controller: loadingButtonController,
          onPressed: onPressed,
          child: const Text(
            "Save",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        )
      ],
    );
  }
}
