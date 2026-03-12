import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ProfileController extends GetxController {
  //
  final usernameController = TextEditingController();
  final bioController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final image = Rxn<File>();
  RxBool isConfirmImage = false.obs;

  //
  @override
  void onInit() {
    debugPrint('EditProfile controller initialized');
    super.onInit();
  }

  Future<void> pickImage() async {
    final pickFile = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickFile == null) {
      return;
    } else {
      image.value = File(pickFile.path);
    }
  }

  // submit Image button
  Future<void> submitProfile() async {
    // validate form
    if (!(formKey.currentState!.validate())) return;
    debugPrint('Username = ${usernameController.text}');
    debugPrint('Bio = ${bioController.text}');

    // validat prfile
    if (image.value == null) {
      isConfirmImage.value = false;
      Get.snackbar(
        'Fialed',
        'Please select a profile',
        colorText: Colors.redAccent,
        snackPosition: SnackPosition.TOP,
      );
      debugPrint('No image');
      return;
    }

    //if success
    isConfirmImage.value = true;
    Get.snackbar(
      'Success',
      'Profile\' have been updated',
      colorText: Colors.green,
      snackPosition: SnackPosition.TOP,
    );

    debugPrint('Image Path = ${image.value!.path}');
  }

  @override
  void onClose() {
    usernameController.dispose();
    bioController.dispose();
    super.onClose();
  }
}
