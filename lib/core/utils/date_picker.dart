import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<void> pickDate(
  final Rx<DateTime?> selectedDateTime,
  final TextEditingController dueDateController,
) async {
  // pick date
  DateTime? pickedDate = await showDatePicker(
    context: Get.context!,
    initialDate: DateTime.now(),
    firstDate: DateTime(2024),
    lastDate: DateTime(2100),
  );

  if (pickedDate == null) {
    return;
  }
  // picked time
  TimeOfDay? pickedTime = await showTimePicker(
    context: Get.context!,
    initialTime: TimeOfDay.now(),
  );
  if (pickedTime == null) {
    return;
  }

  final combinedDateTime = DateTime(
    pickedDate.day,
    pickedDate.month,
    pickedDate.year,
    pickedTime.hour,
    pickedTime.minute,
  );
  // save date
  selectedDateTime.value = combinedDateTime;

  // show in textformfield
  dueDateController.text =
      '${_formatDate(pickedDate)} ${pickedTime.format(Get.context!)}';
}

String _formatDate(DateTime date) {
  return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year.toString()}';
}
