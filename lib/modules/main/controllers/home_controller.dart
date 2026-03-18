import 'package:gamified_todo_app/modules/main/controllers/profile_controller.dart';
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
  RxDouble levelXp = 45.0.obs;

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

  String getTimeForGreeting() {
    final hour = DateTime.now().hour.obs;
    if (hour >= 5 && hour < 12) {
      return 'Good Morning,';
    } else if (hour >= 12 && hour < 17) {
      return 'Good Afternoon,';
    } else if (hour >= 17 && hour < 22) {
      return 'Good Evening,';
    }
    return 'Good Night, ';
  }

  void loadingUsername() {
    // set default value
    username.value = profileController.usernameController.text;

    // Listen to update
    profileController.usernameController.addListener(() {
      username.value = profileController.usernameController.text;
    });
  }
}
