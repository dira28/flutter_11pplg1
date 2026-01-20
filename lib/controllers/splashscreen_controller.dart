import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:latihan1_11pplg1/routes/routes.dart';

class SplashscreenController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    await Future.delayed(const Duration(seconds: 3));

    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token");

    if (token != null && token.isNotEmpty) {
      Get.offAllNamed(AppRoutes.mainpage);
    } else {
      Get.offAllNamed(AppRoutes.loginfootball);
    }
  }
}
