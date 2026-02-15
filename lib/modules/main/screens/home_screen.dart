import 'package:flutter/material.dart';
// import 'package:gamified_todo_app/modules/main/screens/tasks_screen.dart';
import 'package:gamified_todo_app/routes/app_routes.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';
part '../widgets/_cart_widget.dart';

class HomeScreen extends GetView<HomeController> {
  @override
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Good Morning,'),
                        Obx(
                          () => Text(
                            '     ${controller.username.value}',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    CircleAvatar(
                      radius: 25.9,
                      child: CircleAvatar(
                        radius: 25.0,
                        backgroundImage: AssetImage(
                          'assets/images/commons/avartaProfile.png',
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20.0),
                Center(
                  child: Column(
                    children: [
                      Obx(
                        () => Text(
                          'Level ${controller.levelTotal.value}',
                          style: TextStyle(
                            fontSize: 38,
                            fontWeight: FontWeight.bold,
                            wordSpacing: 3,
                          ),
                        ),
                      ),
                      Text(
                        'Adventurer Quest',
                        style: TextStyle(
                          color: Colors.green,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20.0),
                Container(
                  padding: EdgeInsets.all(16),

                  // width: MediaQuery.of(context).size.width * 29,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: BoxBorder.all(color: Colors.green, width: 2.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Level XP',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Obx(
                            () => Text(
                              '${controller.levelXp.value}/100.0 XP',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                wordSpacing: 2.0,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ),
                        ],
                      ),

                      Obx(() => _buildProcessColor()),

                      Text(
                        'Daily Goal\nProcess',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                //
                IntrinsicHeight(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _CartWidget(
                        icon: Icons.check_box_outlined,
                        number: controller.completedNumber,
                        nameCart: 'Completed',
                      ),
                      _CartWidget(
                        icon: Icons.bolt_rounded,
                        colour: Colors.amber[900],
                        number: controller.currentStreakNumber,
                        nameCart: 'Current Streak',
                      ),
                      _CartWidget(
                        icon: Icons.check_box_outlined,
                        number: controller.totalXpNumber,
                        nameCart: 'Total XP',
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 60),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                    onPressed: () {
                      Get.toNamed(AppRoutes.tasks);
                    },
                    style: ElevatedButton.styleFrom(
                      // backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadiusGeometry.circular(12),
                      ),
                    ),
                    child: Text(
                      'View Task',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: controller.anAddTaskTap,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Icon(Icons.add, size: 28, fontWeight: FontWeight.w500),
      ),
    );
  }

  Widget _buildProcessColor() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 15),
      child: LinearProgressIndicator(
        value: controller.levelXp.value / 100,
        color: Colors.red,
        backgroundColor: Colors.grey[300],
        borderRadius: BorderRadius.circular(15),
        minHeight: 10,
        valueColor: AlwaysStoppedAnimation<Color>(
          controller.levelXp.value >= 80
              ? Colors.green
              : controller.levelXp.value > 70
              ? Colors.lightGreenAccent
              : controller.levelXp.value > 60
              ? Color(0xFFCCFF00)
              : controller.levelXp.value > 50
              ? Color(0xFFFFCC00)
              : controller.levelXp.value > 40
              ? Color(0xFFFF9900)
              : controller.levelXp.value > 30
              ? Color(0xFFFF6600)
              : controller.levelXp.value > 20
              ? Color(0xFFFF3300)
              : Color(0xFFFF0000),
        ),
      ),
    );
  }
}
