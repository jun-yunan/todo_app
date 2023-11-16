import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/controllers/auth_controller.dart';
// import 'package:todo_app/models/profile_model.dart';
import 'package:todo_app/models/user_model.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthController controller = Get.put(AuthController());

    return Scaffold(
      // appBar: AppBar(
      //   title: const Text("Profile"),
      // ),
      body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(),
          child: SingleChildScrollView(
            child: StreamBuilder<UserModel>(
              stream: controller.getCurrentUserRealTime(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text("Something went wrong! ${snapshot.error}");
                } else if (snapshot.hasData) {
                  final user = snapshot.data!;
                  return Column(
                    children: [
                      Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Image(
                            image: NetworkImage(
                              user.imageUrl!.isEmpty
                                  ? 'https://images.pexels.com/photos/3243/pen-calendar-to-do-checklist.jpg'
                                  : user.imageUrl!,
                            ),
                            height: 350,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                          Positioned(
                            bottom: 15,
                            left: 15,
                            child: Text(
                              user.name!,
                              style: const TextStyle(
                                fontSize: 30,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 2,
                                shadows: [
                                  Shadow(
                                    color: Colors.purple,
                                    blurRadius: 30,
                                  )
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: -25,
                            right: 15,
                            child: IconButton(
                              style: IconButton.styleFrom(
                                  backgroundColor: Colors.purple,
                                  padding: const EdgeInsets.all(15),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  shadowColor: Colors.black54,
                                  elevation: 15),
                              onPressed: () {},
                              icon: const Icon(
                                Icons.edit,
                                color: Colors.white,
                                size: 30,
                              ),
                            ),
                          )
                        ],
                      ),
                      Container(
                        decoration: const BoxDecoration(),
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 30,
                          vertical: 30,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Container(
                            //   decoration: BoxDecoration(color: Colors.white),
                            //   child: Column(
                            //     children: [
                            //       Row(
                            //         children: [
                            //           Icon(
                            //             Icons.edit,
                            //             size: 26,
                            //             color: Colors.grey[700],
                            //           ),
                            //           Text(
                            //             "Bio",
                            //             style: TextStyle(
                            //               fontSize: 20,
                            //               fontWeight: FontWeight.w500,
                            //               color: Colors.grey[700],
                            //             ),
                            //           )
                            //         ],
                            //       ),
                            //       Text(
                            //         user.bio!,
                            //         maxLines: 3,
                            //         overflow: TextOverflow.ellipsis,
                            //         style: const TextStyle(fontSize: 15),
                            //       ),
                            //     ],
                            //   ),
                            // ),
                            TextFormField(
                              initialValue: user.bio!,
                              onEditingComplete: () {
                                Get.snackbar("update", "success");
                              },
                              readOnly: true,
                              maxLines: 4,
                              decoration: const InputDecoration(
                                labelText: "Bio",
                                labelStyle: TextStyle(
                                  fontSize: 26,
                                  fontWeight: FontWeight.bold,
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    width: 2,
                                    color: Colors.purple,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    width: 1,
                                    color: Colors.purple,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Container(
                              decoration: BoxDecoration(),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.phone,
                                        size: 30,
                                        color: Colors.grey[700],
                                      ),
                                      Text(
                                        "Phone",
                                        style: TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey[700],
                                        ),
                                      )
                                    ],
                                  ),
                                  Text(
                                    user.phoneNumber!,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Icon(Icons.email,
                                          size: 30,
                                          color: Colors.black.withOpacity(0.8)),
                                      Text(
                                        "Email",
                                        style: TextStyle(
                                            fontSize: 22,
                                            fontWeight: FontWeight.w500,
                                            color:
                                                Colors.black.withOpacity(0.8)),
                                      )
                                    ],
                                  ),
                                  Text(
                                    user.email!,
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.black.withOpacity(0.8),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Icon(Icons.cake,
                                          size: 30,
                                          color: Colors.black.withOpacity(0.8)),
                                      Text(
                                        "Birthday",
                                        style: TextStyle(
                                            fontSize: 22,
                                            fontWeight: FontWeight.w500,
                                            color:
                                                Colors.black.withOpacity(0.8)),
                                      ),
                                    ],
                                  ),
                                  Text(user.birthday!),
                                ],
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.pin_drop,
                                        size: 30,
                                        color: Colors.black.withOpacity(0.8),
                                      ),
                                      Text(
                                        "Address",
                                        style: TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black.withOpacity(0.8),
                                        ),
                                      )
                                    ],
                                  ),
                                  Text(user.address!),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      ElevatedButton(
                          onPressed: () {
                            controller.signOut();
                          },
                          child: const Text("Logout")),
                    ],
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          )),
    );
  }
}
