import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:latihan1_11pplg1/widgets/costum_button.dart';
import 'package:latihan1_11pplg1/widgets/costum_dropdown.dart';
import '../controllers/movie_controller.dart';
import '../controllers/buy_controller.dart';


class BuyTicketPage extends StatelessWidget {
  BuyTicketPage({super.key});

  final MovieController movieController = Get.put(MovieController());
  final BuyController buyController = Get.put(BuyController());

  final Rx<Map<String, dynamic>?> selectedMovie = Rx<Map<String, dynamic>?>(null);
  final RxInt qty = 1.obs;
  final int hargaPerTiket = 50000;
  final RxInt totalHarga = 0.obs;

  void hitungTotal() {
    totalHarga.value = qty.value * hargaPerTiket;
  }

  @override
  Widget build(BuildContext context) {
    hitungTotal(); // Inisialisasi awal

    return Scaffold(
      appBar: AppBar(title: const Text("Beli Tiket")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            
            /// ===== PENGGUNAAN DROPDOWN CUSTOM =====
            Obx(() => CustomDropdown<Map<String, dynamic>>(
                  label: "Pilih Film",
                  value: selectedMovie.value,
                  items: movieController.movies,
                  // Beritahu dropdown cara menampilkan data (ambil key 'title')
                  itemLabelBuilder: (movie) => movie['title'] ?? '-', 
                  onChanged: (val) {
                    selectedMovie.value = val;
                    qty.value = 1; // Reset qty saat ganti film
                    hitungTotal();
                  },
                )),

            const SizedBox(height: 16),

            /// ===== POSTER FILM (Tetap di sini atau bisa dipisah juga) =====
            _buildPosterSection(),

            const SizedBox(height: 20),

            /// ===== JUMLAH TIKET =====
            const Text(
              "Jumlah Tiket",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            _buildQtyControl(), // Saya pisah ke method bawah agar rapi

            const SizedBox(height: 24),

            /// ===== TOTAL =====
            Obx(() => Text(
                  "Total: Rp ${totalHarga.value}",
                  style: const TextStyle(
                    fontSize: 22, 
                    fontWeight: FontWeight.bold
                  ),
                )),

            const SizedBox(height: 32),

            /// ===== PENGGUNAAN BUTTON CUSTOM =====
            Obx(() => reusableButton(
                  text: "BAYAR SEKARANG",
                  isLoading: buyController.isPaying.value,
                  // Logic validasi disable button ada di sini
                  onPressed: selectedMovie.value == null 
                      ? null 
                      : () {
                          buyController.checkout(
                            title: selectedMovie.value!['title'],
                            amount: totalHarga.value,
                          );
                        },
                )),

            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  // --- Widget helper untuk merapikan kode utama ---

  Widget _buildPosterSection() {
    return Obx(() {
      if (selectedMovie.value == null) {
        return Container(
          height: 300,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Center(child: Text("Poster film akan muncul di sini")),
        );
      }

      final posterPath = selectedMovie.value!['poster_path'];
      return ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: posterPath != null && posterPath.isNotEmpty
            ? Image.network(
                "https://image.tmdb.org/t/p/w500$posterPath",
                height: 300,
                width: double.infinity,
                fit: BoxFit.cover,
              )
            : Container(
                height: 300,
                color: Colors.grey.shade300,
                child: const Center(child: Text("Poster tidak tersedia")),
              ),
      );
    });
  }

  Widget _buildQtyControl() {
    return Obx(() => Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: const Icon(Icons.remove_circle_outline),
              iconSize: 32,
              onPressed: qty.value > 1
                  ? () {
                      qty.value--;
                      hitungTotal();
                    }
                  : null,
            ),
            Container(
              width: 60,
              alignment: Alignment.center,
              child: Text(
                qty.value.toString(),
                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.add_circle_outline),
              iconSize: 32,
              onPressed: () {
                qty.value++;
                hitungTotal();
              },
            ),
          ],
        ));
  }
}