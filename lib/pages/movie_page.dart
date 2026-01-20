import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/movie_controller.dart';
import '../controllers/movie_edit_controller.dart';
import 'movie_edit_page.dart';

class MoviePage extends StatelessWidget {
  const MoviePage({super.key});

  /// Build poster image
  Widget buildPoster(String? poster) {
    if (poster == null || poster.isEmpty)
      return const Icon(Icons.movie, size: 50);

    return Image.network(
      'https://image.tmdb.org/t/p/w500$poster',
      width: 60,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) =>
          const Icon(Icons.broken_image, size: 50),
    );
  }

  /// Dialog konfirmasi delete
  Future<bool?> confirmDelete(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Konfirmasi Hapus"),
        content: const Text("Apakah kamu yakin ingin menghapus movie ini?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text("Batal"),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text("Hapus", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MovieController());
    final editController = Get.put(MovieEditController());

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Now Playing Movies",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 1,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.movies.isEmpty) {
          return const Center(child: Text("Gagal memuat data film 😢"));
        }

        return ListView.builder(
          itemCount: controller.movies.length,
          itemBuilder: (context, index) {
            final movie = controller.movies[index];

            return Dismissible(
              key: ValueKey(movie['id']),
              direction: DismissDirection.endToStart,
              background: Container(
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                color: Colors.red,
                child: const Icon(Icons.delete, color: Colors.white),
              ),
              confirmDismiss: (direction) async {
                final confirmed = await confirmDelete(context);
                return confirmed ?? false;
              },
              onDismissed: (direction) {
                controller.deleteMovie(index);
                Get.snackbar(
                  "Berhasil",
                  "Movie berhasil dihapus",
                  snackPosition: SnackPosition.BOTTOM,
                );
              },
              child: Card(
                margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListTile(
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: buildPoster(movie['poster_path']),
                  ),
                  title: Text(movie['title'] ?? "No Title"),
                  subtitle: Text(
                    "Rating: ${movie['vote_average']} ⭐\nRelease: ${movie['release_date'] ?? '-'}",
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.edit, color: Colors.blue),
                    onPressed: () {
                      editController.setEditMovie(index: index, movie: movie);
                      Get.to(() => const MovieEditPage());
                    },
                  ),
                  onTap: () {
                    // Bisa ditambahkan untuk buka halaman detail kalau mau
                  },
                ),
              ),
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          editController.createMovie(); // mode add baru
          Get.to(() => const MovieEditPage());
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
