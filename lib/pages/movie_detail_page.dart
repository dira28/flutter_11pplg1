import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/buy_controller.dart';

class MovieDetailPage extends StatelessWidget {
  final Map<String, dynamic> movie;

  MovieDetailPage({super.key, required this.movie});

  final BuyController buyController = Get.put(BuyController());

  final int hargaPerTiket = 50000;

  void _showBuyDialog(BuildContext context) {
    final RxInt qty = 1.obs;
    final RxInt total = hargaPerTiket.obs;

    void hitungTotal() {
      total.value = qty.value * hargaPerTiket;
    }

    Get.dialog(
      AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text("Beli Tiket"),
        content: Obx(
          () => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              /// JUDUL FILM
              Text(
                movie['title'] ?? '-',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 16),

              /// JUMLAH TIKET
              const Text("Jumlah Tiket"),
              const SizedBox(height: 8),

              Row(
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
                  SizedBox(
                    width: 40,
                    child: Center(
                      child: Text(
                        qty.value.toString(),
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
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
              ),

              const SizedBox(height: 16),

              /// TOTAL
              Text(
                "Total: Rp ${total.value}",
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text("Batal"),
          ),
          Obx(
            () => ElevatedButton(
              onPressed: buyController.isPaying.value
                  ? null
                  : () {
                      Get.back();
                      buyController.checkout(
                        title: movie['title'],
                        amount: total.value,
                      );
                    },
              child: buyController.isPaying.value
                  ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                  : const Text("Bayar"),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final posterPath = movie['poster_path'];
    final posterUrl = (posterPath != null && posterPath.isNotEmpty)
        ? 'https://image.tmdb.org/t/p/w500$posterPath'
        : null;

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text(
          movie['title'] ?? 'Detail Movie',
          overflow: TextOverflow.ellipsis,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 16),

            /// POSTER
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: posterUrl != null
                    ? Image.network(
                        posterUrl,
                        height: 450,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) =>
                            const Icon(Icons.broken_image, size: 120),
                      )
                    : const Icon(Icons.movie, size: 120),
              ),
            ),

            const SizedBox(height: 16),

            /// DETAIL CARD
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        movie['title'] ?? '-',
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Icon(Icons.star,
                              color: Colors.amber, size: 20),
                          const SizedBox(width: 4),
                          Text("${movie['vote_average'] ?? '-'}"),
                          const SizedBox(width: 16),
                          const Icon(Icons.calendar_today, size: 18),
                          const SizedBox(width: 4),
                          Text(movie['release_date'] ?? '-'),
                        ],
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        "Deskripsi",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        movie['overview'] ?? 'Tidak ada deskripsi',
                        textAlign: TextAlign.justify,
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 24),

            /// BUTTON BELI
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () => _showBuyDialog(context),
                  child: const Text(
                    "Beli Tiket",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
