import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../models/login_model.dart';
import '../network/api.dart';

class LoginApiController extends GetxController {
  var isLoading = false.obs;
  var loginData = Rxn<LoginModel>();
  var loginSuccess = false.obs;

  Future<void> loginApi(String username, String password) async {
    isLoading.value = true;
    loginSuccess.value = false;

    try {
      var response = await http.post(
        Uri.parse(Api.login),
        body: {"username": username, "password": password},
      );

      if (response.statusCode == 200) {
        final data = loginModelFromJson(response.body);
        loginData.value = data;

        if (data.status) {
          loginSuccess.value = true;

          Get.snackbar(
            "Sukses",
            data.message,
            snackPosition: SnackPosition.TOP,
            margin: const EdgeInsets.all(12),
            borderRadius: 10,
            backgroundColor: const Color(0xCC4CAF50),
            titleText: const Text(
              "Sukses ✅",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            messageText: Text(
              data.message,
              style: const TextStyle(color: Colors.white),
            ),
            duration: const Duration(seconds: 2),
          );
        } else {
          loginSuccess.value = false;

          Get.snackbar(
            "Gagal ",
            "Username atau password salah",
            snackPosition: SnackPosition.TOP,
            margin: const EdgeInsets.all(12),
            borderRadius: 10,
            backgroundColor: const Color(0xCCF44336),
            titleText: const Text(
              "Gagal",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            messageText: const Text(
              "Username atau password salah",
              style: TextStyle(color: Colors.white),
            ),
            duration: const Duration(seconds: 2),
          );
        }
      } else {
        loginSuccess.value = false;
        Get.snackbar(
          "Error ⚠️",
          "Terjadi kesalahan server",
          snackPosition: SnackPosition.TOP,
          margin: const EdgeInsets.all(12),
          borderRadius: 10,
          backgroundColor: const Color(0xCCFF9800),
          colorText: Colors.white,
        );
      }
    } catch (e) {
      loginSuccess.value = false;
      Get.snackbar(
        "Error ⚠️",
        "Tidak dapat terhubung ke server",
        snackPosition: SnackPosition.TOP,
        margin: const EdgeInsets.all(12),
        borderRadius: 10,
        backgroundColor: const Color(0xCC9E9E9E),
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }
}