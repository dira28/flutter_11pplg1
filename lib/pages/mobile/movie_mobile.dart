import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:latihan1_11pplg1/controllers/movie_controller.dart';
import 'package:latihan1_11pplg1/controllers/movie_edit_controller.dart';
import 'package:latihan1_11pplg1/pages/movie_detail_page.dart';
import 'package:latihan1_11pplg1/pages/movie_edit_page.dart';

class MovieMobile extends StatelessWidget {
  MovieMobile({super.key});
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
              confirmDismiss: (_) => confirmDelete(context),

              // DELETE BACKGROUND
              background: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(right: 24),
                    color: Colors.red.shade600,
                    child: const Icon(
                      Icons.delete,
                      color: Colors.white,
                      size: 28,
                    ),
                  ),
                ),
              ),

              onDismissed: (_) {
                controller.deleteMovie(index);
                Get.snackbar(
                  "Success ✅",
                  "Movie berhasil dihapus",
                  snackPosition: SnackPosition.BOTTOM,
                  margin: const EdgeInsets.all(12),
                  borderRadius: 10,
                  backgroundColor: const Color(0xCC4CAF50),
                  colorText: Colors.white,
                  duration: const Duration(seconds: 2),
                );
              },

              child: Card(
                margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                clipBehavior: Clip.antiAlias,
                child: ListTile(
                  contentPadding: const EdgeInsets.all(12),

                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: SizedBox(
                      width: 55,
                      height: 80,
                      child: buildPoster(movie['poster_path']),
                    ),
                  ),

                  title: Text(
                    movie['title'] ?? "No Title",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),

                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 6),
                    child: Text(
                      "⭐ ${movie['vote_average']}\nRelease: ${movie['release_date'] ?? '-'}",
                    ),
                  ),

                  trailing: IconButton(
                    icon: const Icon(Icons.edit, color: Colors.blue),
                    onPressed: () {
                      editController.setEditMovie(index: index, movie: movie);
                      Get.to(() => const MovieEditPage());
                    },
                  ),

                  onTap: () {
                    Get.to(() => MovieDetailPage(movie: movie));
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
