import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:todo_app/controllers/auth_controller.dart';
import 'package:todo_app/controllers/profile_controller.dart';
import 'package:todo_app/controllers/task_controller.dart';
import 'package:todo_app/controllers/theme_controller.dart';
// import 'package:todo_app/models/task_model.dart';
import 'package:todo_app/screens/add_task.dart';
// import 'package:todo_app/models/user_model.dart';
import 'package:todo_app/screens/profile/personal_data_screen_copy.dart';
// import 'package:todo_app/screens/profile_screen.dart';
// import 'package:todo_app/screens/profile_screen1.dart';
import 'package:todo_app/widgets/custom_list_title.dart';
import 'package:todo_app/widgets/home/home_body.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int currentIndex = 0;
  final themeController = Get.put<ThemeController>(ThemeController());

  final profileController = Get.put<ProfileController>(ProfileController());
  final authController = Get.put<AuthController>(AuthController());
  final TaskController taskController = Get.put(TaskController());
  // List<Widget> bodys = [
  //   Icon(Icons.home),
  //   Icon(Icons.checklist),
  //   Icon(Icons.add),
  //   Icon(Icons.favorite),
  //   // const ProfileScreen(),
  //   const ProfileScreen1()
  // ];
  // CollectionReference users = FirebaseFirestore.instance.collection('users');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        title: Text(
          "Todo App",
          style: TextStyle(
            fontSize: 20,
            letterSpacing: 2,
            foreground: Paint()
              ..shader =
                  const LinearGradient(colors: [Colors.cyan, Colors.purple])
                      .createShader(
                const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0),
              ),
          ),
        ),
        leading: IconButton(
          onPressed: () {
            _scaffoldKey.currentState?.openDrawer();
          },
          icon: Icon(
            Icons.menu,
            size: 26,
            color: const Color(0xFF444444).withOpacity(0.8),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.search,
              size: 26,
              color: const Color(0xFF444444).withOpacity(0.8),
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.notifications_outlined,
              size: 26,
              color: const Color(0xFF444444).withOpacity(0.8),
            ),
          )
        ],
      ),
      // body: SafeArea(child: bodys[currentIndex]),
      // body: Container(
      //   padding: const EdgeInsets.symmetric(horizontal: 20),
      //   decoration: const BoxDecoration(),
      //   child: ListView(
      //     children: [
      //       const SizedBox(
      //         height: 15,
      //       ),
      //       Text(
      //         "What's up, Joy!",
      //         style: TextStyle(
      //           fontSize: 30,
      //           fontWeight: FontWeight.bold,
      //           color: Theme.of(context).colorScheme.primary,
      //         ),
      //       ),
      //       const SizedBox(
      //         height: 15,
      //       ),
      //       Text(
      //         "CATEGORIES",
      //         style: TextStyle(
      //           fontWeight: FontWeight.w500,
      //           color: Colors.grey.shade500,
      //         ),
      //       ),
      //       const SizedBox(
      //         height: 15,
      //       ),
      //       Row(
      //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //         children: [
      //           Expanded(
      //             flex: 1,
      //             child: Container(
      //               // width: 150,
      //               height: 125,
      //               decoration: BoxDecoration(
      //                   color: Colors.white,
      //                   borderRadius: BorderRadius.circular(15),
      //                   boxShadow: const [
      //                     BoxShadow(color: Colors.black12, blurRadius: 15)
      //                   ]),
      //               child: const Padding(
      //                 padding:
      //                     EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      //                 child: Column(
      //                   mainAxisAlignment: MainAxisAlignment.spaceAround,
      //                   crossAxisAlignment: CrossAxisAlignment.start,
      //                   children: [
      //                     Text(
      //                       "40 task",
      //                       style: TextStyle(
      //                         fontWeight: FontWeight.w500,
      //                         color: Colors.grey,
      //                       ),
      //                     ),
      //                     Text(
      //                       "Business",
      //                       style: TextStyle(
      //                           fontSize: 24, fontWeight: FontWeight.bold),
      //                     ),
      //                     Divider(
      //                       color: Colors.purple,
      //                       thickness: 4,
      //                     )
      //                   ],
      //                 ),
      //               ),
      //             ),
      //           ),
      //           const SizedBox(
      //             width: 25,
      //           ),
      //           Expanded(
      //             flex: 1,
      //             child: Container(
      //               // width: 150,
      //               height: 125,
      //               decoration: BoxDecoration(
      //                 borderRadius: BorderRadius.circular(15),
      //                 boxShadow: const [
      //                   BoxShadow(
      //                     color: Colors.black12,
      //                     blurRadius: 15,
      //                   )
      //                 ],
      //                 color: Colors.white,
      //               ),
      //               child: const Padding(
      //                 padding:
      //                     EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      //                 child: Column(
      //                   mainAxisAlignment: MainAxisAlignment.spaceAround,
      //                   crossAxisAlignment: CrossAxisAlignment.start,
      //                   children: [
      //                     Text(
      //                       "12 task",
      //                       style: TextStyle(
      //                         color: Colors.grey,
      //                         fontWeight: FontWeight.w500,
      //                       ),
      //                     ),
      //                     Text(
      //                       "Personal",
      //                       style: TextStyle(
      //                         fontSize: 24,
      //                         fontWeight: FontWeight.bold,
      //                       ),
      //                     ),
      //                     Divider(
      //                       color: Colors.cyan,
      //                       thickness: 4,
      //                     )
      //                   ],
      //                 ),
      //               ),
      //             ),
      //           )
      //         ],
      //       ),
      //       const SizedBox(
      //         height: 25,
      //       ),
      //       Text(
      //         "TODAY'S TASKS",
      //         style: TextStyle(
      //             color: Colors.grey.shade500, fontWeight: FontWeight.w500),
      //       ),
      //       const SizedBox(
      //         height: 15,
      //       ),
      //       ListTile(
      //         leading: const Icon(
      //           Icons.radio_button_unchecked,
      //           size: 30,
      //           color: Colors.purple,
      //         ),
      //         tileColor: Colors.white,
      //         shape: RoundedRectangleBorder(
      //           borderRadius: BorderRadius.circular(15),
      //           // side: const BorderSide(
      //           //   width: 2,
      //           //   color: Colors.purple,
      //           // ),
      //         ),
      //         title: Text(
      //           "Daily metting with team",
      //           style: TextStyle(
      //             fontSize: 18,
      //             fontWeight: FontWeight.w500,
      //             color: const Color(0xFF444444).withOpacity(0.8),
      //           ),
      //         ),
      //         onTap: () {},
      //       ),
      //       const SizedBox(
      //         height: 15,
      //       ),
      //       ListTile(
      //         leading: const Icon(
      //           Icons.radio_button_unchecked,
      //           color: Colors.cyan,
      //           size: 30,
      //         ),
      //         shape: RoundedRectangleBorder(
      //           borderRadius: BorderRadius.circular(15),
      //         ),
      //         tileColor: Colors.white,
      //         title: Text(
      //           "Check email",
      //           style: TextStyle(
      //             fontSize: 18,
      //             fontWeight: FontWeight.w500,
      //             color: const Color(0xFF444444).withOpacity(0.8),
      //           ),
      //         ),
      //         onTap: () {},
      //       ),
      //       StreamBuilder<List<TaskModel>>(
      //         stream: taskController.getTasksRealTime(),
      //         builder: (context, snapshot) {
      //           if (snapshot.connectionState == ConnectionState.waiting) {
      //             return const Center(
      //               child: CircularProgressIndicator(),
      //             );
      //           }
      //           if (snapshot.hasError) {
      //             return const Center(
      //               child: Text("Something went wrong!"),
      //             );
      //           }
      //           if (!snapshot.hasData) {
      //             return const Center(
      //               child: Text("No data available"),
      //             );
      //           }
      //           List<TaskModel> tasks = snapshot.data!;
      //           return ListView.builder(
      //             shrinkWrap: true,
      //             itemCount: tasks.length,
      //             itemBuilder: (context, index) {
      //               return ListTile(
      //                 title: Text(tasks[index].title!),
      //                 subtitle: Text(tasks[index].date!),
      //               );
      //             },
      //           );
      //         },
      //       )
      //     ],
      //   ),
      // ),
      body: const HomeBody(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => const AddTask());
        },
        backgroundColor: Colors.purple,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(1000),
        ),
        child: const Icon(
          Icons.add,
          size: 26,
          color: Colors.white,
        ),
      ),
      drawer: Drawer(
        child: StreamBuilder<DocumentSnapshot>(
          stream: FirebaseFirestore.instance
              .collection("users")
              .doc(profileController.firebaseAuth.currentUser?.uid)
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.hasError) {
              return const Text("Something went wrong");
            }
            if (snapshot.hasData && !snapshot.data!.exists) {
              return const Text("Document does not exist");
            }

            Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;

            // print(data["name"]);

            return ListView(
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
                          CircleAvatar(
                            backgroundImage: NetworkImage(
                              data["imageUrl"],
                            ),
                            radius: 45,
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 5,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.purple.shade200.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
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
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Text(
                        data["name"],
                        style: const TextStyle(
                          letterSpacing: 1.2,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        data["email"],
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey.shade300,
                          // color: Colors.white,
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
                        ..shader = const LinearGradient(
                            colors: [Colors.cyan, Colors.purple]).createShader(
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
                          content:
                              const Text("Are you sure you want to log out?"),
                          actions: [
                            RoundedLoadingButton(
                              color: Colors.purple,
                              successColor: Colors.green,
                              controller:
                                  authController.loadingButtonController.value,
                              onPressed: () {
                                authController.signOut();
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
            );
          },
        ),
      ),
    );
  }
}
