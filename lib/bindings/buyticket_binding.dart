import 'package:get/get.dart';
import '../controllers/movie_controller.dart';

class BuyTicketBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MovieController>(() => MovieController());
  }
}
