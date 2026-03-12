import 'package:flutter/material.dart';
import 'package:gamified_todo_app/routes/app_routes.dart';
import 'package:get/get.dart';
import '../controllers/profile_controller.dart';

class ProfileScreen extends GetView<ProfileController> {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              _profileCard(),
              const SizedBox(height: 70),
              _statTile(
                icon: Icons.local_fire_department,
                iconColor: Colors.orange,
                title: 'Current Streak',
                value: '5 days',
              ),

              const SizedBox(height: 15),
              _statTile(
                icon: Icons.checklist,
                iconColor: Colors.green,
                title: 'Task Completed',
                value: '156',
              ),

              const SizedBox(height: 15),
              _statTile(
                icon: Icons.emoji_events,
                iconColor: Colors.amber,
                title: 'Longest Streak',
                value: '17 days',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _profileCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        // color: const Color(0xFF1E1E1E),
        color: const Color.fromARGB(255, 48, 45, 45),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.green, width: 1.5),
      ),
      child: Column(
        children: [
          SizedBox(
            height: 135,
            child: Row(
              children: [
                Obx(
                  () => CircleAvatar(
                    radius: 40,
                    backgroundImage: controller.isConfirmImage.value
                        ? FileImage(controller.image.value!)
                        : const AssetImage(
                            'assets/images/commons/profile_empty.png',
                          ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    mainAxisAlignment: .center,
                    crossAxisAlignment: .start,
                    children: [
                      Obx(
                        () => controller.username.value == ''
                            ? const Text(
                                'Username',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Color.fromARGB(255, 1, 255, 10),
                                ),
                              )
                            : Text(
                                controller.username.value,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Color.fromARGB(255, 1, 255, 10),
                                ),
                              ),
                      ),
                      const SizedBox(height: 1),
                      Obx(
                        () => controller.bio.value == ''
                            ? const Text(
                                'No bio',
                                style: TextStyle(fontSize: 11.5),
                              )
                            : Text(
                                controller.bio.value,
                                maxLines: 4,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                      ),
                    ],
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.settings, color: Colors.red),
                      onPressed: () => Get.toNamed(AppRoutes.setting),
                    ),
                    IconButton(
                      icon: const Icon(Icons.edit, color: Colors.blue),
                      onPressed: () => Get.toNamed(AppRoutes.editProfile),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 100),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 46, 184, 50),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: Colors.black, width: 5),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  'Total 6,800 XP',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Level 7',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 30),
        ],
      ),
    );
  }

  Widget _statTile({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String value,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.green),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: iconColor.withOpacity(0.2),
            // backgroundColor: iconColor.withAlpha((0.2 * 355).toInt()),
            child: Icon(icon, color: iconColor),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(title, style: const TextStyle(color: Colors.grey)),
          ),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
