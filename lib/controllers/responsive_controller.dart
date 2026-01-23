import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Controller kecil khusus untuk menentukan layout (mobile vs widescreen).
/// Dipakai oleh wrapper pages yang hanya butuh deteksi lebar layar.
class ResponsiveController extends GetxController {
  final isMobile = true.obs;

  void updateLayout(BoxConstraints constraints) {
    isMobile.value = constraints.maxWidth < 600;
  }

  // Alias biar tetap kompatibel dengan penamaan sebelumnya.
  void updatelayout(BoxConstraints constraints) => updateLayout(constraints);
}

