import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:latihan1_11pplg1/routes/routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  login() async {
    if (usernameController.text.toString() == "admin" &&
        passwordController.text.toString() == "1234") {
      final prefs = await SharedPreferences.getInstance();
      prefs.setString("username", usernameController.text.toString());
      Get.offAllNamed(AppRoutes.mainpage);
    } else {
      Get.snackbar("Error", "Incorrect username and password");
    }
  }
}
