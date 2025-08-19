import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:latihan1_11pplg1/controllers/main_controller.dart';
import 'package:latihan1_11pplg1/pages/Cac_Page.dart';
import 'package:latihan1_11pplg1/pages/football_page.dart';
import 'package:latihan1_11pplg1/pages/profile_page.dart';

class MainPage extends StatelessWidget {
  MainPage({super.key});

  final MainController nav = Get.put(MainController());

  final _pages = [CalculatorPage(), FootballPage(), const ProfilePage()];

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        body: IndexedStack(index: nav.currentIndex.value, children: _pages),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: nav.currentIndex.value,
          onTap: nav.changeTab,
          items: [
            BottomNavigationBarItem(
              icon: Image.asset("assets/calculator.png", height: 24),
              label: 'Kalkulator',
            ),
            BottomNavigationBarItem(
              icon: Image.asset("assets/football.png", height: 24),
              label: 'Football',
            ),
            BottomNavigationBarItem(
              icon: Image.asset("assets/account.png", height: 24),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
