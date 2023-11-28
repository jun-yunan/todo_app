import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:todo_app/models/user_model.dart';
import 'package:todo_app/utils/utils.dart';

class ProfileController extends GetxController {
  final userModel = Rx<UserModel?>(null);
  final currentUser = Rx<UserModel?>(null);
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final FirebaseStorage firebaseStorage = FirebaseStorage.instance;
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  final nameController = Rx<TextEditingController>(TextEditingController());
  final dateController = Rx<TextEditingController>(TextEditingController());
  final addressController = Rx<TextEditingController>(TextEditingController());
  final bioController = Rx<TextEditingController>(TextEditingController());
  final numberPhoneController =
      Rx<TextEditingController>(TextEditingController());

  final buttonUploadController =
      Rx<RoundedLoadingButtonController>(RoundedLoadingButtonController());

  final buttonLoadingController =
      Rx<RoundedLoadingButtonController>(RoundedLoadingButtonController());

  final dropdownValue = Rx<String>("Male");
  final imageFile = Rx<File?>(null);
  final imageUrl = Rx<String>("");
  // final dateText = Rx<String>("");

  Future<void> setImageFile() async {
    imageFile.value = await pickImage();
    update();
  }

  StreamSubscription? streamSubscription;
  @override
  void onInit() {
    // TODO: implement onInit
    streamSubscription = getStreamCurrentUser().listen((user) {
      currentUser.value = user;
    });
    super.onInit();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    streamSubscription?.cancel();
    super.onClose();
  }

