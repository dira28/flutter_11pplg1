import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:latihan1_11pplg1/controllers/football_edit_controller.dart';
import 'package:latihan1_11pplg1/models/football_model.dart';

class FootballEditPage extends StatelessWidget {
  FootballEditPage({super.key});

  final FootballEditController editCtrl = Get.put(FootballEditController());

  @override
  Widget build(BuildContext context) {
    final args = Get.arguments as Map<String, dynamic>? ?? {};
    final int index = args['index'] ?? 0;
    final FootballModel player = args['player'] as FootballModel;

    if (editCtrl.txtName.text.isEmpty) {
      editCtrl.setData(player);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Player"),
        centerTitle: true,
        backgroundColor: Colors.cyan,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Center(
              child: Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(player.profileImage),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.zero,
                ),
              ),
            ),
            const SizedBox(height: 16),

            TextField(
              controller: editCtrl.txtName,
              decoration: InputDecoration(
                labelText: "Name",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            const SizedBox(height: 12),

            TextField(
              controller: editCtrl.txtPosition,
              decoration: InputDecoration(
                labelText: "Position",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            const SizedBox(height: 12),

            TextField(
              controller: editCtrl.txtNumber,
              decoration: InputDecoration(
                labelText: "Number",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.cyan,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                onPressed: () {
                  editCtrl.saveData(index);
                },
                child: const Text(
                  "Save Changes",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
