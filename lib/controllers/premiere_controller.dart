import 'dart:convert';
import 'package:flutter/material.dart' hide Table;
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:latihan1_11pplg1/models/Table_Model.dart';

class PremierTableController extends GetxController {
  var isLoading = false.obs;
  var standing = <Table>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchPremierTable();
  }

  fetchPremierTable() async {
    const url =
        'https://www.thesportsdb.com/api/v1/json/3/lookuptable.php?l=4328&s=2025-2026';
    try {
      isLoading.value = true;
      final response = await http.get(Uri.parse(url));
      print("status code" + response.statusCode.toString());
      print("json result" + response.body.toString());

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final List standingData = data['table'];
        standing.assignAll(standingData.map((e) => Table.fromJson(e)).toList());
      } else {
        Get.snackbar(
          "Error",
          "Gagal memuat data",
          snackPosition: SnackPosition.BOTTOM,
          margin: const EdgeInsets.all(12),
          borderRadius: 10,
          backgroundColor: const Color(0xCCF44336),
          colorText: Colors.white,
          duration: const Duration(seconds: 2),
        );
      }
    } catch (e) {
      Get.snackbar(
        "Warning",
        "Terjadi kesalahan saat memuat data",
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(12),
        borderRadius: 10,
        backgroundColor: const Color(0xCCFF9800),
        colorText: Colors.white,
        duration: const Duration(seconds: 2),
      );
    }
    isLoading.value = false;
  }
}
