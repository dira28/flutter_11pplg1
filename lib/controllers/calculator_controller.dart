import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CalculatorController extends GetxController {
  final txtAngka1 = TextEditingController();
  final txtAngka2 = TextEditingController();
  var hasil = "".obs;
  var isMobile = true.obs;

  void tambah() {
    int angka1 = int.parse(txtAngka1.text.toString());
    int angka2 = int.parse(txtAngka2.text.toString());

    int hasilJumlah = angka1 + angka2;
    print("Hasil tambah: " + hasilJumlah.toString());
    hasil.value = hasilJumlah.toString();
  }

  void kurang() {
    int angka1 = int.parse(txtAngka1.text.toString());
    int angka2 = int.parse(txtAngka2.text.toString());

    int hasilKurang = angka1 - angka2;
    print("Hasil tambah: " + hasilKurang.toString());
    hasil.value = hasilKurang.toString();
  }

  void kali() {
    int angka1 = int.parse(txtAngka1.text.toString());
    int angka2 = int.parse(txtAngka2.text.toString());

    int hasilKali = angka1 * angka2;
    print("Hasil kali: " + hasilKali.toString());
    hasil.value = hasilKali.toString();
  }

  void Bagi() {
    int angka1 = int.parse(txtAngka1.text);
    int angka2 = int.parse(txtAngka2.text);
    if (angka2 == 0) {
      hasil.value = "Tidak bisa dibagi 0";
    } else {
      double hasilBagi = angka1 / angka2;
      hasil.value = hasilBagi.toStringAsFixed(2);
    }
  }

  void clear() {
    txtAngka1.clear();
    txtAngka2.clear();
    hasil.value = "";
  }
  void updatelayout(BoxConstraints constraints) {
    isMobile.value = constraints.maxWidth < 600;
  }
}
