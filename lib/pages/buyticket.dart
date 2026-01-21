import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/movie_controller.dart';

class BuyTicketPage extends StatefulWidget {
  @override
  State<BuyTicketPage> createState() => _BuyTicketPageState();
}

class _BuyTicketPageState extends State<BuyTicketPage> {
  final MovieController controller = Get.find<MovieController>();

  Map<String, dynamic>? selectedMovie;
  final TextEditingController qtyController =
      TextEditingController(text: "1");

  int hargaPerTiket = 50000;
  int totalHarga = 0;

  void hitungTotal() {
    final qty = int.tryParse(qtyController.text) ?? 0;
    setState(() {
      totalHarga = qty * hargaPerTiket;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Beli Tiket")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Obx(() => DropdownButtonFormField<Map<String, dynamic>>(
                  decoration:
                      const InputDecoration(border: OutlineInputBorder()),
                  value: selectedMovie,
                  items: controller.movies.map((movie) {
                    return DropdownMenuItem(
                      value: movie,
                      child: Text(movie['title']),
                    );
                  }).toList(),
                  onChanged: (val) {
                    setState(() => selectedMovie = val);
                    hitungTotal();
                  },
                )),
            const SizedBox(height: 16),
            TextField(
              controller: qtyController,
              keyboardType: TextInputType.number,
              onChanged: (_) => hitungTotal(),
              decoration:
                  const InputDecoration(border: OutlineInputBorder()),
            ),
            const SizedBox(height: 24),
            Text(
              "Total: Rp $totalHarga",
              style:
                  const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: selectedMovie == null || totalHarga == 0
                    ? null
                    : () {
                        controller.checkoutMovie(
                          title: selectedMovie!['title'],
                          amount: totalHarga,
                        );
                      },
                child: const Text(
                  "BAYAR SEKARANG",
                  style: TextStyle(fontSize: 18),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
