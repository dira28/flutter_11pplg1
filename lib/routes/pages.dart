import 'package:get/route_manager.dart';
import 'package:latihan1_11pplg1/pages/Cac_Page.dart';
import 'package:latihan1_11pplg1/pages/football_edit_page.dart';
import 'package:latihan1_11pplg1/pages/football_page.dart';
import 'package:latihan1_11pplg1/pages/profile_page.dart';
import 'package:latihan1_11pplg1/routes/routes.dart';

class AppPages {
  static final pages = [
    GetPage(name: AppRoutes.calculator, page: () => CalculatorPage()),
    GetPage(name: AppRoutes.footballplayers, page: () => FootballPage()),
    GetPage(
      name: AppRoutes.footballeditplayers,
      page: () => FootballEditPage(),
    ),
    GetPage(name: AppRoutes.profile, page: () => ProfilePage()),
  ];
}
