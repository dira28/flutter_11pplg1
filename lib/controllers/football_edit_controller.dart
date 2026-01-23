import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/football_model.dart';
import '../controllers/football_controller.dart';

class FootballEditController extends GetxController {
  final txtName = TextEditingController();
  final txtPosition = TextEditingController();
  final txtNumber = TextEditingController();

  late FootballModel player;

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments as Map<String, dynamic>? ?? {};
    
    // ✅ Safe null check - ambil dari arguments atau dari controller
    final playerArg = args['player'] as FootballModel?;
    final indexArg = args['index'] as int?;
    
    if (playerArg != null) {
      // Jika player langsung di-pass
      player = playerArg;
    } else if (indexArg != null) {
      // Jika hanya index di-pass, ambil dari FootballController
      final footballCtrl = Get.find<FootballController>();
      if (indexArg >= 0 && indexArg < footballCtrl.players.length) {
        player = footballCtrl.players[indexArg];
      } else {
        // Fallback: buat player default jika index invalid
        player = FootballModel(
          profileImage: "assets/profiile.png",
          name: "",
          position: "",
          number: 0,
        );
        Get.snackbar(
          "Error",
          "Player tidak ditemukan",
          snackPosition: SnackPosition.BOTTOM,
          margin: const EdgeInsets.all(12),
          borderRadius: 10,
          backgroundColor: const Color(0xCCF44336),
          colorText: Colors.white,
          duration: const Duration(seconds: 2),
        );
        return;
      }
    } else {
      // Fallback: buat player default jika tidak ada arguments
      player = FootballModel(
        profileImage: "assets/profiile.png",
        name: "",
        position: "",
        number: 0,
      );
      Get.snackbar(
        "Warning",
        "Data player tidak ditemukan",
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(12),
        borderRadius: 10,
        backgroundColor: const Color(0xCCFF9800),
        colorText: Colors.white,
        duration: const Duration(seconds: 2),
      );
    }

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
    // ✅ Validasi input
    if (txtName.text.trim().isEmpty) {
      Get.snackbar(
        "Error",
        "Nama tidak boleh kosong",
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(12),
        borderRadius: 10,
        backgroundColor: const Color(0xCCF44336),
        colorText: Colors.white,
        duration: const Duration(seconds: 2),
      );
      return;
    }

    if (txtPosition.text.trim().isEmpty) {
      Get.snackbar(
        "Error",
        "Posisi tidak boleh kosong",
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(12),
        borderRadius: 10,
        backgroundColor: const Color(0xCCF44336),
        colorText: Colors.white,
        duration: const Duration(seconds: 2),
      );
      return;
    }

    final number = int.tryParse(txtNumber.text.trim());
    if (number == null || number <= 0) {
      Get.snackbar(
        "Error",
        "Nomor harus berupa angka positif",
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(12),
        borderRadius: 10,
        backgroundColor: const Color(0xCCF44336),
        colorText: Colors.white,
        duration: const Duration(seconds: 2),
      );
      return;
    }

    // ✅ Update player data
    player.name = txtName.text.trim();
    player.position = txtPosition.text.trim();
    player.number = number;

    // ✅ Refresh FootballController untuk update UI
    try {
      final footballCtrl = Get.find<FootballController>();
      footballCtrl.players.refresh();
    } catch (e) {
      // Jika controller tidak ditemukan, skip refresh
    }

    // ✅ Show success message
    Get.snackbar(
      "Success ✅",
      "Data player berhasil disimpan",
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(12),
      borderRadius: 10,
      backgroundColor: const Color(0xCC4CAF50),
      colorText: Colors.white,
      duration: const Duration(seconds: 2),
    );

    // ✅ Kembali ke halaman sebelumnya
    Get.back(result: player);
  }
}
