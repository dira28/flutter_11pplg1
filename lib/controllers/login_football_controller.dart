import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../network/api.dart';
import '../pages/main_page.dart';

class LoginFootballController extends GetxController {
  var isLoading = false.obs;
  var loginSuccess = false.obs;

  var userName = "".obs;
  var userEmail = "".obs;
  var userPhoto = "".obs;

  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);

  // ✅ Login via API Username + Password (tetap)
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

          Get.snackbar(
            "Suksess",
            data["message"],
            snackPosition: SnackPosition.TOP,
            margin: const EdgeInsets.all(12),
            borderRadius: 10,
            backgroundColor: const Color(0xCC4CAF50),
            colorText: Colors.white,
          );

          await Future.delayed(const Duration(seconds: 2));
          Get.offAll(() => MainPage());
        } else {
          Get.snackbar(
            "Fail",
            "Incorrect username or password",
            snackPosition: SnackPosition.TOP,
            margin: const EdgeInsets.all(12),
            borderRadius: 10,
            backgroundColor: const Color(0xCCF44336),
            colorText: Colors.white,
          );
        }
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        e.toString(),
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

  Future<void> signInWithGoogle() async {
    try {
      isLoading.value = true;
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser != null) {
        userName.value = googleUser.displayName ?? "No Name";
        userEmail.value = googleUser.email;
        userPhoto.value = googleUser.photoUrl ?? "";

        final prefs = await SharedPreferences.getInstance();
        await prefs.setString("name", userName.value);
        await prefs.setString("email", userEmail.value);
        await prefs.setString("photo", userPhoto.value);

        Get.offAll(() => MainPage());
      }
    } catch (e) {
      Get.snackbar(
        "Google Login Error",
        e.toString(),
        backgroundColor: Colors.red,
        colorText: Colors.white,
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

    Get.offAllNamed('/loginFootball');
  }
}
