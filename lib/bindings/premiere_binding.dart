import 'package:get/get.dart';
import 'package:latihan1_11pplg1/controllers/premiere_controller.dart';

class PremiereBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put<PremierTableController>(PremierTableController());
  }
}
