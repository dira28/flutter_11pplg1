import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:latihan1_11pplg1/helper/db_helper.dart';

class ContactController extends GetxController {
  final TextEditingController nameController = TextEditingController();

  final names = <Map<String, dynamic>>[].obs;

  final _dbHelper = DBHelper();

  @override
  void onInit() {
    super.onInit();
    fetchNames();
  }

  Future<void> fetchNames() async {
    final data = await _dbHelper.getNames();
    names.value = data;
  }

  Future<void> addName() async {
    final text = nameController.text.trim();
    if (text.isEmpty) {
      Get.snackbar(
        "Error",
        "Name cannot be empty!",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red.withAlpha(200),
        colorText: Colors.white,
        margin: const EdgeInsets.all(12),
        borderRadius: 10,
        duration: const Duration(seconds: 2),
      );
      return;
    }
    try {
      await _dbHelper.insertName(text);
      nameController.clear();
      await fetchNames();
      Get.snackbar(
        "Success",
        "Contact '$text' added successfully!",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.green.withAlpha(200),
        colorText: Colors.white,
        margin: const EdgeInsets.all(12),
        borderRadius: 10,
        duration: const Duration(seconds: 2),
      );
    } catch (e) {
      Get.snackbar(
        "Error",
        "Failed to save contact!",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red.withAlpha(200),
        colorText: Colors.white,
        margin: const EdgeInsets.all(12),
        borderRadius: 10,
        duration: const Duration(seconds: 2),
      );
    }
  }

  Future<void> deleteName(int id) async {
    try {
      await _dbHelper.deleteName(id);
      await fetchNames();
      Get.snackbar(
        "Deleted",
        "Contact deleted successfully!",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red.withAlpha(200),
        colorText: Colors.white,
        margin: const EdgeInsets.all(12),
        borderRadius: 10,
        duration: const Duration(seconds: 2),
      );
    } catch (e) {
      Get.snackbar(
        "Error",
        "Failed to delete contact!",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red.withAlpha(200),
        colorText: Colors.white,
        margin: const EdgeInsets.all(12),
        borderRadius: 10,
        duration: const Duration(seconds: 2),
      );
    }
  }

  Future<void> updateName(int id, String newName) async {
    if (newName.isEmpty) {
      Get.snackbar(
        "Error",
        "Name cannot be empty!",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red.withAlpha(200),
        colorText: Colors.white,
      );
      return;
    }

    try {
      await _dbHelper.updateName(id, newName);
      await fetchNames();
      Get.snackbar(
        "Updated",
        "Contact updated successfully!",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.green.withAlpha(200),
        colorText: Colors.white,
        margin: const EdgeInsets.all(12),
        borderRadius: 10,
        duration: const Duration(seconds: 2),
      );
    } catch (e) {
      Get.snackbar(
        "Error",
        "Failed to update contact!",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red.withAlpha(200),
        colorText: Colors.white,
      );
    }
  }

  @override
  void onClose() {
    nameController.dispose();
    super.onClose();
  }
}
