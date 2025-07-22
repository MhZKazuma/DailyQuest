import 'package:get/get.dart';
import '../features/auth/login_screen.dart';
import '../features/auth/register_screen.dart';
import '../features/home/home_screen.dart';
import '../features/profile/profile_screen.dart';
import '../features/stats/stats_screen.dart';
import '../features/settings/settings_screen.dart';

class AppRoutes {
  static const login = '/login';
  static const register = '/register';
  static const home = '/home';
  static const profile = '/profile';
  static const stats = '/stats';
  static const settings = '/settings';

  // ⬇️ Tambahkan ini untuk menyelesaikan error
  static final routes = [
    GetPage(name: login, page: () => LoginScreen()),
    GetPage(name: register, page: () => RegisterScreen()),
    GetPage(name: home, page: () => const HomeScreen()),
    GetPage(name: profile, page: () => const ProfileScreen()),
    GetPage(name: stats, page: () => const StatsScreen()),
    GetPage(name: settings, page: () => SettingsScreen()),
  ];
}
//rute app