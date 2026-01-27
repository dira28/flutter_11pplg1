import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:latihan1_11pplg1/controllers/movie_controller.dart';
import 'package:latihan1_11pplg1/controllers/movie_edit_controller.dart';
import 'package:latihan1_11pplg1/pages/movie_detail_page.dart';
import 'package:latihan1_11pplg1/pages/movie_edit_page.dart';

class MovieWidescreen extends StatelessWidget {
  MovieWidescreen({super.key});

  Widget buildPoster(String? poster) {
    if (poster == null || poster.isEmpty) {
      return const Icon(Icons.movie, size: 60);
    }

    return Image.network(
      'https://image.tmdb.org/t/p/w500$poster',
      fit: BoxFit.cover,
      errorBuilder: (_, __, ___) =>
          const Icon(Icons.broken_image, size: 60),
    );
  }

  Future<bool?> confirmDelete(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Konfirmasi Hapus"),
        content: const Text("Yakin ingin menghapus movie ini?"),
        actions: [
          TextButton(
            onPressed: () => Get.back(result: false),
            child: const Text("Batal"),
          ),
          TextButton(
            onPressed: () => Get.back(result: true),
            child: const Text(
              "Hapus",
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // ✅ Pastikan controller sudah terdaftar (dengan fallback ke put jika belum ada)
    final MovieController controller = Get.put(MovieController());
    final MovieEditController editController = Get.put(MovieEditController());
    
    return Scaffold(
      backgroundColor: Colors.grey.shade100,

      appBar: AppBar(
        title: const Text(
          "Now Playing Movies",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 1,
        centerTitle: true,
      ),

      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.movies.isEmpty) {
          return const Center(
            child: Text("Gagal memuat data film 😢"),
          );
        }

        return Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1200),
            child: GridView.builder(
              padding: const EdgeInsets.all(24),
              itemCount: controller.movies.length,
              gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
                childAspectRatio: 0.75,
              ),
              itemBuilder: (context, index) {
                final movie = controller.movies[index];

                return Dismissible(
                  key: ValueKey(movie['id']),
                  direction: DismissDirection.endToStart,
                  confirmDismiss: (_) => confirmDelete(context),

                  background: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.only(right: 24),
                      color: Colors.red.shade600,
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.delete,
                              color: Colors.white, size: 28),
                          SizedBox(height: 6),
                          Text(
                            "Delete",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
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
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: InkWell(
                      onTap: () {
                        Get.to(() => MovieDetailPage(movie: movie));
                      },
                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.stretch,
                        children: [
                          Expanded(
                            child:
                                buildPoster(movie['poster_path']),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              crossAxisAlignment:
                                  CrossAxisAlignment.start,
                              children: [
                                Text(
                                  movie['title'] ?? "No Title",
                                  maxLines: 2,
                                  overflow:
                                      TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  "⭐ ${movie['vote_average']}",
                                ),
                                const SizedBox(height: 6),
                                Align(
                                  alignment:
                                      Alignment.centerRight,
                                  child: IconButton(
                                    icon: const Icon(
                                      Icons.edit,
                                      color: Colors.blue,
                                    ),
                                    onPressed: () {
                                      editController
                                          .setEditMovie(
                                        index: index,
                                        movie: movie,
                                      );
                                      Get.toNamed('/movie-edit');
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        );
      }),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          editController.createMovie();
          Get.to(() => const MovieEditPage());
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}