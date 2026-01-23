import 'package:get/get.dart';
import 'package:latihan1_11pplg1/controllers/movie_controller.dart';


class MovieBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MovieController>(() => MovieController());
  }
}
