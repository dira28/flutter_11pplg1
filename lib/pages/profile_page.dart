import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile'), centerTitle: true),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            CircleAvatar(
              radius: 60,
              backgroundImage: AssetImage('assets/profiile.png'),
            ),
            SizedBox(height: 16),
            Text(
              "Dira Mayzaro Dekantari",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text("Kelas: X PPLG 1", style: TextStyle(fontSize: 18)),
            Text("Absen: 11", style: TextStyle(fontSize: 18)),
            Text("Asal: Sumbawa Barat", style: TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
