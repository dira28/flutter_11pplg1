import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:latihan1_11pplg1/pages/buyticket.dart';
import '../controllers/bottom_drawer_controller.dart';
import '../fragments/bottom_drawer.dart';
import 'Cac_Page.dart';
import 'football_page.dart';
import 'profile_page.dart';
import 'movie_page.dart';

class MainPage extends StatelessWidget {
  MainPage({super.key});

  final BottomDrawerController drawerCtrl = Get.put(BottomDrawerController());

  final List<Widget> pages = [
    CalculatorPage(),
    FootballPage(),
    MoviePage(),
    BuyTicketPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Stack(
        children: [
          Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.black,
              elevation: 0,
              leading: IconButton(
                icon: const Icon(Icons.menu, color: Colors.yellow),
                onPressed: () => drawerCtrl.toggleDrawer(),
              ),
            ),
            body: pages[drawerCtrl.selectedIndex.value],
          ),
          const BottomDrawerWidget(),
        ],
      ),
    );
  }
}
