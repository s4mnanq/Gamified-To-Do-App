import 'package:gamified_todo_app/modules/main/controllers/calendar_controller.dart';
import 'package:gamified_todo_app/repositories/calendar_repository.dart';
import 'package:get/get.dart';
import '../controllers/main_controller.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MainController>(() => MainController());

    Get.lazyPut<CalendarRepository>(() => CalendarRepository());

    Get.lazyPut<CalendarController>(() => CalendarController());
  }
}
