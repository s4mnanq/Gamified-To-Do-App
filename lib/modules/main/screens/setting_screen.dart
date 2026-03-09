import 'package:flutter/material.dart';
import 'package:gamified_todo_app/modules/main/controllers/setting_controller.dart';
import 'package:get/get.dart';

class SettingScreen extends GetView<SettingController> {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Get.back(),
        ),
        title: const Text(
          'Settings',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            /// DARK MODE
            Obx(() => _settingTile(
                  icon: Icons.dark_mode,
                  iconColor: Colors.green,
                  title: 'Dark Mode',
                  subtitle: 'Toggle dark theme',
                  highlighted: true,
                  trailing: Switch(
                    value: controller.isDarkMode.value,
                    activeColor: Colors.green,
                    onChanged: controller.toggleDarkMode,
                  ),
                )),
            const SizedBox(height: 12),

            /// DAILY REMINDER
            Obx(() => _settingTile(
                  icon: Icons.notifications,
                  iconColor: Colors.green,
                  title: 'Daily Reminder',
                  subtitle: 'Notification time',
                  trailing: GestureDetector(
                    onTap: () => controller.pickTime(context),
                    child: _pillText(
                      controller.reminderTime.value.format(context),
                    ),
                  ),
                )),
            const SizedBox(height: 12),

            /// LANGUAGE
            Obx(() => _settingTile(
                  icon: Icons.language,
                  iconColor: Colors.green,
                  title: 'Language',
                  subtitle: 'App language',
                  trailing: GestureDetector(
                    onTap: _showLanguageSheet,
                    child: _pillText(controller.language.value),
                  ),
                )),
            const Spacer(),

            /// LOG OUT
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                onPressed: () {},
                child: const Text(
                  'Log out',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ---------- UI HELPERS ----------

  void _showLanguageSheet() {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: Color(0xFF1E1E1E),
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _languageOption('English'),
            _languageOption('Khmer'),
          ],
        ),
      ),
    );
  }

  Widget _languageOption(String value) {
    return Obx(() => ListTile(
          title: Text(value, style: const TextStyle(color: Colors.white)),
          trailing: controller.language.value == value
              ? const Icon(Icons.check, color: Colors.green)
              : null,
          onTap: () {
            controller.setLanguage(value);
            Get.back();
          },
        ));
  }

  Widget _settingTile({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String subtitle,
    required Widget trailing,
    bool highlighted = false,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFF2A2A2A),
        borderRadius: BorderRadius.circular(16),
        border: highlighted
            ? Border.all(color: Colors.blueAccent, width: 2)
            : null,
      ),
      child: Row(
        children: [
          Icon(icon, color: iconColor, size: 28),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 16)),
                const SizedBox(height: 4),
                Text(subtitle,
                    style:
                        const TextStyle(color: Colors.grey, fontSize: 13)),
              ],
            ),
          ),
          trailing,
        ],
      ),
    );
  }

  Widget _pillText(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.grey.shade700,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(text, style: const TextStyle(color: Colors.white)),
    );
  }
}
