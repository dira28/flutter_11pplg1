import 'package:get/get.dart';
import 'package:latihan1_11pplg1/controllers/football_controller.dart';

class FootballBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut<FootballController>(() => FootballController());
  }
}
