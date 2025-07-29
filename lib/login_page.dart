import 'package:flutter/material.dart';
import 'package:latihan1_11pplg1/home_page.dart';
import 'package:latihan1_11pplg1/register_page.dart';

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
        backgroundColor: Colors.teal,
        title: Text(
          "Login Page",
          style: TextStyle(fontSize: 30, color: (Colors.white)),
        ),
      ),
      body: Container(
        margin: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                "Welcome",
                style: TextStyle(
                  fontSize: 25,
                  color: (Colors.black),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 30),

            Center(
              child: Image.asset(
                'assets/kalkulator.png',
                width: 250,
                height: 250,
              ),
            ),
            SizedBox(height: 20),

            Text("please login using your email and password"),
            Container(
              margin: EdgeInsets.only(top: 20, bottom: 20),
              child: TextField(
                controller: emailController,
                decoration: InputDecoration(
                  hintText: "Enter your email",
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(
                hintText: "Password",
                border: OutlineInputBorder(),
              ),
            ),

            Container(
              margin: EdgeInsets.only(top: 30),
              child: Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.cyan),
                  onPressed: () {
                    String email = emailController.text.trim();
                    String password = passwordController.text.trim();
                    if (email == 'admin' && password == '1234') {
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(SnackBar(content: Text('Sukses Login')));
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HomePage()),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Email atau Password salah')),
                      );
                    }
                  },
                  child: Text("Login", style: TextStyle(fontSize: 20)),
                ),
              ),
            ),

            Center(
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RegisterPage()),
                  );
                },
                child: Text(
                  "Belum punya akun? Register di sini",
                  style: TextStyle(
                    fontSize: 15,
                    color: (Colors.cyan),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
