import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:latihan1_11pplg1/widgets/widget_button.dart';
import 'package:latihan1_11pplg1/widgets/widget_textfield.dart';
import '../controllers/football_edit_controller.dart';

class FootballEditPage extends StatelessWidget {
  FootballEditPage({super.key});
  final FootballEditController editCtrl = Get.put(FootballEditController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Player", style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Center(
              child: CircleAvatar(
                radius: 60,
                backgroundColor: Colors.yellow[600],
                backgroundImage: editCtrl.player.profileImage.isNotEmpty
                    ? AssetImage(editCtrl.player.profileImage)
                    : null,
                child: editCtrl.player.profileImage.isEmpty
                    ? const Icon(Icons.person, size: 60, color: Colors.black)
                    : null,
              ),
            ),
            const SizedBox(height: 20),
            _buildEditForm(),
          ],
        ),
      ),
    );
  }

  Widget _buildEditForm() {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CustomTextField(
              textEditingController: editCtrl.txtName,
              hintText: "Name",
            ),
            const SizedBox(height: 16),
            CustomTextField(
              textEditingController: editCtrl.txtPosition,
              hintText: "Position",
            ),
            const SizedBox(height: 16),
            CustomTextField(
              textEditingController: editCtrl.txtNumber,
              hintText: "Number",
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: CustomButton(
                text: "Save Changes",
                onPressed: editCtrl.saveData,
                textColor: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
