import 'package:get/get.dart';
import '../providers/midtrans_provider.dart';
import '../services/payment_service.dart';

class BuyController extends GetxController {
  final MidtransProvider _midtransProvider = MidtransProvider();
  final PaymentService _paymentService = PaymentService();

  var isPaying = false.obs;

  Future<void> checkout({
    required String title,
    required int amount,
  }) async {
    try {
      isPaying.value = true;

      final snapToken = await _midtransProvider.fetchSnapToken(
        title: title,
        amount: amount,
      );

      if (snapToken == null) {
        Get.snackbar("Error", "Gagal mendapatkan Snap Token");
        return;
      }

      await _paymentService.startPayment(snapToken);
    } catch (e) {
      Get.snackbar("Payment Error", e.toString());
    } finally {
      isPaying.value = false;
    }
  }
}
