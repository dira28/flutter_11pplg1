import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/football_model.dart';

class FootballEditController extends GetxController {
  final txtName = TextEditingController();
  final txtPosition = TextEditingController();
  final txtNumber = TextEditingController();

  late FootballModel player;

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments as Map<String, dynamic>? ?? {};
    player = args['player'] as FootballModel;

    if (txtName.text.isEmpty) {
      setData(player);
    }
  }

  void setData(FootballModel player) {
    txtName.text = player.name;
    txtPosition.text = player.position;
    txtNumber.text = player.number.toString();
  }

  void saveData() {
    player.name = txtName.text;
    player.position = txtPosition.text;
    player.number = int.tryParse(txtNumber.text) ?? 0;
    Get.back(result: player);
  }
}
