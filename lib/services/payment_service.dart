import 'package:midtrans_sdk/midtrans_sdk.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PaymentService {
  MidtransSDK? _midtrans;
  bool _initialized = false;

  Future<void> initSDK() async {
    if (_initialized) return;

    _midtrans = await MidtransSDK.init(
      config: MidtransConfig(
        clientKey: "Mid-client-ffVpnpMLOWQxcHM4",
        merchantBaseUrl: "http://10.0.2.2:3000/",
        colorTheme: ColorTheme(
          colorPrimary: Colors.blue,
          colorPrimaryDark: Colors.blue,
          colorSecondary: Colors.blueAccent,
        ),
      ),
    );

    _midtrans!.setTransactionFinishedCallback((result) {
      Get.snackbar(
        "Pembayaran",
        "Status: ${result.status}",
        snackPosition: SnackPosition.BOTTOM,
      );
    });

    _initialized = true;
  }

  Future<void> startPayment(String token) async {
    if (!_initialized) {
      await initSDK();
    }
    _midtrans!.startPaymentUiFlow(token: token);
  }
}
