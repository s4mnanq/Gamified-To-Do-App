import 'package:flutter/material.dart';
import 'package:gamified_todo_app/modules/main/controllers/profile_controller.dart';
import 'package:gamified_todo_app/routes/app_routes.dart';
import 'package:get/get.dart';
import 'package:shadow_log/shadow_log.dart';
import '../controllers/home_controller.dart';
part '../widgets/_cart_widget.dart';

class HomeScreen extends GetView<HomeController> {
  final profileController = Get.find<ProfileController>();
  HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: SafeArea(
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 120),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: .spaceBetween,
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
                          Obx(
                            () => CircleAvatar(
                              radius: 25.9,
                              child: CircleAvatar(
                                radius: 25.0,
                                backgroundImage:
                                    profileController.isConfirmImage.value ==
                                        true
                                    ? FileImage(profileController.image.value!)
                                          as ImageProvider
                                    : AssetImage(
                                        'assets/images/commons/profile_empty.png',
                                      ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Center(
                        child: Column(
                          children: [
                            Obx(
                              () => Text(
                                'Level ${controller.levelTotal.value}',
                                // style: TextStyle(
                                //   fontSize: 38,
                                //   fontWeight: FontWeight.bold,
                                //   wordSpacing: 3,
                                // ),
                                style: TextStyle(
                                  fontSize: 38.0,
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
                          border: BoxBorder.all(
                            color: Colors.green,
                            width: 2.0,
                          ),
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
                              color: Colors.amber[900],
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
                      const SizedBox(height: 140),
                    ],
                  ),
                ),
              ),
              //
              Positioned(
                right: 16,
                left: 16,
                bottom: 10,
                child: Row(
                  children: [
                    Expanded(
                      flex: 6,
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
                    SizedBox(width: 10),
                    Expanded(
                      child: Container(
                        height: 51,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 1, 255, 10),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: IconButton(
                          onPressed: controller.AddTaskTap,
                          icon: Icon(Icons.add, color: Colors.black),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
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
