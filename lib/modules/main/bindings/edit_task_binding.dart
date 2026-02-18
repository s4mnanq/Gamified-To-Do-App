import 'package:gamified_todo_app/modules/main/controllers/edit_task_controller.dart';
import 'package:get/get.dart';

class EditTaskBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EditTaskController>(() => EditTaskController());
  }
}
