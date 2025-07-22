import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/theme_controller.dart';
import '../../controllers/auth_controller.dart';

class SettingsScreen extends StatelessWidget {
  SettingsScreen({super.key});

  final ThemeController _themeController = Get.find();
  final AuthController _authController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pengaturan')),
      body: ListView(
        children: [
          const ListTile(
            title: Text('Tentang Aplikasi'),
            subtitle: Text(
              'DailyQuest3 dibuat oleh:\n'
              'Raply Fediansyah\n'
              'Maheswara Hani Rapidya Kusuma\n'
              'Alif Akbar Andriyansyah\n',
            ),
          ),
          Obx(
            () => SwitchListTile(
              title: const Text('Mode Gelap'),
              value: _themeController.isDarkMode.value,
              onChanged: (_) => _themeController.toggleTheme(),
            ),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Logout'),
            onTap: () => _authController.logout(),
          ),
        ],
      ),
    );
  }
}
// ini settings screen