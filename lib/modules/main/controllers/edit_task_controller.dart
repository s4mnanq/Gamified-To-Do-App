import 'package:flutter/widgets.dart';
import 'package:gamified_todo_app/modules/main/controllers/tasks_controller.dart';
import 'package:gamified_todo_app/modules/main/model/task_model.dart';
import 'package:get/get.dart';

class EditTaskController extends GetxController {
  //
  final newTitleController = TextEditingController();
  final newDescriptionController = TextEditingController();
  final newDueDateController = TextEditingController();
  final newXpValueController = TextEditingController();
  final newformKey = GlobalKey<FormState>();

  final TasksController tasksController = Get.find<TasksController>();

  late int indexTask;

  Rx<DateTime?> selectedDate = Rx<DateTime?>(null);

  @override
  void onInit() {
    super.onInit();

    final arg = Get.arguments;
    final TaskModel task = arg['task'];
    indexTask = arg['index'];

    newTitleController.text = task.title.toString();
    newDescriptionController.text = task.description.toString();
    newDueDateController.text = task.due.toString();
    newXpValueController.text = task.xp.toString();
  }

  String? validateAllForms(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter some text';
    }
    return null;
  }

  void updatedTask() async {
    if (newformKey.currentState!.validate()) {
      tasksController.updateTask(
        indexTask,
        TaskModel(
          title: newTitleController.text,
          description: newDescriptionController.text,
          due: newDueDateController.text,
          xp: newXpValueController.text,
          type: tasksController.tasks[indexTask]['type'],
        ),
      );
      await Future.delayed(Duration(milliseconds: 200), () {
        Get.back();
        Get.snackbar('Successful', "Task have been updated");
      });
    }
  }
}
