import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/theme_controller.dart';

class ThemeToggle extends StatelessWidget {
  final ThemeController _themeController = Get.find();

  ThemeToggle({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => SwitchListTile(
        title: const Text('Mode Gelap'),
        value: _themeController.isDarkMode.value,
        onChanged: (_) => _themeController.toggleTheme(),
      ),
    );
  }
}
