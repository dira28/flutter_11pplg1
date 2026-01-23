import 'package:get/get.dart';
  
class BottomDrawerController extends GetxController {
  final selectedIndex = 0.obs;
  final isDrawerOpen = false.obs;

  void changePage(int index) {
    selectedIndex.value = index;
    isDrawerOpen.value = false;
  }

  void toggleDrawer() {
    isDrawerOpen.toggle();
  }

  void closeDrawer() {
    isDrawerOpen.value = false;
  }
}

