import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:latihan1_11pplg1/controllers/calculator_controller.dart';
import 'package:latihan1_11pplg1/routes/routes.dart';
import 'package:latihan1_11pplg1/widgets/widget_button.dart';
import 'package:latihan1_11pplg1/widgets/widget_textfield.dart';

class CalculatorPage extends StatelessWidget {
  CalculatorPage({super.key});

  final CalculatorController calculatorController = Get.put(
    CalculatorController(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Kalkulator"),
        backgroundColor: Colors.cyan,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomTextField(
              textEditingController: calculatorController.txtAngka1,
              hintText: "Masukkan Angka 1",
            ),
            const SizedBox(height: 16),
            CustomTextField(
              textEditingController: calculatorController.txtAngka2,
              hintText: "Masukkan Angka 2",
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomButton(
                  text: '+',
                  textColor: Colors.white,
                  onPressed: () {
                    calculatorController.tambah();
                  },
                ),
                CustomButton(
                  text: '-',
                  textColor: Colors.white,
                  onPressed: () {
                    calculatorController.kurang();
                  },
                ),
                CustomButton(
                  text: '×',
                  textColor: Colors.white,
                  onPressed: () {
                    calculatorController.kali();
                  },
                ),
                CustomButton(
                  text: '÷',
                  textColor: Colors.white,
                  onPressed: () {
                    calculatorController.Bagi();
                  },
                ),
              ],
            ),
            const SizedBox(height: 24),
            Obx(
              () => Text(
                "Hasil: " + calculatorController.hasil.value,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 16),
            CustomButton(
              text: 'Clear',
              textColor: Colors.white,
              onPressed: () {
                calculatorController.clear();
              },
            ),
          ],
        ),
      ),
    );
  }
}
