import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/controllers/auth_controller.dart';
// import 'package:todo_app/models/profile_model.dart';
import 'package:todo_app/utils/utils.dart';
import 'package:todo_app/widgets/text_gradient.dart';

class CreateProfileScreen extends StatefulWidget {
  const CreateProfileScreen({super.key});

  @override
  State<CreateProfileScreen> createState() => _CreateProfileScreenState();
}

class _CreateProfileScreenState extends State<CreateProfileScreen> {
  final AuthController controller = Get.put(AuthController());
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController bioController = TextEditingController();
  File? image;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const TextGradient(text: "Continue Sign Up"),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 30),
        // margin: const EdgeInsets.only(top: 30),
        decoration: const BoxDecoration(),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  image == null
                      ? const CircleAvatar(
                          backgroundColor: Colors.purple,
                          radius: 60,
                          backgroundImage: NetworkImage(
                              'https://upload.wikimedia.org/wikipedia/commons/8/89/Portrait_Placeholder.png'),
                        )
                      : CircleAvatar(
                          radius: 60,
                          backgroundImage: FileImage(image!),
                        ),
                  Positioned(
                    bottom: 0,
                    right: -10,
                    child: IconButton(
                      onPressed: () async {
                        image = await pickImage();
                        setState(() {});
                      },
                      iconSize: 26,
                      color: Colors.purple,
                      icon: const Icon(Icons.add_photo_alternate_outlined),
                    ),
                  )
                ],
              ),
              ElevatedButton(
                onPressed: () {
                  controller.uploadImage('avatar/1234.jpg', image!);
                },
                child: const Text("Upload"),
              ),
              const SizedBox(
                height: 30,
              ),
              TextFormField(
                controller: nameController,
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 2,
                      color: Colors.purple,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide:
                          const BorderSide(width: 2, color: Colors.purple)),
                  hintText: "Enter your name...",
                  // labelText: "Name",
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              TextFormField(
                controller: bioController,
                keyboardType: TextInputType.name,
                maxLines: 2,
                decoration: InputDecoration(
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 2,
                      color: Colors.purple,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide:
                        const BorderSide(width: 2, color: Colors.purple),
                  ),
                  prefixIcon: const Icon(Icons.edit_outlined),
                  hintText: "Enter your bio...",
                  // labelText: "Bio",
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              TextFormField(
                controller: _dateController,
                keyboardType: TextInputType.datetime,
                decoration: InputDecoration(
                  enabledBorder:
                      const OutlineInputBorder(borderSide: BorderSide.none),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide:
                          const BorderSide(width: 2, color: Colors.purple)),
                  hintText: _dateController.text,
                  labelStyle: const TextStyle(color: Colors.purple),
                  labelText: "Date",
                  filled: true,
                  prefixIcon: const Icon(Icons.calendar_today),
                ),
                readOnly: true,
                onTap: () {
                  _selectDate();
                },
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    backgroundColor: Colors.purple,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () {
                    saveData();
                  },
                  child: const Text(
                    "Done",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> saveData() async {
    Map<String, dynamic> infoUser = {
      "name": nameController.text.trim(),
      "bio": bioController.text.trim(),
      "birthday": _dateController.text
    };
    if (image != null) {
      controller.createProfile(
          infoUser: infoUser, image: image!, context: context);
    } else {
      showSnackbar(message: "Please upload your profile photo");
    }
  }

  Future<void> _selectDate() async {
    DateTime? _picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1950),
      lastDate: DateTime(2100),
    );

    if (_picked != null) {
      setState(() {
        _dateController.text = _picked.toString().split(" ")[0];
      });
    }
  }
}
