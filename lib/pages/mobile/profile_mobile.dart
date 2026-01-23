import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:latihan1_11pplg1/controllers/login_football_controller.dart';
import 'package:latihan1_11pplg1/routes/routes.dart';

class ProfileMobile extends StatelessWidget {
  ProfileMobile({super.key});

  final LoginFootballController controller =
      Get.find<LoginFootballController>();

  void _showLogoutDialog() {
    Get.defaultDialog(
      title: "Konfirmasi Logout",
      middleText: "Yakin ingin keluar dari akun ini?",
      backgroundColor: Colors.white,
      radius: 10,
      confirm: ElevatedButton(
        onPressed: () async {
          await controller.logoutGoogle();
          Get.offAllNamed(AppRoutes.loginfootball);
        },
        style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
        child: const Text("Ya", style: TextStyle(color: Colors.white)),
      ),
      cancel: ElevatedButton(
        onPressed: () => Get.back(),
        style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
        child: const Text("Tidak", style: TextStyle(color: Colors.white)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      body: Obx(() {
        return Center(
          child: Column(
            children: [
              const SizedBox(height: 30),

              CircleAvatar(
                radius: 70,
                backgroundImage: controller.userPhoto.value.isNotEmpty
                    ? NetworkImage(controller.userPhoto.value)
                    : const AssetImage("assets/dira.jpg") as ImageProvider,
              ),

              const SizedBox(height: 20),
              Text(
                controller.userName.value.isNotEmpty
                    ? controller.userName.value
                    : "Dira",
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                controller.userEmail.value,
                style: const TextStyle(color: Colors.black54),
              ),

              const SizedBox(height: 40),

              ElevatedButton(
                onPressed: _showLogoutDialog,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 50,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  "Logout",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
