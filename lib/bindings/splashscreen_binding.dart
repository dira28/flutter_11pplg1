import 'package:get/get.dart';
import 'package:latihan1_11pplg1/controllers/splashscreen_controller.dart';

class SplashscreenBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<SplashscreenController>(() => SplashscreenController());
  }
}
