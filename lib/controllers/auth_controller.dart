import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/models/profile_model.dart';
import 'package:todo_app/models/user_model.dart';
import 'package:todo_app/screens/auth/auth_screen.dart';
import 'package:todo_app/screens/profile/create_profile_screen.dart';
import 'package:todo_app/screens/home_screen.dart';
// import 'package:todo_app/screens/auth/login_screen.dart';
import 'package:todo_app/utils/utils.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'dart:async';

enum VARIANT { login, register }

class AuthController extends GetxController {
  final profileUser = Rx<ProfileModel?>(null);
  final profileModel = Rx<ProfileModel?>(null);

  final loadingButtonController =
      Rx<RoundedLoadingButtonController>(RoundedLoadingButtonController());
  final emailAddress = Rx<TextEditingController>(TextEditingController());
  final password = Rx<TextEditingController>(TextEditingController());

  final userModel = Rx<UserModel?>(null);

  final isSignedIn = Rx<bool>(false);

  final variant = Rx<VARIANT>(VARIANT.login);

  final obscureText = Rx<bool>(true);

  // String? uid;
  final uid = Rx<String?>(null);

  RxBool isLoading = RxBool(false);

  final GoogleSignIn googleSignIn = GoogleSignIn();
  final firebaseStorageRef = FirebaseStorage.instance.ref();
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Rx<User?> user = Rx<User?>(null);

  @override
  void onInit() {
    user.value = _auth.currentUser;
    _auth.authStateChanges().listen((User? currentUser) {
      user.value = currentUser;
      if (currentUser == null) {
        isSignedIn.value = false;
      } else {
        isSignedIn.value == true;
      }
    });
    super.onInit();
  }

  void toggleObscureText() {
    obscureText.value = !obscureText.value;
    update();
  }

  //get User Real-time
  Stream<UserModel> getCurrentUserRealTime() {
    final StreamController<UserModel> userController =
        StreamController<UserModel>.broadcast();

    final documentStream =
        firestore.collection("users").doc(_auth.currentUser?.uid).snapshots();

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
        );

