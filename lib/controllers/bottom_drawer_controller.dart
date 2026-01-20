import 'package:get/get.dart';

class BottomDrawerController extends GetxController {
  var isOpen = false.obs;
  var selectedIndex = 0.obs;

  void openDrawer() => isOpen.value = true;
  void closeDrawer() => isOpen.value = false;
  void toggleDrawer() => isOpen.value = !isOpen.value;

  void changePage(int index) {
    selectedIndex.value = index;
    closeDrawer();
  }
}
