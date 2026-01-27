import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:latihan1_11pplg1/controllers/movie_controller.dart';
import 'package:latihan1_11pplg1/pages/mobile/movie_mobile.dart';
import 'package:latihan1_11pplg1/pages/widescreen/movie_widescreen.dart';

class MoviePage extends StatelessWidget {
  MoviePage({super.key});

  @override
  Widget build(BuildContext context) {
    // ✅ Pastikan MovieController sudah terdaftar (untuk MainPage yang tidak pakai route)
    final MovieController controller = Get.put(MovieController());
    
    return LayoutBuilder(
      builder: (context, constraints) {
        controller.updatelayout(constraints);

        return Obx(
          () => controller.isMobile.value
              ? MovieMobile()
              : MovieWidescreen(),
        );
      },
    );
  }
}