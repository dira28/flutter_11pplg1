import 'package:get/get.dart';
import 'package:latihan1_11pplg1/controllers/movie_edit_controller.dart';


class MovieEditBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MovieEditController>(() => MovieEditController());
  }
}
