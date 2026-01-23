import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:latihan1_11pplg1/controllers/calculator_controller.dart';
import 'package:latihan1_11pplg1/widgets/widget_button.dart';
import 'package:latihan1_11pplg1/widgets/widget_textfield.dart';

class CalculatorWidescreen extends StatelessWidget {
  CalculatorWidescreen({super.key});

  final CalculatorController calculatorController =
      Get.find<CalculatorController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Kalkulator"),
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(32),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 1000,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// LEFT - INPUT
                Expanded(
                  flex: 2,
                  child: Column(
                    children: [
                      CustomTextField(
                        textEditingController:
                            calculatorController.txtAngka1,
                        hintText: "Masukkan Angka 1",
                      ),
                      const SizedBox(height: 20),
                      CustomTextField(
                        textEditingController:
                            calculatorController.txtAngka2,
                        hintText: "Masukkan Angka 2",
                      ),
                      const SizedBox(height: 32),
                      Obx(
                        () => Text(
                          "Hasil: ${calculatorController.hasil.value}",
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(width: 40),

                /// RIGHT - BUTTON
                Expanded(
                  flex: 1,
                  child: Column(
                    children: [
                      Wrap(
                        spacing: 16,
                        runSpacing: 16,
                        children: [
                          CustomButton(
                            text: '+',
                            textColor: Colors.white,
                            onPressed: calculatorController.tambah,
                          ),
                          CustomButton(
                            text: '-',
                            textColor: Colors.white,
                            onPressed: calculatorController.kurang,
                          ),
                          CustomButton(
                            text: '×',
                            textColor: Colors.white,
                            onPressed: calculatorController.kali,
                          ),
                          CustomButton(
                            text: '÷',
                            textColor: Colors.white,
                            onPressed: calculatorController.Bagi,
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      CustomButton(
                        text: 'Clear',
                        textColor: Colors.white,
                        onPressed: calculatorController.clear,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
