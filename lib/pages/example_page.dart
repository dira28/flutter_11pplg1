import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:latihan1_11pplg1/controllers/example_controller.dart';
import 'package:latihan1_11pplg1/pages/football_page.dart';
import 'package:latihan1_11pplg1/pages/widescreen.dart/football_widescreen.dart';

class ExamplePage extends StatelessWidget {
  ExamplePage({super.key});
  final controller = Get.find<ExampleController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          //detection widht screen
          controller.updateLayout(constraints);
          //transforming load page
          return Obx(
            () => controller.isMobile.value
                ? FootballPage()
                : FootballWidescreen(),
          );
        },
      ),
    );
  }
}
