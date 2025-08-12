import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:latihan1_11pplg1/models/football_model.dart';
import 'package:latihan1_11pplg1/controllers/football_controller.dart';

class FootballEditController extends GetxController {
  final txtImage = TextEditingController();
  final txtName = TextEditingController();
  final txtPosition = TextEditingController();
  final txtNumber = TextEditingController();

  void setData(FootballModel player) {
    txtImage.text = player.profileImage;
    txtName.text = player.name;
    txtPosition.text = player.position;
    txtNumber.text = player.number.toString();
  }

  void saveData(int index) {
    final controller = Get.find<FootballController>();
    controller.players[index] = FootballModel(
      profileImage: txtImage.text,
      name: txtName.text,
      position: txtPosition.text,
      number: int.tryParse(txtNumber.text) ?? 0,
    );

    Get.back();
    Get.snackbar(
      "success",
      "Player updated successfully",
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}
