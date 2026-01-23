import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:latihan1_11pplg1/controllers/calculator_controller.dart';
import 'package:latihan1_11pplg1/pages/mobile/calculator_mobile.dart';
import 'package:latihan1_11pplg1/pages/widescreen/calculator_widescreen.dart';


class CalculatorPage extends StatelessWidget {
  CalculatorPage({super.key});
  final CalculatorController calculatorController = Get.put(CalculatorController());

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        calculatorController.updatelayout(constraints);
        return Obx(
          () => calculatorController.isMobile.value
              ? CalculatorMobile()
              : CalculatorWidescreen(),
        );
      },
    );
  }
}
