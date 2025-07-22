import 'package:get/get.dart';
import '../routes/app_routes.dart';
import '../services/auth_service.dart';

class AuthController extends GetxController {
  final AuthService _authService = AuthService();
  final RxBool isLoading = false.obs;

  Future<void> login(String email, String password) async {
    isLoading.value = true;
    try {
      await _authService.login(email: email, password: password);
      Get.offAllNamed(AppRoutes.home); // arahkan ke Home
    } catch (e) {
      Get.snackbar('Login Gagal', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> register(String email, String password) async {
    isLoading.value = true;
    try {
      await _authService.register(email: email, password: password);
      Get.snackbar('Registrasi Berhasil', 'Silakan login.');
      Get.offAllNamed(AppRoutes.login);
    } catch (e) {
      Get.snackbar('Registrasi Gagal', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> logout() async {
    await _authService.logout();
    Get.offAllNamed(AppRoutes.login);
  }
}
