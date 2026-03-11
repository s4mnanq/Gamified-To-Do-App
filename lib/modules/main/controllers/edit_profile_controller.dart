// import 'package:flutter/foundation.dart';
// import 'package:get/get.dart';
// import 'dart:io';
// import 'package:image_picker/image_picker.dart';

// class EditProfileController extends GetxController {
//   @override
//   void onInit() {
//     debugPrint('EditProfile controller initialized');
//     super.onInit();
//   }

//   final image = Rxn<File>();
//   Future<void> pickImage() async {
//     final pickFile = await ImagePicker().pickImage(source: ImageSource.gallery);

//     if (pickFile == null) {
//       return;
//     } else {
//       image.value = File(pickFile.path);
//     }
//   }

//   @override
//   void dispose() {
//     super.dispose();
//   }
// }
