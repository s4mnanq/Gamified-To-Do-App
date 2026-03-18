import 'package:flutter/material.dart';
import 'package:gamified_todo_app/core/constants/task_priority.dart';
import 'package:gamified_todo_app/modules/main/controllers/main_controller.dart';
// import 'package:gamified_todo_app/modules/main/controllers/main_controller.dart';
import 'package:gamified_todo_app/modules/main/model/task_model.dart';
import 'package:get/get.dart';
import './tasks_controller.dart';

class AddTaskController extends GetxController {
  //
  final TasksController taskController = Get.find<TasksController>();

  // Form
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final dueDateController = TextEditingController();
  final xpValueController = TextEditingController();

  //Priority
  final priorityCategory = TaskPriority.values.map((e) => e.value).toList();
  final selectedPriorityIndex = 0.obs;
  final selectedPriority = ''.obs;
  // Global key __
  final formKey = GlobalKey<FormState>();

  // Updated Color Priority Button
  void updatePriority(int priorityIndex) {
    selectedPriorityIndex.value = priorityIndex;
    selectedPriority.value = priorityCategory[priorityIndex];
  }

  // Validate all Form Method
  String? validateAllForms(String? value) {
    String message = 'Please enter some text';
    if (value == null || value.isEmpty) {
      return message;
    } else {
      return null;
    }
  }

  // DatePicked Method
  Rx<DateTime?> selectedDate = Rx<DateTime?>(null);

  void addTask() async {
    if (formKey.currentState!.validate()) {
      final task = TaskModel(
        title: titleController.text,
        description: descriptionController.text,
        due: dueDateController.text,
        xp: xpValueController.text,
        type: 'today',
        priority: selectedPriority.value,
      );
      taskController.addTask(task: task);
      taskController.tasks.refresh();

      if (!Get.isRegistered<MainController>()) {
        Get.put(() => MainController());
      }
      final mainController = Get.find<MainController>();
      mainController.currentIndex.value = 1;
      //
      await Future.delayed(Duration(milliseconds: 200), () {
        Get.back();
        Get.snackbar('Successful', 'Task have been added');
      });
    }
  }
} //end

// Rx vs .obs
