import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ProfileController extends GetxController {
  final usernameController = TextEditingController();
  final bioController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final image = Rxn<File>();
  RxBool isConfirmImage = false.obs;
  RxString username = ''.obs;
  RxString bio = ''.obs;

  @override
  void onInit() {
    debugPrint('EditProfile controller initialized');
    loadingBioAndUsername();
    super.onInit();
  }

  void loadingBioAndUsername() {
    bio.value = bioController.text;
    username.value = usernameController.text;

    bioController.addListener(() {
      bio.value = bioController.text;
    });
    usernameController.addListener(() {
      username.value = usernameController.text;
    });
  }

  Future<void> pickImage() async {
    try {
      final pickFile = await ImagePicker().pickImage(
        source: ImageSource.gallery,
      );
      if (pickFile == null) return;
      image.value = File(pickFile.path);
    } catch (e) {
      debugPrint('Error : $e');
    }
  }

  // submit Image button
  // Future<void> submitProfile() async {
  //   // validate form
  //   try {
  //     if (!(formKey.currentState!.validate())) return;
  //     debugPrint('Username = ${usernameController.text}');
  //     debugPrint('Bio = ${bioController.text}');

  //     // validat prfile
  //     if (image.value == null) {
  //       isConfirmImage.value = false;
  //       Get.snackbar(
  //         'Fialed',
  //         'Please select a profile',
  //         colorText: Colors.redAccent,
  //         snackPosition: SnackPosition.TOP,
  //       );
  //       debugPrint('No image');
  //       return;
  //     }

  //     //if success
  //     Get.snackbar(
  //       'Success',
  //       'Profile\' have been updated',
  //       colorText: Colors.green,
  //       snackPosition: SnackPosition.TOP,
  //     );
  //     debugPrint('Username = ${usernameController.text}');
  //     debugPrint('Username = ${bioController.text}');
  //     debugPrint('Image Path = ${image.value!.path}');
  //     //
  //     isConfirmImage.value = true;
  //     return;
  //   } catch (e) {
  //     debugPrint('Error == $e');
  //     return;
  //   }
  // }

  Future<bool> submitProfile() async {
    try {
      if (!(formKey.currentState!.validate())) {
        return false;
      }
      if (image.value == null) {
        isConfirmImage.value = false;
        return true;
      } else if (image.value != null) {
        isConfirmImage.value = true;
        return true;
      }
      // if(success){
      debugPrint('Username = ${usernameController.text}');
      debugPrint('Bio = ${bioController.text}');

      isConfirmImage.value = true;
      return true;
    } catch (e) {
      debugPrint('Error = $e');
      return false;
    }
  }

  @override
  void onClose() {
    usernameController.dispose();
    bioController.dispose();
    super.onClose();
  }
}
