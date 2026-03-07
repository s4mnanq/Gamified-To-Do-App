import 'package:gamified_todo_app/routes/app_routes.dart';
import 'package:get/get.dart';
import 'package:shadow_log/shadow_log.dart';

class HomeController extends GetxController {
  var username = ' Samnang'.obs;
  var levelTotal = 72.obs;
  var levelXp = 71.0.obs;

  var completedNumber = 0.obs;
  var currentStreakNumber = 7.obs;
  var totalXpNumber = 16.obs;

  void increaseCounter() {
    // completedNumber.value++;
    // currentStreakNumber.value++;
    // totalXpNumber.value++;
    // levelXp.value += 1;
    ShadowLog.i('${completedNumber.value}');
    ShadowLog.i('${levelXp.value}');
  }

  void anAddTaskTap() {
    increaseCounter();
    Get.toNamed(AppRoutes.addTask);
  }
}
