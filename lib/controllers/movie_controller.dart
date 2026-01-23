import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';

class MovieController extends GetxController {
  var isLoading = false.obs;

  /// LIST MOVIE (API + FIRESTORE)
  var movies = <Map<String, dynamic>>[].obs;

  /// FIRESTORE
  final CollectionReference movieRef =
      FirebaseFirestore.instance.collection('movies');

  /// TMDB API (DARI CODE LAMA)
  final String apiUrl =
      "https://api.themoviedb.org/3/movie/now_playing?language=en-US&page=1";

  final String apiToken =
      "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIxNzJhYmJmMGJjNGJkYWI0NGVhMDg4MmI4ZmYxZmZkNyIsIm5iZiI6MTc2MjgyNjMzNS43NDUsInN1YiI6IjY5MTI5ODVmZjM4Y2JkYTQ1ZGMwNjY4NCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.LcCTBKuM9wnyF4-MeU0dH3esOpveHafTuA39CFlDHF8";

  @override
  void onInit() {
    super.onInit();
    loadMovies();
  }

  // ================== LOAD SEMUA DATA ==================
  Future<void> loadMovies() async {
    try {
      isLoading.value = true;
      movies.clear();

      await fetchMoviesFromAPI();       // API TMDB
      await fetchMoviesFromFirestore(); // FIRESTORE
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  // ================== TMDB API (ASLI DARI CODE LAMA) ==================
  Future<void> fetchMoviesFromAPI() async {
    try {
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {
          'Authorization': 'Bearer $apiToken',
          'accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        final List apiMovies =
            List<Map<String, dynamic>>.from(data['results']);

        // tandai sumber API (PENTING)
        for (var movie in apiMovies) {
          movie['source'] = 'api';
        }

        movies.addAll(apiMovies.cast<Map<String, dynamic>>());
      } else {
        Get.snackbar(
          "API Error",
          "Gagal memuat movie (${response.statusCode})",
        );
      }
    } catch (e) {
      Get.snackbar("API Error", e.toString());
    }
  }

  // ================== FIRESTORE ==================
  Future<void> fetchMoviesFromFirestore() async {
    final snapshot = await movieRef.get();

    final firestoreMovies = snapshot.docs.map((doc) {
      final data = doc.data() as Map<String, dynamic>;
      data['id'] = doc.id;
      data['source'] = 'firestore';
      return data;
    }).toList();

    movies.addAll(firestoreMovies);
  }

  // ================== CRUD FIRESTORE (DIPAKAI MovieEditController) ==================
  Future<void> addMovie(Map<String, dynamic> movie) async {
    await movieRef.add(movie);
    await loadMovies();
  }

  Future<void> updateMovie(int index, Map<String, dynamic> movie) async {
    if (movie['source'] != 'firestore') return;

    final id = movie['id'];
    await movieRef.doc(id).update(movie);
    await loadMovies();
  }

  Future<void> deleteMovie(int index) async {
    final movie = movies[index];

    if (movie['source'] != 'firestore') return;

    await movieRef.doc(movie['id']).delete();
    await loadMovies();
  }
}