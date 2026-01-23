
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:latihan1_11pplg1/controllers/responsive_controller.dart';
import 'package:latihan1_11pplg1/pages/mobile/profile_mobile.dart';
import 'package:latihan1_11pplg1/pages/widescreen/profile_widescreen.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});
  final ResponsiveController controller = Get.put(ResponsiveController());

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        controller.updateLayout(constraints);

        return Obx(
          () => controller.isMobile.value
              ? ProfileMobile()
              : ProfileWidescreen(),
        );
      },
    );
  }
}
