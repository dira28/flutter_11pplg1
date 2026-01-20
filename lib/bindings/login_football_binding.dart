import 'package:get/get.dart';
import '../controllers/login_football_controller.dart';

class LoginFootballBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginFootballController>(() => LoginFootballController());
  }
}
