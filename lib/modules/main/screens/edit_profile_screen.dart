import 'package:flutter/material.dart';
import 'package:gamified_todo_app/modules/main/controllers/profile_controller.dart';
import 'package:get/get.dart';

class EditProfileScreen extends GetView<ProfileController> {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text('Edit Profile')),
      body: SafeArea(
        child: SizedBox.expand(
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.only(
                    left: 16,
                    right: 16,
                    top: 16,
                    bottom:
                        120, // for portrait phone prevent bottom stack on form
                  ),
                  child: Column(
                    children: [
                      Center(
                        child: Stack(
                          children: [
                            Obx(
                              () => CircleAvatar(
                                radius: 91,
                                // backgroundColor: controller. Colors.green,
                                backgroundColor: controller.image.value != null
                                    ? Colors.green
                                    : Colors.redAccent,
                                child: CircleAvatar(
                                  radius: 87,
                                  backgroundImage:
                                      controller.image.value == null
                                      ? AssetImage(
                                          'assets/images/commons/profile_empty.png',
                                        )
                                      : FileImage(controller.image.value!),
                                ),
                              ),
                            ),
                            Positioned(
                              right: 10,
                              bottom: 0,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(.5),
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                child: IconButton(
                                  onPressed: () {
                                    controller.pickImage();
                                  },
                                  icon: Icon(
                                    Icons.photo_library_sharp,
                                    color: Colors.green,
                                    size: 40,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'Edit Picture',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.green,
                        ),
                      ),
                      const SizedBox(height: 20),

                      Form(
                        key: controller.formKey,
                        child: Column(
                          crossAxisAlignment: .start,
                          children: [
                            Text(
                              'Username',

                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 6),
                            _textFormCustome(
                              hintTxt: '@your name',
                              icon: Icons.person_4_outlined,
                              controllerParam: controller.usernameController,
                              formName: 'username',
                            ),

                            const SizedBox(height: 25),
                            Text(
                              'Bio',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            const SizedBox(height: 6),
                            _textFormCustome(
                              hintTxt: 'Bio',
                              icon: Icons.border_vertical_outlined,

                              controllerParam: controller.bioController,
                              formName: 'bio',
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              //end scroll
              Positioned(
                left: 16,
                right: 16,
                bottom: 10,
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () async {
                          bool success = await controller.submitProfile();

                          if (success) {
                            await Future.delayed(Duration(seconds: 1), () {
                              Get.back();
                            });

                            Get.snackbar(
                              'Success',
                              'Profile have been updated.',
                              backgroundColor: Colors.green,
                              duration: Duration(seconds: 1),
                            );
                          } else {
                            Get.snackbar(
                              'Failed',
                              'Invalid username or bio',
                              backgroundColor: Colors.redAccent,
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        child: const Text(
                          'Confirm',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _textFormCustome({
    required String hintTxt,
    required IconData icon,
    required controllerParam,
    required String formName,
  }) {
    return TextFormField(
      controller: controllerParam,
      decoration: InputDecoration(
        prefixIcon: Icon(icon),
        hintText: hintTxt,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(width: 1.5, color: Colors.green),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter $formName';
        }
        if (value.length > 150) {
          return 'Text is full';
        }
        return null;
      },
    );
  }
}
