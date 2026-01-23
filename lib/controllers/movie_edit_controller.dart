import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'movie_controller.dart';

class MovieEditController extends GetxController {
  var title = ''.obs;
  var overview = ''.obs;
  var posterPath = ''.obs;
  var voteAverage = 0.0.obs;
  var releaseDate = ''.obs;

  // ✅ TextEditingController untuk binding
  late TextEditingController titleController;
  late TextEditingController overviewController;
  late TextEditingController posterPathController;
  late TextEditingController voteAverageController;

  int? editIndex;
  Map<String, dynamic>? editMovie;

  @override
  void onInit() {
    super.onInit();
    titleController = TextEditingController();
    overviewController = TextEditingController();
    posterPathController = TextEditingController();
    voteAverageController = TextEditingController();
  }

  @override
  void onClose() {
    titleController.dispose();
    overviewController.dispose();
    posterPathController.dispose();
    voteAverageController.dispose();
    super.onClose();
  }

  void setEditMovie({required int index, required Map<String, dynamic> movie}) {
    editIndex = index;
    editMovie = movie;

    title.value = movie['title'] ?? '';
    overview.value = movie['overview'] ?? '';
    posterPath.value = movie['poster_path'] ?? '';
    voteAverage.value = (movie['vote_average'] ?? 0).toDouble();
    releaseDate.value = movie['release_date'] ?? '';

    // ✅ Update TextEditingController
    titleController.text = title.value;
    overviewController.text = overview.value;
    posterPathController.text = posterPath.value;
    voteAverageController.text = voteAverage.value.toString();
  }

  void createMovie() {
    editIndex = null;
    editMovie = null;

    title.value = '';
    overview.value = '';
    posterPath.value = '';
    voteAverage.value = 0.0;
    releaseDate.value = '';

    // ✅ Clear TextEditingController
    titleController.clear();
    overviewController.clear();
    posterPathController.clear();
    voteAverageController.clear();
  }

  Future<void> saveMovie() async {
    // ✅ Update obs values dari TextEditingController
    title.value = titleController.text;
    overview.value = overviewController.text;
    posterPath.value = posterPathController.text;
    voteAverage.value = double.tryParse(voteAverageController.text) ?? 0.0;

    // ✅ Validasi input
    if (title.value.trim().isEmpty) {
      Get.snackbar(
        "Error",
        "Title tidak boleh kosong",
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(12),
        borderRadius: 10,
        backgroundColor: const Color(0xCCF44336),
        colorText: Colors.white,
        duration: const Duration(seconds: 2),
      );
      return;
    }

    if (overview.value.trim().isEmpty) {
      Get.snackbar(
        "Error",
        "Overview tidak boleh kosong",
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(12),
        borderRadius: 10,
        backgroundColor: const Color(0xCCF44336),
        colorText: Colors.white,
        duration: const Duration(seconds: 2),
      );
      return;
    }

    try {
      final movieController = Get.find<MovieController>();

      final movieData = {
        'title': title.value.trim(),
        'overview': overview.value.trim(),
        'poster_path': posterPath.value.trim(),
        'vote_average': voteAverage.value,
        'release_date': releaseDate.value.trim(),
      };

      if (editIndex != null && editMovie != null) {
        // update
        movieData['id'] = editMovie!['id'];
        movieData['source'] = 'firestore';
        movieController.updateMovie(editIndex!, movieData);
        
        // ✅ Show success message
        Get.snackbar(
          "Success ✅",
          "Movie berhasil diupdate",
          snackPosition: SnackPosition.BOTTOM,
          margin: const EdgeInsets.all(12),
          borderRadius: 10,
          backgroundColor: const Color(0xCC4CAF50),
          colorText: Colors.white,
          duration: const Duration(seconds: 2),
        );
      } else {
        // create
        movieController.addMovie(movieData);
        
        // ✅ Show success message
        Get.snackbar(
          "Success ✅",
          "Movie berhasil ditambahkan",
          snackPosition: SnackPosition.BOTTOM,
          margin: const EdgeInsets.all(12),
          borderRadius: 10,
          backgroundColor: const Color(0xCC4CAF50),
          colorText: Colors.white,
          duration: const Duration(seconds: 2),
        );
      }

      // ✅ Tunggu snackbar muncul dulu sebelum kembali
      await Future.delayed(const Duration(milliseconds: 500));
      Get.back(); // kembali ke halaman list
    } catch (e) {
      Get.snackbar(
        "Error",
        "Gagal menyimpan movie",
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(12),
        borderRadius: 10,
        backgroundColor: const Color(0xCCF44336),
        colorText: Colors.white,
        duration: const Duration(seconds: 2),
      );
    }
  }

  void deleteMovie() {
    if (editIndex != null) {
      final movieController = Get.find<MovieController>();
      movieController.deleteMovie(editIndex!);
      Get.back();
    }
  }
}
