import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/movie_controller.dart';

class MoviePage extends StatelessWidget {
  const MoviePage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MovieController());

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
            final poster = movie['poster_path'];

            return Card(
              margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListTile(
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    'https://image.tmdb.org/t/p/w500$poster',
                    width: 60,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                        const Icon(Icons.broken_image, size: 40),
                  ),
                ),
                title: Text(movie['title'] ?? "No Title"),
                subtitle: Text(
                  "Rating: ${movie['vote_average']} ⭐\nRelease: ${movie['release_date']}",
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
