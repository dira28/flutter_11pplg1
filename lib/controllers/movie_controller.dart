import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class MovieController extends GetxController {
  var isLoading = false.obs;
  var movies = [].obs;

  // URL dan Token langsung di sini
  final String url =
      "https://api.themoviedb.org/3/movie/now_playing?language=en-US&page=1";
  final String token =
      "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIxNzJhYmJmMGJjNGJkYWI0NGVhMDg4MmI4ZmYxZmZkNyIsIm5iZiI6MTc2MjgyNjMzNS43NDUsInN1YiI6IjY5MTI5ODVmZjM4Y2JkYTQ1ZGMwNjY4NCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.LcCTBKuM9wnyF4-MeU0dH3esOpveHafTuA39CFlDHF8";

  @override
  void onInit() {
    super.onInit();
    fetchMovies();
  }

  Future<void> fetchMovies() async {
    try {
      isLoading.value = true;

      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $token',
          'accept': 'application/json',
        },
      );

      print("STATUS CODE: ${response.statusCode}");

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        movies.value = data['results'];
      } else {
        Get.snackbar("Error", "Gagal memuat data (${response.statusCode})");
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
