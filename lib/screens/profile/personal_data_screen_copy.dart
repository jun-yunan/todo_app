import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:todo_app/controllers/profile_controller.dart';
import 'package:todo_app/models/user_model.dart';
// import 'package:todo_app/utils/utils.dart';
import 'package:todo_app/widgets/form/custom_dialog.dart';
import 'package:todo_app/widgets/form/custom_text_form_field.dart';
import 'package:todo_app/widgets/personal_data_item.dart';

class PersonalDataScreenCopy extends StatefulWidget {
  const PersonalDataScreenCopy({super.key});

  @override
  State<PersonalDataScreenCopy> createState() => _PersonalDataScreenCopyState();
}

class _PersonalDataScreenCopyState extends State<PersonalDataScreenCopy> {
  final profileController = Get.put<ProfileController>(ProfileController());
  final TextEditingController bioController = TextEditingController();
  String bioText = "";
  String nameText = "";
  // String dateText = "";
  String addressText = "";
  String numberPhoneText = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        title: Text(
          "Personal Data",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            // color: const Color(0xFF444444).withOpacity(0.85),
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      ),
      body: StreamBuilder<UserModel>(
        stream: profileController.getCurrentUserRealTime(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text(
                "Something went wrong!",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            );
          } else if (snapshot.hasData) {
            final user = snapshot.data!;
            profileController.nameController.value.text = user.name!;
            // profileController.dateController.value.text = user.birthday!;
            // profileController.addressController.value.text = user.address!;
            // profileController.numberPhoneController.value.text =
            //     user.phoneNumber!;
            profileController.bioController.value.text = user.bio!;

            bioText = user.bio!;
            nameText = user.name!;
            // dateText = user.birthday!;
            addressText = user.address!;
            numberPhoneText = user.phoneNumber!;

            return SingleChildScrollView(
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 15,
                    ),
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Obx(
                          () => profileController.imageFile.value != null
                              ? CircleAvatar(
                                  backgroundImage: FileImage(
                                      profileController.imageFile.value!),
                                  radius: 75,
                                )
                              : CircleAvatar(
                                  backgroundImage: NetworkImage(user.imageUrl!),
                                  radius: 75,
                                ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: -8,
                          child: IconButton(
                            onPressed: () {
                              Get.dialog(
                                AlertDialog(
                                  title: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        "Upload image",
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          profileController.imageFile.value =
                                              null;
                                          Get.back();
                                        },
                                        style: IconButton.styleFrom(
                                          backgroundColor:
                                              const Color(0xFF444444)
                                                  .withOpacity(0.1),
                                          padding: const EdgeInsets.all(10),
                                        ),
                                        icon: const Icon(
                                          Icons.close,
                                          size: 26,
                                        ),
                                      )
                                    ],
                                  ),
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      Obx(
                                        () => Container(
                                          child: profileController
                                                      .imageFile.value ==
                                                  null
                                              ? CircleAvatar(
                                                  backgroundImage: NetworkImage(
                                                      user.imageUrl!),
                                                  radius: 100,
                                                )
                                              : CircleAvatar(
                                                  backgroundImage: FileImage(
                                                      profileController
                                                          .imageFile.value!),
                                                  radius: 100,
                                                ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                          profileController.setImageFile();
                                        },
                                        style: ElevatedButton.styleFrom(),
                                        child: const Text(
                                          "Select photo",
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  actions: [
                                    RoundedLoadingButton(
                                      controller: profileController
                                          .buttonUploadController.value,
                                      color: Colors.purple,
                                      successColor: Colors.green,
                                      onPressed: () {
                                        profileController.updateAvatar(context);
                                      },
                                      child: const Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(
                                            Icons.cloud_upload,
                                            color: Colors.white,
                                            size: 26,
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            "Upload",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                            style: IconButton.styleFrom(
                              padding: const EdgeInsets.all(8),
                              backgroundColor: Colors.purple.shade400,
                            ),
                            icon: const Icon(
                              Icons.add_photo_alternate_sharp,
                              size: 30,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      child: CustomTextFormField(
                        controller: profileController.bioController.value,
                        label: "Bio",
                        hintText: "Write bio here..",
                        readOnly: true,
                        maxLines: 3,
                        onTap: () {
                          Get.dialog(
                            CustomDialog(
                              initialValue: bioText,
                              title: "Bio",
                              onChanged: (p0) {
                                bioText = p0;
                              },
                              loadingButtonController: profileController
                                  .buttonLoadingController.value,
                              onPressed: () {
                                profileController.updateBio(bioText, context);
                              },
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    PersonalDataItem(
                      title: user.email!,
                      leadingText: "Email:",
                      leadingIcon: Icons.email,
                      isEmailField: true,
                    ),
                    PersonalDataItem(
                      title: user.name!,
                      leadingText: "Your name:",
                      leadingIcon: Icons.person,
                      onTap: () {
                        Get.dialog(
                          CustomDialog(
                            initialValue: nameText,
                            onPressed: () {
                              // profileController.updateInformationUser(context);
                              profileController.updateName(nameText, context);
                            },
                            onChanged: (p0) {
                              nameText = p0;
                            },
                            loadingButtonController:
                                profileController.buttonLoadingController.value,
                            title: "Your name",
                            // controller: profileController.nameController.value,
                            hintText: "Enter your name here...",
                          ),
                        );
                      },
                    ),
                    PersonalDataItem(
                      title: user.birthday!,
                      leadingText: "Date of birth:",
                      leadingIcon: Icons.cake,
                      onTap: () {
                        Get.dialog(
                          Obx(
                            () => CustomDialog(
                              onPressed: () {
                                profileController.updateDate(
                                    profileController.dateController.value.text,
                                    context);
                              },
                              loadingButtonController: profileController
                                  .buttonLoadingController.value,
                              title: "Date of birth",
                              readOnly: true,
                              hintText: user.birthday,
                              prefixIcon: const Icon(Icons.calendar_today),
                              onTap: () {
                                profileController.selectDate(context);
                              },
                              controller:
                                  profileController.dateController.value,
                            ),
                          ),
                        );
                      },
                    ),
                    PersonalDataItem(
                      title: user.gender!,
                      leadingText: "Gender:",
                      leadingIcon: Icons.transgender,
                      onTap: () {
                        Get.dialog(
                          Obx(
                            () => AlertDialog(
                              title: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    "Gender",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      // profileController.imageFile.value = null;
                                      Get.back();
                                    },
                                    style: IconButton.styleFrom(
                                        backgroundColor: const Color(0xFF444444)
                                            .withOpacity(0.1),
                                        padding: const EdgeInsets.all(10)),
                                    icon: const Icon(
                                      Icons.close,
                                      size: 26,
                                    ),
                                  )
                                ],
                              ),
                              content: DropdownButton<String>(
                                value: profileController.dropdownValue.value,
                                items: const [
                                  DropdownMenuItem<String>(
                                    value: "Male",
                                    child: Row(
                                      children: [
                                        Icon(Icons.male),
                                        Text("Male"),
                                      ],
                                    ),
                                  ),
                                  DropdownMenuItem<String>(
                                    value: "Female",
                                    child: Row(
                                      children: [
                                        Icon(Icons.female),
                                        Text("Female"),
                                      ],
                                    ),
                                  ),
                                  DropdownMenuItem<String>(
                                    value: "Other",
                                    child: Text("Other"),
                                  ),
                                ],
                                onChanged: (value) {
                                  profileController.setDropdownValue(
                                    value.toString(),
                                  );
                                },
                              ),
                              actions: [
                                RoundedLoadingButton(
                                  color: Colors.purple,
                                  successColor: Colors.green,
                                  controller: profileController
                                      .buttonLoadingController.value,
                                  onPressed: () {
                                    profileController.updateGender(
                                      profileController.dropdownValue.value,
                                      context,
                                    );
                                  },
                                  child: const Text(
                                    "Save",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                    PersonalDataItem(
                      title: user.address!,
                      leadingText: "Address:",
                      leadingIcon: Icons.place,
                      onTap: () {
                        Get.dialog(
                          CustomDialog(
                            onPressed: () {
                              profileController.updateAddress(
                                  addressText, context);
                            },
                            loadingButtonController:
                                profileController.buttonLoadingController.value,
                            title: "Address",
                            prefixIcon: const Icon(Icons.place),
                            hintText: "Enter your address here...",
                            initialValue: addressText,
                            onChanged: (p0) {
                              addressText = p0;
                            },
                            // controller:
                            //     profileController.addressController.value,
                          ),
                        );
                      },
                    ),
                    PersonalDataItem(
                      title: user.phoneNumber!,
                      leadingText: "Number phone:",
                      leadingIcon: Icons.phone,
                      onTap: () {
                        Get.dialog(
                          CustomDialog(
                            onPressed: () {
                              profileController.updateNumberPhone(
                                  numberPhoneText, context);
                            },
                            loadingButtonController:
                                profileController.buttonLoadingController.value,
                            title: "Number phone",
                            prefixIcon: const Icon(Icons.phone),
                            hintText: "Enter your number phone here...",
                            initialValue: numberPhoneText,
                            onChanged: (p0) {
                              numberPhoneText = p0;
                            },
                            // controller:
                            //     profileController.numberPhoneController.value,
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
