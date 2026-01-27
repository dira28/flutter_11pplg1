import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/movie_edit_controller.dart';

class MovieEditPage extends StatelessWidget {
  const MovieEditPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MovieEditController());
    final isEdit = controller.editIndex != null;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(isEdit ? "Edit Movie" : "Add Movie"),
        backgroundColor: Colors.black,
        elevation: 1,
        centerTitle: true,
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Card(
          color: Colors.yellow,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title
                const Text(
                  "Title",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 6),
                TextField(
                  enabled: !isEdit, // readonly saat edit
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Enter movie title",
                  ),
                  controller: TextEditingController(
                    text: controller.title.value,
                  ),
                  onChanged: (val) => controller.title.value = val,
                ),
                const SizedBox(height: 16),

                // Poster URL
                const Text(
                  "Poster URL",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 6),
                TextField(
                  enabled: !isEdit, // readonly saat edit
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Enter poster URL",
                  ),
                  controller: TextEditingController(
                    text: controller.posterPath.value,
                  ),
                  onChanged: (val) => controller.posterPath.value = val,
                ),
                const SizedBox(height: 16),

                // Overview
                const Text(
                  "Overview",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 6),
                TextField(
                  maxLines: 5,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Enter movie overview",
                  ),
                  controller: TextEditingController(
                    text: controller.overview.value,
                  ),
                  onChanged: (val) => controller.overview.value = val,
                ),
                const SizedBox(height: 16),

                // Rating
                const Text(
                  "Rating",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 6),
                TextField(
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Enter movie rating",
                  ),
                  controller: TextEditingController(
                    text: controller.voteAverage.value.toString(),
                  ),
                  onChanged: (val) =>
                      controller.voteAverage.value = double.tryParse(val) ?? 0,
                ),
                const SizedBox(height: 24),

                // Buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Cancel
                    ElevatedButton(
                      onPressed: () => Get.back(),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                      ),
                      child: const Text(
                        "Cancel",
                        style: TextStyle(color: Colors.yellow),
                      ),
                    ),
                    // Save
                    ElevatedButton(
                      onPressed: () => controller.saveMovie(),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                      ),
                      child: const Text(
                        "Save",
                        style: TextStyle(color: Colors.yellow),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}