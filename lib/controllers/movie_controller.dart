import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';

class MovieController extends GetxController {
  var isLoading = false.obs;
  var movies = <Map<String, dynamic>>[].obs;
  var isMobile = true.obs;

  final movieRef = FirebaseFirestore.instance.collection('movies');

  // ================= TMDB API v4 =================
  final String url =
      "https://api.themoviedb.org/3/movie/now_playing?language=en-US&page=1";
  final String token =
      "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIxNzJhYmJmMGJjNGJkYWI0NGVhMDg4MmI4ZmYxZmZkNyIsIm5iZiI6MTc2MjgyNjMzNS43NDUsInN1YiI6IjY5MTI5ODVmZjM4Y2JkYTQ1ZGMwNjY4NCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.LcCTBKuM9wnyF4-MeU0dH3esOpveHafTuA39CFlDHF8";

  @override
  void onInit() {
    super.onInit();
    loadMovies();
  }

  /// ================= LOAD & MERGE =================
  Future<void> loadMovies() async {
    isLoading.value = true;
    movies.clear();
    await fetchMoviesFromAPI();
    await fetchMoviesFromFirestore();
    isLoading.value = false;
  }

  /// ================= FETCH TMDB API v4 =================
  Future<void> fetchMoviesFromAPI() async {
    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $token',
          'accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final apiMovies = List<Map<String, dynamic>>.from(data['results']);

        final formatted = apiMovies.map((e) {
          return {
            'id': e['id'].toString(),
            'title': e['title'],
            'overview': e['overview'],
            'poster_path': e['poster_path'],
            'vote_average': e['vote_average'],
            'release_date': e['release_date'],
            'source': 'api',
          };
        }).toList();

        movies.addAll(formatted);
      } else {
        Get.snackbar(
          "Error",
          "Gagal memuat data dari API",
          snackPosition: SnackPosition.BOTTOM,
          margin: const EdgeInsets.all(12),
          borderRadius: 10,
          backgroundColor: const Color(0xCCF44336),
          colorText: Colors.white,
          duration: const Duration(seconds: 2),
        );
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        "Terjadi kesalahan saat memuat data",
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(12),
        borderRadius: 10,
        backgroundColor: const Color(0xCCF44336),
        colorText: Colors.white,
        duration: const Duration(seconds: 2),
      );
    }
  }

  /// ================= FETCH FIRESTORE =================
  Future<void> fetchMoviesFromFirestore() async {
    try {
      final snapshot = await movieRef
          .orderBy('created_at', descending: true)
          .get();
      final firestoreMovies = snapshot.docs.map((doc) {
        final data = doc.data();
        data['id'] = doc.id;
        data['source'] = 'firestore';
        return data;
      }).toList();
      movies.addAll(firestoreMovies);
    } catch (e) {
      Get.snackbar(
        "Error",
        "Gagal memuat data dari Firestore",
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(12),
        borderRadius: 10,
        backgroundColor: const Color(0xCCF44336),
        colorText: Colors.white,
        duration: const Duration(seconds: 2),
      );
    }
  }

  /// ================= CREATE =================
  Future<void> addMovie(Map<String, dynamic> movie) async {
    try {
      final docRef = await movieRef.add({
        'title': movie['title'],
        'overview': movie['overview'],
        'poster_path': movie['poster_path'],
        'vote_average': movie['vote_average'] ?? 0,
        'release_date': movie['release_date'] ?? '',
        'created_at': DateTime.now(),
      });

      movie['id'] = docRef.id;
      movie['source'] = 'firestore';
      movies.insert(0, movie);
      
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
    } catch (e) {
      Get.snackbar(
        "Error",
        "Gagal menambahkan movie",
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(12),
        borderRadius: 10,
        backgroundColor: const Color(0xCCF44336),
        colorText: Colors.white,
        duration: const Duration(seconds: 2),
      );
    }
  }

  /// ================= UPDATE =================
  Future<void> updateMovie(int index, Map<String, dynamic> movie) async {
    try {
      if (movie['source'] == 'firestore') {
        await movieRef.doc(movie['id']).update({
          'title': movie['title'],
          'overview': movie['overview'],
          'poster_path': movie['poster_path'],
          'vote_average': movie['vote_average'],
          'release_date': movie['release_date'],
        });
      }
      movies[index] = movie;
      movies.refresh();
      
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
    } catch (e) {
      Get.snackbar(
        "Error",
        "Gagal mengupdate movie",
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(12),
        borderRadius: 10,
        backgroundColor: const Color(0xCCF44336),
        colorText: Colors.white,
        duration: const Duration(seconds: 2),
      );
    }
  }

  /// ================= DELETE =================
  Future<void> deleteMovie(int index) async {
    try {
      final movie = movies[index];
      if (movie['source'] == 'firestore') {
        await movieRef.doc(movie['id']).delete();
      }
      movies.removeAt(index);
    } catch (e) {
      Get.snackbar(
        "Error",
        "Gagal menghapus movie",
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(12),
        borderRadius: 10,
        backgroundColor: const Color(0xCCF44336),
        colorText: Colors.white,
        duration: const Duration(seconds: 2),
      );
    }
  }
  void updatelayout(BoxConstraints constraints) {
    isMobile.value = constraints.maxWidth < 600;
  }
}
