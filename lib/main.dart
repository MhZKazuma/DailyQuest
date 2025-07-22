import 'package:dailyquest_fixed/features/auth/login_screen.dart';
import 'package:dailyquest_fixed/features/auth/register_screen.dart';
import 'package:dailyquest_fixed/features/home/home_screen.dart';
import 'package:dailyquest_fixed/features/profile/profile_screen.dart';
import 'package:dailyquest_fixed/features/settings/settings_screen.dart';
import 'package:dailyquest_fixed/features/stats/stats_screen.dart';
import 'package:dailyquest_fixed/utils/notification_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'config/supabase_config.dart';
import 'controllers/auth_controller.dart';
import 'controllers/theme_controller.dart';
import 'routes/app_routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SupabaseConfig.init();
  await GetStorage.init();
  tz.initializeTimeZones();
  await NotificationHelper.init();

  Get.put(ThemeController());
  Get.put(AuthController());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'DailyQuest',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.system,
      initialRoute: AppRoutes.login,
      getPages: [
        GetPage(name: AppRoutes.login, page: () => LoginScreen()),
        GetPage(name: AppRoutes.register, page: () => RegisterScreen()),
        GetPage(name: AppRoutes.home, page: () => const HomeScreen()),
        GetPage(name: AppRoutes.profile, page: () => const ProfileScreen()),
        GetPage(name: AppRoutes.stats, page: () => const StatsScreen()),
        GetPage(name: AppRoutes.settings, page: () => SettingsScreen()),
      ],
    );
  }
}
