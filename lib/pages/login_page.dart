import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:latihan1_11pplg1/widgets/widget_button.dart';
import 'package:latihan1_11pplg1/widgets/widget_textfield.dart';
import 'package:latihan1_11pplg1/controllers/login_controller.dart';

class LoginPageNew extends StatelessWidget {
  LoginPageNew({super.key});

  final loginController = Get.find<LoginController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text("Login Page", style: TextStyle(color: Colors.white)),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 20),
            const Text(
              "Welcome Back!",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 30),

            CustomTextField(
              textEditingController: loginController.usernameController,
              hintText: "Username",
            ),
            const SizedBox(height: 16),
            CustomTextField(
              textEditingController: loginController.passwordController,
              hintText: "Password",
              obscureText: true,
            ),

            const SizedBox(height: 24),
            CustomButton(
              text: "LOGIN",
              textColor: Colors.black,
              onPressed: () {
                loginController.login();
              },
            ),
          ],
        ),
      ),
    );
  }
}