  Stream<UserModel?> getStreamCurrentUser() {
    return firebaseFirestore
        .collection("users")
        .doc(firebaseAuth.currentUser?.uid)
        .snapshots()
        .map((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        return UserModel.fromJson(
            documentSnapshot.data() as Map<String, dynamic>);
      }
      return null;
    });
  }

  void setDropdownValue(String value) {
    dropdownValue.value = value;
    update();
  }

  Future<void> selectDate(BuildContext context) async {
    DateTime? pickDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1950),
      lastDate: DateTime(2050),
    );

    if (pickDate != null) {
      dateController.value.text = pickDate.toString().split(" ")[0];
      // dateText.value = pickDate.toString().split(" ")[0];
      update();
    }
  }

  Stream<UserModel> getCurrentUserRealTime() {
    final StreamController<UserModel> userController =
        StreamController<UserModel>.broadcast();

    final documentStream = firebaseFirestore
        .collection("users")
        .doc(firebaseAuth.currentUser?.uid)
        .snapshots();

    documentStream.listen((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        final user = UserModel(
          uid: documentSnapshot["uid"],
          name: documentSnapshot["name"],
          imageUrl: documentSnapshot["imageUrl"],
          createdAt: documentSnapshot["createdAt"],
          provider: documentSnapshot["provider"],
          email: documentSnapshot["email"],
          address: documentSnapshot["address"],
          bio: documentSnapshot["bio"],
          birthday: documentSnapshot["birthday"],
          phoneNumber: documentSnapshot["phoneNumber"],
          isAccountVip: documentSnapshot["isAccountVip"],
          gender: documentSnapshot["gender"],
          taskIds: List<String>.from(documentSnapshot["taskIds"] ?? []),
        );

        userController.add(user);
      }
    });

    return userController.stream;
  }

  // Stream<UserModel?> getCurrentUserRealTime() {
  //   final StreamController<UserModel?> userController =
  //       StreamController<UserModel?>.broadcast();

  //   final documentStream = firebaseFirestore
  //       .collection("users")
  //       .doc(firebaseAuth.currentUser?.uid)
  //       .snapshots();

  //   documentStream.listen((DocumentSnapshot documentSnapshot) {
  //     if (documentSnapshot.exists) {
  //       final user = UserModel(
  //         uid: documentSnapshot["uid"],
  //         name: documentSnapshot["name"],
  //         imageUrl: documentSnapshot["imageUrl"],
  //         createdAt: documentSnapshot["createdAt"],
  //         provider: documentSnapshot["provider"],
  //         email: documentSnapshot["email"],
  //         address: documentSnapshot["address"],
  //         bio: documentSnapshot["bio"],
  //         birthday: documentSnapshot["birthday"],
  //         phoneNumber: documentSnapshot["phoneNumber"],
  //         isAccountVip: documentSnapshot["isAccountVip"],
  //         gender: documentSnapshot["gender"],
  //         taskIds: List<String>.from(documentSnapshot["taskIds"] ?? []),
  //       );

  //       userController.add(user);
  //     } else {
  //       userController.add(null); // Trả về null nếu không có dữ liệu
  //     }
  //   });

  //   return userController.stream;
  // }

  Future<UserModel?> getCurrentUser() async {
    try {
      final DocumentSnapshot documentSnapshot = await firebaseFirestore
          .collection("users")
          .doc(firebaseAuth.currentUser?.uid)
          .get();

      if (documentSnapshot.exists) {
        return UserModel(
          name: documentSnapshot["name"],
          address: documentSnapshot["address"],
          bio: documentSnapshot["bio"],
          birthday: documentSnapshot["birthday"],
          createdAt: documentSnapshot["createdAt"],
          email: documentSnapshot["email"],
          gender: documentSnapshot["gender"],
          imageUrl: documentSnapshot["imageUrl"],
          isAccountVip: documentSnapshot["isAccountVip"],
          phoneNumber: documentSnapshot["phoneNumber"],
          provider: documentSnapshot["provider"],
          uid: documentSnapshot["uid"],
          taskIds: documentSnapshot["taskIds"],
        );
      }
      return null;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<String> uploadImage(String ref, File image) async {
    String downloadUrl = "";
    try {
      UploadTask uploadTask = firebaseStorage.ref().child(ref).putFile(image);
      TaskSnapshot taskSnapshot = await uploadTask;
      downloadUrl = await taskSnapshot.ref.getDownloadURL();

      return downloadUrl;
    } catch (e) {
      print(e);
      return downloadUrl;
    }
  }

  Future<void> updateAvatar(BuildContext context) async {
    try {
      imageUrl.value = await uploadImage(
          "avatar/${firebaseAuth.currentUser?.uid}_${DateTime.now().millisecondsSinceEpoch.toString()}",
          imageFile.value!);

      if (imageUrl.value.isEmpty) {
        buttonUploadController.value.reset();
      } else {
        await firebaseFirestore
            .collection("users")
            .doc(firebaseAuth.currentUser?.uid)
            .update({"imageUrl": imageUrl.value}).then(
          (value) {
            buttonUploadController.value.success();
            // Get.snackbar("Success", "upload image successfully!!!");
            showSnackbar(
              message: "Change avatar successfully",
              type: SnackBarType.success,
            );
            Future.delayed(const Duration(seconds: 2), () {
              // buttonUploadController.value.reset();
              Navigator.of(context).pop();
            });
          },
        );
      }
    } catch (e) {
      showSnackbar(message: e.toString());
      print(e);
    }
  }

  Future<void> updateBio(String content, BuildContext context) async {
    try {
      await firebaseFirestore
          .collection("users")
          .doc(firebaseAuth.currentUser?.uid)
          .update({"bio": content}).then((value) {
        buttonLoadingController.value.success();
        showSnackbar(
          message: "update information successfully",
          type: SnackBarType.success,
        );
        Future.delayed(const Duration(seconds: 2), () {
          Navigator.of(context).pop();
        });
      });
      update();
    } catch (e) {
      buttonLoadingController.value.reset();
      print(e);
      showSnackbar(message: e.toString());
    }
  }

  Future<void> updateName(String content, BuildContext context) async {
    try {
      await firebaseFirestore
          .collection("users")
          .doc(firebaseAuth.currentUser?.uid)
          .update({"name": content}).then((value) {
        buttonLoadingController.value.success();
        showSnackbar(
          message: "update information successfully",
          type: SnackBarType.success,
        );
        Future.delayed(const Duration(seconds: 2), () {
          Navigator.of(context).pop();
        });
      });
      update();
    } catch (e) {
      buttonLoadingController.value.reset();
      print(e);
      showSnackbar(message: e.toString());
    }
  }

  Future<void> updateDate(String content, BuildContext context) async {
    try {
      await firebaseFirestore
          .collection("users")
          .doc(firebaseAuth.currentUser?.uid)
          .update({"birthday": content}).then((value) {
        buttonLoadingController.value.success();
        showSnackbar(
          message: "update information successfully",
          type: SnackBarType.success,
        );
        Future.delayed(const Duration(seconds: 2), () {
          Navigator.of(context).pop();
        });
      });
      update();
    } catch (e) {
      buttonLoadingController.value.reset();
      print(e);
      showSnackbar(message: e.toString());
    }
  }

  Future<void> updateGender(String content, BuildContext context) async {
    try {
      await firebaseFirestore
          .collection("users")
          .doc(firebaseAuth.currentUser?.uid)
          .update({"gender": content}).then((value) {
        buttonLoadingController.value.success();
        showSnackbar(
          message: "update information successfully",
          type: SnackBarType.success,
        );
        Future.delayed(const Duration(seconds: 2), () {
          Navigator.of(context).pop();
        });
      });
      update();
    } catch (e) {
      buttonLoadingController.value.reset();
      print(e);
      showSnackbar(message: e.toString());
    }
  }

  Future<void> updateAddress(String content, BuildContext context) async {
    try {
      await firebaseFirestore
          .collection("users")
          .doc(firebaseAuth.currentUser?.uid)
          .update({"address": content}).then((value) {
        buttonLoadingController.value.success();
        showSnackbar(
          message: "update information successfully",
          type: SnackBarType.success,
        );
        Future.delayed(const Duration(seconds: 2), () {
          Navigator.of(context).pop();
        });
      });
      update();
    } catch (e) {
      buttonLoadingController.value.reset();
      print(e);
      showSnackbar(message: e.toString());
    }
  }

  Future<void> updateNumberPhone(String content, BuildContext context) async {
    try {
      await firebaseFirestore
          .collection("users")
          .doc(firebaseAuth.currentUser?.uid)
          .update({"phoneNumber": content}).then((value) {
        buttonLoadingController.value.success();
        showSnackbar(
          message: "update information successfully",
          type: SnackBarType.success,
        );
        Future.delayed(const Duration(seconds: 2), () {
          Navigator.of(context).pop();
        });
      });
      update();
    } catch (e) {
      buttonLoadingController.value.reset();
      print(e);
      showSnackbar(message: e.toString());
    }
  }

  Future<void> updateInformationUser(BuildContext context) async {
    try {
      await firebaseFirestore
          .collection("users")
          .doc(firebaseAuth.currentUser?.uid)
          .update(
        {
          "name": nameController.value.text,
          "birthday": dateController.value.text,
          "bio": bioController.value.text,
          "address": addressController.value.text,
          "phoneNumber": numberPhoneController.value.text,
          "gender": dropdownValue.value,
        },
      ).then((value) {
        // Get.snackbar("Success", "Update information sucessfully");
        buttonLoadingController.value.success();
        Future.delayed(const Duration(seconds: 2), () {
          Navigator.of(context).pop();
        });
      });
    } catch (e) {
      buttonLoadingController.value.reset();
      print(e);
    }
  }
}
