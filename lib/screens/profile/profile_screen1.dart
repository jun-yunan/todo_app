import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/controllers/auth_controller.dart';
import 'package:todo_app/controllers/theme_controller.dart';
import 'package:todo_app/models/user_model.dart';
// import 'package:todo_app/screens/profile/personal_data_screen.dart';
import 'package:todo_app/screens/profile/personal_data_screen_copy.dart';
import 'package:todo_app/utils/utils.dart';
import 'package:todo_app/widgets/custom_list_title.dart';

class ProfileScreen1 extends StatelessWidget {
  const ProfileScreen1({super.key});

  @override
  Widget build(BuildContext context) {
    final authController = Get.put<AuthController>(AuthController());
    final themeController = Get.put<ThemeController>(ThemeController());
    return Scaffold(
      body: StreamBuilder<UserModel>(
        stream: authController.getCurrentUserRealTime(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text(
                "Something went wrong!",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
            );
          } else if (snapshot.hasData) {
            final user = snapshot.data!;
            return Container(
              width: double.infinity,
              // height: double.infinity,
              padding: const EdgeInsets.all(15),
              decoration: const BoxDecoration(),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Image.network(
                            user.imageUrl!,
                            width: 65,
                            height: 65,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  user.name!,
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.w500,
                                    // color: const Color(0xFF444444)
                                    //     .withOpacity(0.9),
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  ),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                user.isAccountVip == false
                                    ? Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 10,
                                          vertical: 5,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.purple.withOpacity(0.1),
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        child: const Text(
                                          "FREE",
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.purple,
                                          ),
                                        ),
                                      )
                                    : Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 10,
                                          vertical: 5,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.purple.withOpacity(0.1),
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        child: Row(
                                          children: [
                                            Image.asset(
                                              "assets/images/crown.png",
                                              width: 30,
                                              height: 30,
                                            ),
                                            const SizedBox(
                                              width: 4,
                                            ),
                                            const Text(
                                              "VIP",
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.purple),
                                            )
                                          ],
                                        ),
                                      )
                              ],
                            ),
                            Text(
                              user.email!,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                // color: const Color(0xFF444444).withOpacity(0.7),
                                color: Colors.grey[500],
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Divider(
                      thickness: 2,
                      color: Colors.grey.shade500,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ListTile(
                      leading: Container(
                        // padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          // color: Colors.purple.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Image.asset(
                          'assets/images/crown.png',
                          width: 45,
                          height: 45,
                        ),
                      ),
                      title: Text(
                        "Upgrade your account",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          // color: Color(0xFF444444),
                          // color: Theme.of(context).colorScheme.primary,
                          foreground: Paint()
                            ..shader = const LinearGradient(
                                    colors: [Colors.cyan, Colors.purple])
                                .createShader(
                              const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0),
                            ),
                        ),
                      ),
                      onTap: () {},
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomListTitle(
                      title: "Personal Data",
                      icon: Icons.person,
                      onTap: () {
                        // Get.to(() => const PersonalDataScreen());
                        Get.to(() => const PersonalDataScreenCopy());
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomListTitle(
                      title: "Setting",
                      icon: Icons.settings,
                      onTap: () {
                        Get.snackbar("title", "message");
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ListTile(
                      leading: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          // color: Colors.purple.withOpacity(0.2),
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(
                          Icons.dark_mode,
                          size: 24,
                          // color: Color(0xFF444444),
                          color: Theme.of(context).iconTheme.color,
                        ),
                      ),
                      title: Text(
                        "Dark mode",
                        style: TextStyle(
                          fontSize: 16,
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      trailing: Obx(
                        () => Switch(
                            activeColor: Colors.purple,
                            value: themeController.isDarkMode.value,
                            onChanged: (value) {
                              themeController.setDarkMode(value);
                              themeController.toggleTheme();
                            }),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomListTitle(
                      title: "E-Statement",
                      icon: Icons.list_alt,
                      onTap: () {
                        showSnackbar(message: "message");
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomListTitle(
                      title: "For Like",
                      icon: Icons.favorite,
                      onTap: () {
                        showSnackbar(message: "message");
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Divider(
                      thickness: 2,
                      color: Colors.grey.shade500,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomListTitle(
                      title: "FAQs",
                      icon: Icons.pending,
                      onTap: () {},
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomListTitle(
                      title: "Community",
                      icon: Icons.group_sharp,
                      onTap: () {},
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Divider(
                      thickness: 2,
                      color: Colors.grey.shade500,
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    SizedBox(
                      width: double.maxFinite,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          // authController.signOut();
                          Get.dialog(
                            AlertDialog(
                              // icon: Icon(Icons.error),
                              title: const Row(
                                children: [
                                  Icon(
                                    Icons.error,
                                    color: Color(0xffc62828),
                                    size: 30,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "Confirm Log out",
                                    style: TextStyle(
                                        color: Color(0xffc62828),
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                              content: const Text(
                                  "Are you sure you want to log out?"),
                              backgroundColor: Colors.white,
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Get.back();
                                  },
                                  style: TextButton.styleFrom(
                                    backgroundColor: Colors.white,
                                    foregroundColor: const Color(0xFF444444),
                                    shadowColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                  ),
                                  child: const Text(
                                    "Cancel",
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFFD32F2F),
                                    foregroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                  ),
                                  onPressed: () {
                                    authController.signOut();
                                  },
                                  child: const Text(
                                    "Confirm",
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                        icon: const Icon(
                          Icons.logout,
                          size: 24,
                          color: Color(0xffc62828),
                        ),
                        label: const Text(
                          "Log out",
                          style: TextStyle(
                            fontSize: 18,
                            color: Color(0xffc62828),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          side: const BorderSide(
                            width: 2,
                            color: Color(0xffc62828),
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
              // child: ElevatedButton(
              //   onPressed: () => authController.signOut(),
              //   child: const Text("Logout"),
              // ),
            );
          }
        },
      ),
    );
  }
}
