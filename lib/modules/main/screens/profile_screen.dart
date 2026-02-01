import 'package:flutter/material.dart';
import 'package:gamified_todo_app/modules/main/screens/setting_screen.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
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
        color: const Color(0xFF1E1E1E),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.green, width: 1.5),
      ),
      child: Column(
        children: [
          Row(
            children: [
              const CircleAvatar(
                radius: 37,
                backgroundImage: AssetImage('assets/images/commons/avatar.png'),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Madara Uchiha',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 21,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'I Love Sleeping',
                      style: TextStyle(color: Colors.grey, fontSize: 16),
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  IconButton(
                    icon: const Icon(Icons.settings, color: Colors.green),
                    onPressed: () {
                      Get.to(() => const SettingScreen());
                    },
                  ),

                  SizedBox(height: 25),
                  const Icon(Icons.edit, color: Colors.green),
                ],
              ),
            ],
          ),
          const SizedBox(height: 80),
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
