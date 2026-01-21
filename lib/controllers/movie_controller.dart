import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../services/payment_service.dart';
import '../providers/midtrans_provider.dart';

class MovieController extends GetxController {
  var isLoading = false.obs;
  var movies = <Map<String, dynamic>>[].obs;

  final movieRef = FirebaseFirestore.instance.collection('movies');

  final PaymentService _paymentService = PaymentService();
  final MidtransProvider _midtransProvider = MidtransProvider();

  @override
  void onInit() {
    super.onInit();
    loadMovies();
  }

  // ================== PEMBAYARAN ==================
  Future<void> checkoutMovie({
    required String title,
    required int amount,
  }) async {
    try {
      isLoading.value = true;

      final snapToken =
          await _midtransProvider.fetchSnapToken(amount, title);

      isLoading.value = false;

      if (snapToken == null) {
        Get.snackbar("Error", "Gagal mendapatkan Snap Token");
        return;
      }

      await _paymentService.startPayment(snapToken);
    } catch (e) {
      isLoading.value = false;
      Get.snackbar("Error", e.toString());
    }
  }

  // ================== DATA MOVIE ==================
  Future<void> loadMovies() async {
    isLoading.value = true;
    movies.clear();
    await fetchMoviesFromFirestore();
    isLoading.value = false;
  }

  Future<void> fetchMoviesFromFirestore() async {
    final snapshot = await movieRef.get();
    movies.value = snapshot.docs
        .map((doc) => doc.data())
        .toList();
  }
  Future<void> fetchMoviesFromAPI() async {
    /* Kode API Anda */
  }
  Future<void> addMovie(Map<String, dynamic> movie) async {
    /* Kode Create Anda */
  }
  Future<void> updateMovie(int index, Map<String, dynamic> movie) async {
    /* Kode Update Anda */
  }
  Future<void> deleteMovie(int index) async {
    /* Kode Delete Anda */
  }
}
