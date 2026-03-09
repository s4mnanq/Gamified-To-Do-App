import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class SettingController extends GetxController {
final isDarkMode = true.obs;

  // Reminder time
  final reminderTime = const TimeOfDay(hour: 9, minute: 0).obs;

  // Language
  final language = 'English'.obs;

  void toggleDarkMode(bool value) {
    isDarkMode.value = value;
  }

  Future<void> pickTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: reminderTime.value,
    );
    if (picked != null) {
      reminderTime.value = picked;
    }
  }

  void setLanguage(String value) {
    language.value = value;
  }
}