        userController.add(user);
      }
    });

    return userController.stream;
  }

  Future<String> uploadImage(String ref, File image) async {
    String downloadUrl = "";
    try {
      UploadTask uploadTask = firebaseStorageRef.child(ref).putFile(image);
      TaskSnapshot snapshot = await uploadTask;
      downloadUrl = await snapshot.ref.getDownloadURL();
      showSnackbar(message: downloadUrl, type: SnackBarType.success);
    } on FirebaseException catch (e) {
      print(e);
    }
    return downloadUrl;
  }

  Future<void> createProfile({
    required Map<String, dynamic> infoUser,
    required File image,
    required BuildContext context,
  }) async {
    try {
      final imageUrl =
          await uploadImage('avatar/${_auth.currentUser?.uid}', image);

      if (imageUrl.isEmpty) {
        return showSnackbar(message: "Upload image failed!");
      }
      await firestore.collection("users").doc(uid.value).update(
        {
          "name": infoUser["name"],
          "imageUrl": imageUrl,
          "birthday": infoUser["birthday"],
          "bio": infoUser["bio"]
        },
      ).then((value) {
        Get.offAll(() => const HomeScreen());
      });
    } on FirebaseAuthException catch (e) {
      showSnackbar(message: e.message.toString());
      print(e);
    }
  }

  Future<bool> isLoggedIn() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('is_logged_in') ?? false;
  }

  Future setSignIn() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('is_logged_in', true);
    isSignedIn.value = true;
    update();
  }

  Future<void> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      await _auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then(
        (value) {
          loadingButtonController.value.success();
          setSignIn();
          Future.delayed(
            const Duration(milliseconds: 500),
            () {
              Get.off(() => const HomeScreen());
            },
          );
        },
      );
    } on FirebaseAuthException catch (e) {
      loadingButtonController.value.reset();
      if (e.code == 'user-not-found') {
        showSnackbar(message: "No user found for that email.");
        isLoading.value = false;
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        showSnackbar(message: "Wrong password provided for that user.");
        isLoading.value = false;
        print('Wrong password provided for that user.');
      } else {
        isLoading.value = false;
        showSnackbar(message: e.message.toString());
      }
    }
  }

  Future<void> signUpWithEmailAndPassword(
      {required email, required String password}) async {
    try {
      await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then(
        (value) async {
          uid.value = value.user?.uid;

          userModel.value = UserModel(
            uid: value.user?.uid,
            name: "",
            imageUrl: "",
            createdAt: DateTime.now().millisecondsSinceEpoch.toString(),
            provider: "EMAIL",
            email: email,
            address: "",
            bio: "",
            birthday: "",
            phoneNumber: "",
            isAccountVip: false,
            gender: "",
          );

          await firestore
              .collection("users")
              .doc(value.user?.uid)
              .set(userModel.toJson())
              .then((value) {
            loadingButtonController.value.success();
            setSignIn();
            Future.delayed(const Duration(milliseconds: 500), () {
              Get.to(() => const CreateProfileScreen());
            });
          });
        },
      );
      // uid = userCredential.user.uid;
    } on FirebaseAuthException catch (e) {
      loadingButtonController.value.reset();
      if (e.code == "weak-password") {
        showSnackbar(message: "The password provided is too weak.");
        isLoading.value = false;
      } else if (e.code == 'email-already-in-use') {
        showSnackbar(message: "The account already exists for that email.");
        isLoading.value = false;
      }
      // print(e);
    } catch (e) {
      showSnackbar(message: e.toString());
      isLoading.value = false;
      print(e);
    }
  }

  bool isSignInWithGoogle() {
    final user = _auth.currentUser;
    return user != null &&
        user.providerData
            .any((userInfo) => userInfo.providerId == 'google.com');
  }

  Future<void> signOut() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();

      if (isSignInWithGoogle()) {
        await googleSignIn.signOut().then(
          (value) {
            loadingButtonController.value.success();
            Future.delayed(const Duration(milliseconds: 500), () {
              prefs.clear();
              // Get.offAll(() => const LoginScreen());
              Get.offAll(() => const AuthScreen());
            });
          },
        );
      } else {
        await _auth.signOut().then(
          (value) {
            loadingButtonController.value.success();
            prefs.clear();
            Future.delayed(const Duration(milliseconds: 500), () {
              // Get.offAll(() => const LoginScreen());
              Get.offAll(() => const AuthScreen());
            });
          },
        );
      }
    } on FirebaseAuthException catch (e) {
      loadingButtonController.value.reset();
      showSnackbar(message: e.message.toString());
      print(e);
    }
  }

  Future signInWithGoogle() async {
    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();

    if (googleSignInAccount != null) {
      try {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;
        final AuthCredential authCredential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );

        final User userDetails =
            (await _auth.signInWithCredential(authCredential)).user!;

        if (await checkUserExists(userDetails.uid)) {
          loadingButtonController.value.success();
          setSignIn();
          Future.delayed(const Duration(milliseconds: 500), () {
            Get.to(() => const HomeScreen());
          });
        } else {
          userModel.value = UserModel(
            uid: userDetails.uid,
            name: userDetails.displayName!,
            imageUrl: userDetails.photoURL!,
            createdAt: DateTime.now().millisecondsSinceEpoch.toString(),
            provider: "GOOGLE",
            email: userDetails.email!,
            address: "",
            bio: "",
            birthday: "",
            phoneNumber: "",
            isAccountVip: false,
            gender: "",
          );
          await firestore
              .collection("users")
              .doc(userDetails.uid)
              .set(userModel.toJson())
              .then((value) {
            setSignIn();
            Future.delayed(const Duration(milliseconds: 500), () {
              Get.offAll(() => const HomeScreen());
            });
          });
          update();
        }
      } on FirebaseAuthException catch (e) {
        loadingButtonController.value.reset();
        if (e.code == "account-exists-with-different-credential") {
          showSnackbar(
            message:
                "You already have an account with us. Use correct provider",
            type: SnackBarType.error,
          );
        } else if (e.code == "null") {
          showSnackbar(
              message: "Some unexpected error while trying to sign in");
        } else {
          showSnackbar(
              message: "Some unexpected error while trying to sign in");
        }
        print(e);
      }
    } else {
      showSnackbar(message: "Some unexpected error while trying to sign in");
    }
  }

  Future<bool> checkUserExists(uid) async {
    final DocumentSnapshot documentSnapshot =
        await firestore.collection("users").doc(uid).get();

    if (documentSnapshot.exists) {
      return true;
    } else {
      return false;
    }
  }
}
