import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:latihan1_11pplg1/controllers/login_api_controller.dart';
import 'package:latihan1_11pplg1/home_page.dart';
import 'package:latihan1_11pplg1/register_page.dart';
import 'package:latihan1_11pplg1/widgets/widget_button.dart';
import 'package:latihan1_11pplg1/widgets/widget_textfield.dart';

class LoginApiPage extends StatelessWidget {
  LoginApiPage({super.key});

  final LoginApiController controller = Get.put(LoginApiController());
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void _handleLogin() async {
    final username = usernameController.text.trim();
    final password = passwordController.text.trim();

    if (username.isEmpty || password.isEmpty) {
      Get.snackbar(
        "Peringatan ⚠️",
        "Username dan password harus diisi",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.orange,
        colorText: Colors.white,
      );
      return;
    }

    await controller.loginApi(username, password);

    if (controller.loginSuccess.value == true) {
      Future.delayed(const Duration(seconds: 2), () {
        Get.off(() => const HomePage());
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          "Login API Page",
          style: TextStyle(fontSize: 24, color: Colors.white),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Obx(() {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              const Text(
                "Welcome",
                style: TextStyle(
                  fontSize: 26,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Image.asset('assets/kalkulator.png', width: 220, height: 220),
              const SizedBox(height: 20),
              const Text(
                "Please login using your username and password",
                style: TextStyle(color: Colors.black54),
              ),
              const SizedBox(height: 25),

              CustomTextField(
                textEditingController: usernameController,
                hintText: "Username",
              ),
              const SizedBox(height: 16),
              CustomTextField(
                textEditingController: passwordController,
                hintText: "Password",
                obscureText: true,
              ),

              const SizedBox(height: 30),

              SizedBox(
                width: double.infinity,
                child: controller.isLoading.value
                    ? const Center(child: CircularProgressIndicator())
                    : CustomButton(
                        text: "LOGIN",
                        textColor: Colors.black,
                        onPressed: _handleLogin,
                      ),
              ),

              const SizedBox(height: 20),
              TextButton(
                onPressed: () {
                  Get.to(() => const RegisterPage());
                },
                child: Text(
                  "Belum punya akun? Register di sini",
                  style: TextStyle(fontSize: 15, color: Colors.yellow.shade700),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}