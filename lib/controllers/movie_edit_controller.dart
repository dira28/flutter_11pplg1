import 'package:get/get.dart';
import 'movie_controller.dart';

class MovieEditController extends GetxController {
  var title = ''.obs;
  var overview = ''.obs;
  var posterPath = ''.obs;
  var voteAverage = 0.0.obs;
  var releaseDate = ''.obs;

  int? editIndex;
  Map<String, dynamic>? editMovie;

  void setEditMovie({required int index, required Map<String, dynamic> movie}) {
    editIndex = index;
    editMovie = movie;

    title.value = movie['title'] ?? '';
    overview.value = movie['overview'] ?? '';
    posterPath.value = movie['poster_path'] ?? '';
    voteAverage.value = (movie['vote_average'] ?? 0).toDouble();
    releaseDate.value = movie['release_date'] ?? '';
  }

  void createMovie() {
    editIndex = null;
    editMovie = null;

    title.value = '';
    overview.value = '';
    posterPath.value = '';
    voteAverage.value = 0.0;
    releaseDate.value = '';
  }

  void saveMovie() {
    final movieController = Get.find<MovieController>();

    final movieData = {
      'title': title.value,
      'overview': overview.value,
      'poster_path': posterPath.value,
      'vote_average': voteAverage.value,
      'release_date': releaseDate.value,
    };

    if (editIndex != null && editMovie != null) {
      // update
      movieData['id'] = editMovie!['id'];
      movieData['source'] = 'firestore';
      movieController.updateMovie(editIndex!, movieData);
    } else {
      // create
      movieController.addMovie(movieData);
    }

    Get.back(); // kembali ke halaman list
  }

  void deleteMovie() {
    if (editIndex != null) {
      final movieController = Get.find<MovieController>();
      movieController.deleteMovie(editIndex!);
      Get.back();
    }
  }
}