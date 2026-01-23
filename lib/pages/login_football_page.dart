
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:latihan1_11pplg1/controllers/login_football_controller.dart';
import 'package:latihan1_11pplg1/pages/mobile/login_mobile.dart';
import 'package:latihan1_11pplg1/pages/widescreen/login_widescreen.dart';

class LoginFootballPage extends StatelessWidget {
  LoginFootballPage({super.key});
final LoginFootballController controller = Get.find<LoginFootballController>( );

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        controller.updatelayout(constraints);

        return Obx(
          () => controller.isMobile.value
              ? LoginMobile()
              : LoginWidescreen(),
        );
      },
    );
  }
}
