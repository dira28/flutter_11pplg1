import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../network/api.dart';
import '../pages/main_page.dart';
import '../routes/routes.dart';

class LoginFootballController extends GetxController {
  var isLoading = false.obs;
  var loginSuccess = false.obs;
  var isMobile = true.obs;

  var userName = "".obs;
  var userEmail = "".obs;
  var userPhoto = "".obs;

  // ✅ Google Sign In - untuk web perlu konfigurasi OAuth Client ID di Google Cloud Console
  // Jika tidak berfungsi, gunakan login dengan username dan password
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: ['email'],
    // Untuk web, tambahkan clientId jika sudah dikonfigurasi:
    // clientId: 'YOUR_CLIENT_ID.apps.googleusercontent.com',
  );

  // ✅ Login via API Username + Password (tetap berfungsi)
  Future<void> loginFootball(String username, String password) async {
    isLoading.value = true;
    loginSuccess.value = false;

    try {
      var response = await http.post(
        Uri.parse(Api.login),
        body: {"username": username, "password": password},
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data["status"] == true) {
          loginSuccess.value = true;

          final prefs = await SharedPreferences.getInstance();
          await prefs.setString("token", data["token"]);
          
          // ✅ Simpan username juga untuk ditampilkan di profile
          await prefs.setString("username", username);

          Get.snackbar(
            "Success ✅",
            data["message"] ?? "Login berhasil",
            snackPosition: SnackPosition.TOP,
            margin: const EdgeInsets.all(12),
            borderRadius: 10,
            backgroundColor: const Color(0xCC4CAF50),
            colorText: Colors.white,
            duration: const Duration(seconds: 2),
          );

          await Future.delayed(const Duration(seconds: 1));
          Get.offAll(() => MainPage());
        } else {
          Get.snackbar(
            "Login Gagal ❌",
            data["message"] ?? "Username atau password salah",
            snackPosition: SnackPosition.TOP,
            margin: const EdgeInsets.all(12),
            borderRadius: 10,
            backgroundColor: const Color(0xCCF44336),
            colorText: Colors.white,
            duration: const Duration(seconds: 3),
          );
        }
      } else {
        Get.snackbar(
          "Error",
          "Server error: ${response.statusCode}",
          snackPosition: SnackPosition.TOP,
          margin: const EdgeInsets.all(12),
          borderRadius: 10,
          backgroundColor: const Color(0xCCF44336),
          colorText: Colors.white,
        );
      }
    } catch (e) {
      String errorMsg = "Terjadi kesalahan saat login";
      
      if (e.toString().contains("SocketException") || 
          e.toString().contains("Failed host lookup")) {
        errorMsg = "Tidak ada koneksi internet. Periksa koneksi Anda.";
      } else if (e.toString().contains("TimeoutException")) {
        errorMsg = "Waktu tunggu habis. Coba lagi.";
      } else {
        errorMsg = "Error: ${e.toString()}";
      }
      
      Get.snackbar(
        "Error",
        errorMsg,
        snackPosition: SnackPosition.TOP,
        margin: const EdgeInsets.all(12),
        borderRadius: 10,
        backgroundColor: const Color(0xCC9E9E9E),
        colorText: Colors.white,
        duration: const Duration(seconds: 4),
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> signInWithGoogle() async {
    try {
      isLoading.value = true;
      
      // ✅ Coba sign in dengan Google
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser != null) {
        userName.value = googleUser.displayName ?? "No Name";
        userEmail.value = googleUser.email;
        userPhoto.value = googleUser.photoUrl ?? "";

        final prefs = await SharedPreferences.getInstance();
        await prefs.setString("name", userName.value);
        await prefs.setString("email", userEmail.value);
        await prefs.setString("photo", userPhoto.value);
        // ✅ Set token untuk bypass login check
        await prefs.setString("token", "google_signin_${googleUser.id}");

        Get.snackbar(
          "Success ✅",
          "Berhasil login dengan Google",
          snackPosition: SnackPosition.TOP,
          margin: const EdgeInsets.all(12),
          borderRadius: 10,
          backgroundColor: const Color(0xCC4CAF50),
          colorText: Colors.white,
          duration: const Duration(seconds: 2),
        );

        await Future.delayed(const Duration(seconds: 1));
        Get.offAll(() => MainPage());
      } else {
        // User membatalkan login
        Get.snackbar(
          "Info",
          "Login dibatalkan. Silakan gunakan username dan password.",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.orange,
          colorText: Colors.white,
          margin: const EdgeInsets.all(12),
          borderRadius: 10,
        );
      }
    } catch (e) {
      // ✅ Error handling yang lebih baik
      String errorMessage = "Gagal login dengan Google";
      
      if (e.toString().contains("network_error") || 
          e.toString().contains("SIGN_IN_CANCELLED")) {
        errorMessage = "Login dibatalkan atau masalah koneksi. Silakan gunakan username dan password.";
      } else if (e.toString().contains("SIGN_IN_REQUIRED")) {
        errorMessage = "Google Sign In belum dikonfigurasi. Silakan gunakan username dan password.";
      } else {
        errorMessage = "Error: ${e.toString()}";
      }
      
      Get.snackbar(
        "Google Login Error",
        errorMessage,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(12),
        borderRadius: 10,
        duration: const Duration(seconds: 4),
      );
    } finally {
      isLoading.value = false;
    }
  }

  // ✅ Ambil data user Google dari SharedPreferences
  Future<void> loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    userName.value = prefs.getString("name") ?? "";
    userEmail.value = prefs.getString("email") ?? "";
    userPhoto.value = prefs.getString("photo") ?? "";
  }

  // ✅ Logout Google
  Future<void> logoutGoogle() async {
    await _googleSignIn.signOut();
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();

    Get.offAllNamed(AppRoutes.loginfootball);
  }

  void updatelayout(BoxConstraints constraints) {
    isMobile.value = constraints.maxWidth < 600;
  }
}
