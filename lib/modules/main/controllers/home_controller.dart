import 'package:gamified_todo_app/modules/main/controllers/profile_controller.dart';
import 'package:gamified_todo_app/routes/app_routes.dart';
import 'package:get/get.dart';
import 'package:shadow_log/shadow_log.dart';

class HomeController extends GetxController {
  @override
  void onInit() {
    loadingUsername();
    super.onInit();
  }

  final profileController = Get.find<ProfileController>();

  RxString username = ''.obs;
  var levelTotal = 72.obs;
  var levelXp = 71.0.obs;

  var completedNumber = 0.obs;
  var currentStreakNumber = 7.obs;
  var totalXpNumber = 16.obs;

  //

  void increaseCounter() {
    // completedNumber.value++;
    // currentStreakNumber.value++;
    // totalXpNumber.value++;
    // levelXp.value += 1;
    ShadowLog.i('${completedNumber.value}');
    ShadowLog.i('${levelXp.value}');
  }

  void AddTaskTap() {
    increaseCounter();
    Get.toNamed(AppRoutes.addTask);
  }

  void loadingUsername() {
    // set default value
    username.value = profileController.usernameController.text;

    // Listen to update
    profileController.usernameController.addListener(() {
      username.value = profileController.usernameController.text;
    });
  }

  @override
  void onClose() {
    super.onClose();
  }
}
