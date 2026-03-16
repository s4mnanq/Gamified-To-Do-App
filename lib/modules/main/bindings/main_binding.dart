import 'package:gamified_todo_app/modules/main/controllers/add_task_controller.dart';
import 'package:gamified_todo_app/modules/main/controllers/edit_task_controller.dart';
import 'package:gamified_todo_app/modules/main/controllers/home_controller.dart';
import 'package:gamified_todo_app/modules/main/controllers/profile_controller.dart';
import 'package:gamified_todo_app/modules/main/controllers/setting_controller.dart';
import 'package:gamified_todo_app/modules/main/controllers/tasks_controller.dart';
import 'package:gamified_todo_app/modules/main/controllers/calendar_controller.dart';
import 'package:gamified_todo_app/repositories/calendar_repository.dart';
import 'package:get/get.dart';
import '../controllers/main_controller.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MainController>(() => MainController());
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<TasksController>(() => TasksController());
    Get.lazyPut<AddTaskController>(() => AddTaskController());
    Get.lazyPut<EditTaskController>(() => EditTaskController());
    Get.lazyPut<SettingController>(() => SettingController(), fenix: true);
    Get.lazyPut<ProfileController>(() => ProfileController(), fenix: true);

    Get.lazyPut<CalendarRepository>(() => CalendarRepository());
  }
}
