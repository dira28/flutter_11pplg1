import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:latihan1_11pplg1/controllers/login_football_controller.dart';


class LoginMobile extends StatelessWidget {
  LoginMobile({super.key});

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

  Widget _neonFootballIcon() {
    return Center(
      child: Container(
        width: 150,
        height: 150,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: RadialGradient(
            colors: [Colors.black, Colors.black],
            center: Alignment(-0.2, -0.2),
            radius: 0.9,
          ),
        ),
        child: Center(
          child: ShaderMask(
            shaderCallback: (rect) {
              return RadialGradient(
                colors: [
                  Colors.yellow.shade400,
                  Colors.yellow.shade600,
                  Colors.orange.shade700,
                ],
                center: Alignment.center,
                radius: 0.8,
              ).createShader(rect);
            },
            blendMode: BlendMode.srcIn,
            child: const FaIcon(FontAwesomeIcons.futbol, size: 120),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Login Football",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Obx(() {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 24),

              const Text(
                "Welcome!",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 6),
              const Text(
                "Login to continue",
                style: TextStyle(fontSize: 14, color: Colors.black54),
              ),
              const SizedBox(height: 25),

              _neonFootballIcon(),
              const SizedBox(height: 50),

              TextField(
                controller: usernameController,
                decoration: InputDecoration(
                  hintText: "Username",
                  prefixIcon: const Icon(
                    Icons.person_outline,
                    color: Colors.yellow,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Colors.yellow,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Colors.yellow,
                      width: 1.5,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 18),

              // Password
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: "Password",
                  prefixIcon: const Icon(
                    Icons.lock_outline,
                    color: Colors.yellow,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Colors.yellow,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Colors.yellow,
                      width: 1.5,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Login Button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: controller.isLoading.value
                    ? const Center(
                        child: CircularProgressIndicator(color: Colors.yellow),
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
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.yellow,
                          ),
                        ),
                      ),
              ),
              const SizedBox(height: 22),

              const Text(
                "Or continue with",
                style: TextStyle(color: Colors.black54),
              ),
              const SizedBox(height: 12),

              // Google Sign in (kept as button with icon)
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton.icon(
                  onPressed: () async {
                    await controller.signInWithGoogle();
                  },
                  icon: const FaIcon(
                    FontAwesomeIcons.google,
                    color: Colors.red,
                  ),
                  label: const Text(
                    "Sign in with Google",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: const BorderSide(color: Colors.black, width: 1.5),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 26),
            ],
          );
        }),
      ),
    );
  }
}
