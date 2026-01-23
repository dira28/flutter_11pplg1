import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:latihan1_11pplg1/controllers/login_football_controller.dart';
import 'package:latihan1_11pplg1/routes/routes.dart';

class ProfileWidescreen extends StatelessWidget {
  ProfileWidescreen({super.key});

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
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 32),
        child: Obx(
          () => Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 900),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// LEFT - AVATAR
                  Expanded(
                    flex: 1,
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 80,
                          backgroundImage: controller.userPhoto.value.isNotEmpty
                              ? NetworkImage(controller.userPhoto.value)
                              : const AssetImage("assets/dira.jpg")
                                    as ImageProvider,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(width: 60),

                  /// RIGHT - INFO
                  Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          controller.userName.value.isNotEmpty
                              ? controller.userName.value
                              : "Dira",
                          style: const TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          controller.userEmail.value,
                          style: const TextStyle(
                            color: Colors.black54,
                            fontSize: 16,
                          ),
                        ),

                        const SizedBox(height: 40),

                        ElevatedButton(
                          onPressed: _showLogoutDialog,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 60,
                              vertical: 14,
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
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
