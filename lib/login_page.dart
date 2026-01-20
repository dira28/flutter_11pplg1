import 'package:flutter/material.dart';
import 'package:latihan1_11pplg1/home_page.dart';
import 'package:latihan1_11pplg1/register_page.dart';
import 'package:latihan1_11pplg1/widgets/widget_button.dart';
import 'package:latihan1_11pplg1/widgets/widget_textfield.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          "Login Page",
          style: TextStyle(fontSize: 24, color: Colors.white),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
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
              "Please login using your email and password",
              style: TextStyle(color: Colors.black54),
            ),

            const SizedBox(height: 25),
            CustomTextField(
              textEditingController: emailController,
              hintText: "Email",
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
              child: CustomButton(
                text: "Login",
                textColor: Colors.black,
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const HomePage()),
                  );
                },
              ),
            ),

            const SizedBox(height: 20),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const RegisterPage()),
                );
              },
              child: Text(
                "Belum punya akun? Register di sini",
                style: TextStyle(fontSize: 15, color: Colors.yellow.shade700),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
