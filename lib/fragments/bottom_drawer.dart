import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/bottom_drawer_controller.dart';

class BottomDrawerWidget extends StatelessWidget {
  const BottomDrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final drawerCtrl = Get.find<BottomDrawerController>();

    return Obx(
      () => AnimatedPositioned(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        top: 0,
        bottom: 0,
        left: drawerCtrl.isDrawerOpen.value ? 0 : -270,
        width: 270,
        child: Material(
          elevation: 16,
          borderRadius: const BorderRadius.horizontal(
            right: Radius.circular(24),
          ),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.horizontal(
                right: Radius.circular(24),
              ),
            ),
            padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Close button
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    icon: const Icon(
                      Icons.close,
                      size: 30,
                      color: Colors.black,
                    ),
                    onPressed: () => drawerCtrl.closeDrawer(),
                  ),
                ),
                const SizedBox(height: 20),

                // Menu items
                drawerItem(Icons.calculate, "Kalkulator", 0, drawerCtrl),
                drawerItem(Icons.sports_soccer, "Football", 1, drawerCtrl),
                drawerItem(Icons.person, "Profile", 2, drawerCtrl),
                drawerItem(Icons.movie, "Movies", 3, drawerCtrl),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget drawerItem(
    IconData icon,
    String title,
    int index,
    BottomDrawerController ctrl,
  ) {
    bool selected = ctrl.selectedIndex.value == index;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: InkWell(
        onTap: () => ctrl.changePage(index),
        borderRadius: BorderRadius.circular(12),
        child: Container(
          decoration: selected
              ? BoxDecoration(
                  color: Colors.yellow[700],
                  borderRadius: BorderRadius.circular(12),
                )
              : null,
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
          child: Row(
            children: [
              Icon(
                icon,
                size: 30,
                color: selected ? Colors.white : Colors.black,
              ),
              const SizedBox(width: 16),
              Text(
                title,
                style: TextStyle(
                  color: selected ? Colors.white : Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
