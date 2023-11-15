import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:todo_app/controllers/auth_controller.dart';
import 'package:todo_app/controllers/profile_controller.dart';
import 'package:todo_app/controllers/task_controller.dart';
import 'package:todo_app/controllers/theme_controller.dart';
import 'package:todo_app/screens/profile/personal_data_screen_copy.dart';
import 'package:todo_app/widgets/custom_list_title.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final ProfileController profileController = Get.find();
    final ThemeController themeController = Get.find();
    final AuthController authController = Get.find();
    final TaskController taskController = Get.find();
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      child: ListView(
        children: [
          Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.purple.withOpacity(0.7),
                  Colors.cyan.withOpacity(0.7),
                ],
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Obx(() => CircleAvatar(
                          backgroundImage:
                              profileController.currentUser.value?.imageUrl !=
                                      null
                                  ? NetworkImage(
                                      profileController
                                              .currentUser.value?.imageUrl ??
                                          "",
                                    )
                                  : const NetworkImage(""),
                          radius: 45,
                        )),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color:
                            profileController.currentUser.value!.isAccountVip!
                                ? Colors.purple.shade300.withAlpha(120)
                                : Colors.grey.shade600,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child:
                          profileController.currentUser.value!.isAccountVip! ==
                                  true
                              ? Row(
                                  children: [
                                    Image.asset(
                                      'assets/images/crown.png',
                                      width: 35,
                                      height: 35,
                                    ),
                                    const SizedBox(
                                      width: 6,
                                    ),
                                    const Text(
                                      "VIP",
                                      style: TextStyle(
                                        color: Colors.purple,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                )
                              : const Text(
                                  "FREE",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Obx(
                  () => Text(
                    profileController.currentUser.value!.name ?? "",
                    style: const TextStyle(
                      letterSpacing: 1.2,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ),
                Obx(
                  () => Text(
                    profileController.currentUser.value!.email ?? "",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey.shade300,
                      // color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          ListTile(
            leading: Image.asset(
              'assets/images/crown.png',
              width: 40,
              height: 40,
            ),
            title: Text(
              "Upgrade your account",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                foreground: Paint()
                  ..shader =
                      const LinearGradient(colors: [Colors.cyan, Colors.purple])
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
            title: "Profile",
            icon: Icons.person,
            onTap: () {
              Get.to(() => const PersonalDataScreenCopy());
            },
          ),
          CustomListTitle(
            title: "Setting",
            icon: Icons.settings,
            onTap: () {},
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
          CustomListTitle(
            title: "E-Statement",
            icon: Icons.list_alt,
            onTap: () {
              // showSnackbar(message: "message");
            },
          ),
          CustomListTitle(
            title: "Favorite",
            icon: Icons.favorite,
            onTap: () {
              // showSnackbar(message: "message");
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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: const BorderSide(
                    width: 2,
                    color: Color(0xffc62828),
                  ),
                ),
              ),
              onPressed: () {
                Get.dialog(
                  AlertDialog(
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Confirm log out"),
                        IconButton(
                          onPressed: () {
                            Get.back();
                          },
                          icon: const Icon(
                            Icons.close,
                            size: 26,
                          ),
                        )
                      ],
                    ),
                    content: const Text("Are you sure you want to log out?"),
                    actions: [
                      RoundedLoadingButton(
                        color: Colors.purple,
                        successColor: Colors.green,
                        controller:
                            authController.loadingButtonController.value,
                        onPressed: () {
                          authController.signOut();
                          taskController.onClose();
                          Get.delete<TaskController>();
                          Get.delete<ProfileController>();
                          Get.delete<AuthController>();
                        },
                        child: const Text(
                          "Confirm",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    ],
                  ),
                );
              },
              icon: const Icon(
                Icons.logout,
                size: 26,
                color: Color(0xffc62828),
              ),
              label: const Text(
                "Log out",
                style: TextStyle(
                  color: Color(0xffc62828),
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
