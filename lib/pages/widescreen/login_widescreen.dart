import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:latihan1_11pplg1/controllers/login_football_controller.dart';

class LoginWidescreen extends StatelessWidget {
  LoginWidescreen({super.key});

  final LoginFootballController controller = Get.find<LoginFootballController>();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void _handleLogin() async {
    final username = usernameController.text.trim();
    final password = passwordController.text.trim();

    if (username.isEmpty || password.isEmpty) {
      Get.snackbar(
        "Warning ⚠️",
        "Username dan password tidak boleh kosong",
        snackPosition: SnackPosition.TOP,
        margin: const EdgeInsets.all(12),
        borderRadius: 10,
        backgroundColor: const Color(0xCCFFB300),
        colorText: Colors.white,
      );
      return;
    }

    await controller.loginFootball(username, password);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Row(
          children: [
            // ================= LEFT BRANDING =================
            Expanded(
              flex: 2,
              child: Container(
                color: Colors.black,
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ShaderMask(
                        shaderCallback: (rect) {
                          return RadialGradient(
                            colors: [
                              Colors.yellow.shade400,
                              Colors.yellow.shade600,
                              Colors.orange.shade700,
                            ],
                            radius: 0.8,
                          ).createShader(rect);
                        },
                        blendMode: BlendMode.srcIn,
                        child: const FaIcon(FontAwesomeIcons.futbol, size: 140),
                      ),
                      const SizedBox(height: 24),
                      const Text(
                        "FOOTBALL APP",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.yellow,
                          letterSpacing: 1.5,
                        ),
                      ),
                      const SizedBox(height: 6),
                      const Text(
                        "Login and start the game",
                        style: TextStyle(color: Colors.white70, fontSize: 13),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // ================= RIGHT FORM (SCROLL) =================
            Expanded(
              flex: 3,
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 48,
                  vertical: 32,
                ),
                child: Center(
                  child: SizedBox(
                    width: 400,
                    child: Obx(
                      () => Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const SizedBox(height: 40),

                          const Text(
                            "Welcome!",
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            "Login to continue",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black54,
                            ),
                          ),
                          const SizedBox(height: 36),

                          // USERNAME
                          TextField(
                            controller: usernameController,
                            decoration: _inputDecoration(
                              "Username",
                              Icons.person_outline,
                            ),
                          ),
                          const SizedBox(height: 18),

                          // PASSWORD
                          TextField(
                            controller: passwordController,
                            obscureText: true,
                            decoration: _inputDecoration(
                              "Password",
                              Icons.lock_outline,
                            ),
                          ),
                          const SizedBox(height: 28),

                          // LOGIN BUTTON
                          SizedBox(
                            height: 48,
                            child: controller.isLoading.value
                                ? const Center(
                                    child: CircularProgressIndicator(
                                      color: Colors.yellow,
                                    ),
                                  )
                                : ElevatedButton(
                                    onPressed: _handleLogin,
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.black,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                    child: const Text(
                                      "LOGIN",
                                      style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.yellow,
                                      ),
                                    ),
                                  ),
                          ),
                          const SizedBox(height: 26),

                          const Text(
                            "Or continue with",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 13,
                            ),
                          ),
                          const SizedBox(height: 14),

                          // GOOGLE LOGIN
                          SizedBox(
                            height: 48,
                            child: ElevatedButton.icon(
                              onPressed: controller.signInWithGoogle,
                              icon: const FaIcon(
                                FontAwesomeIcons.google,
                                color: Colors.red,
                                size: 18,
                              ),
                              label: const Text(
                                "Sign in with Google",
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  side: const BorderSide(
                                    color: Colors.black,
                                    width: 1.4,
                                  ),
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 40),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String hint, IconData icon) {
    return InputDecoration(
      hintText: hint,
      isDense: true, // 🔥 penting
      contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
      prefixIcon: Icon(icon, color: Colors.yellow),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.yellow, width: 2),
        borderRadius: BorderRadius.circular(12),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.yellow, width: 1.5),
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }
}
