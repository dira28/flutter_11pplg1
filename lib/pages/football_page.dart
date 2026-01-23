import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:latihan1_11pplg1/pages/mobile/football_mobile.dart';
import 'package:latihan1_11pplg1/pages/widescreen/football_widescreen.dart';
import 'package:latihan1_11pplg1/controllers/responsive_controller.dart';

class FootballPage extends StatelessWidget {
  FootballPage({super.key});
  final ResponsiveController controller = Get.put(ResponsiveController());

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // detection width screen
        controller.updateLayout(constraints);

        // transforming load page
        return Obx(
          () => controller.isMobile.value
              ? FootballMobile()
              : FootballWidescreen(),
        );
      },
    );
  }
}
