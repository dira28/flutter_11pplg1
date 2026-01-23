import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:latihan1_11pplg1/controllers/bottom_drawer_controller.dart';
import 'package:latihan1_11pplg1/controllers/responsive_controller.dart';
import 'package:latihan1_11pplg1/fragments/bottom_drawer.dart';
import 'package:latihan1_11pplg1/pages/Cac_Page.dart';
import 'package:latihan1_11pplg1/pages/football_page.dart';
import 'package:latihan1_11pplg1/pages/movie_page.dart';
import 'package:latihan1_11pplg1/pages/profile_page.dart';

class MainPage extends StatelessWidget {
  MainPage({super.key});

  final BottomDrawerController drawerCtrl =
      Get.put(BottomDrawerController());
  final ResponsiveController responsiveCtrl = Get.put(ResponsiveController());

  final List<Widget> pages = [
    CalculatorPage(),
    FootballPage(), // ✅ Fix: ganti FootballEditPage jadi FootballPage
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        responsiveCtrl.updateLayout(constraints);
        
        return Obx(
          () {
            final isWidescreen = !responsiveCtrl.isMobile.value;
            
            return Scaffold(
              appBar: isWidescreen ? null : AppBar(
                backgroundColor: Colors.black,
                leading: IconButton(
                  icon: const Icon(Icons.menu, color: Colors.yellow),
                  onPressed: drawerCtrl.toggleDrawer,
                ),
              ),
              body: Stack(
                children: [
                  pages[drawerCtrl.selectedIndex.value],
                  // ✅ Drawer hanya untuk mobile
                  if (!isWidescreen) const BottomDrawerWidget(),
                ],
              ),
              // ✅ Bottom Navigation Bar untuk widescreen
              bottomNavigationBar: isWidescreen
                  ? Obx(
                      () => BottomNavigationBar(
                        currentIndex: drawerCtrl.selectedIndex.value,
                        onTap: (index) => drawerCtrl.changePage(index),
                        type: BottomNavigationBarType.fixed,
                        backgroundColor: Colors.black,
                        selectedItemColor: Colors.yellow,
                        unselectedItemColor: Colors.white70,
                        items: const [
                          BottomNavigationBarItem(
                            icon: Icon(Icons.calculate),
                            label: "Calculator",
                          ),
                          BottomNavigationBarItem(
                            icon: Icon(Icons.sports_soccer),
                            label: "Football",
                          ),
                          BottomNavigationBarItem(
                            icon: Icon(Icons.person),
                            label: "Profile",
                          ),
                          BottomNavigationBarItem(
                            icon: Icon(Icons.movie),
                            label: "Movies",
                          ),
                        ],
                      ),
                    )
                  : null,
            );
          },
        );
      },
    );
  }
}
