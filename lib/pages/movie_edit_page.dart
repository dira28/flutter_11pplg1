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
                  controller: controller.titleController,
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
                  controller: controller.posterPathController,
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
                  controller: controller.overviewController,
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
                  controller: controller.voteAverageController,
                ),
                const SizedBox(height: 24),

                // Buttons
                Row(
                  children: [
                    // Cancel Button
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => Get.back(),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey[600],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                        ),
                        child: const Text(
                          "Cancel",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    // Save Button
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => controller.saveMovie(),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                        ),
                        child: const Text(
                          "Save",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.yellow,
                          ),
                        ),
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
