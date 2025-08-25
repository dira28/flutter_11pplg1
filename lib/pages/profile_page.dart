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
          children: [
            Container(
              width: 250,
              height: 350,
              decoration: BoxDecoration(
                image: const DecorationImage(
                  image: AssetImage('assets/dira.jpg'),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            const SizedBox(height: 30),
            const Text(
              "Dira Mayzaro Dekantari",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text("Kelas: X PPLG 1", style: TextStyle(fontSize: 18)),
            const Text("Absen: 11", style: TextStyle(fontSize: 18)),
            const Text("Asal: Sumbawa Barat", style: TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
