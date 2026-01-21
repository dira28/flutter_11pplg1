import 'package:get/route_manager.dart';
import 'package:latihan1_11pplg1/bindings/buyticket_binding.dart';
import 'package:latihan1_11pplg1/bindings/calculator_binding.dart';
import 'package:latihan1_11pplg1/bindings/contact_binding.dart';
import 'package:latihan1_11pplg1/bindings/football_binding.dart';
import 'package:latihan1_11pplg1/bindings/football_edit_binding.dart';
import 'package:latihan1_11pplg1/bindings/login_api_binding.dart';
import 'package:latihan1_11pplg1/bindings/login_football_binding.dart';
import 'package:latihan1_11pplg1/bindings/movie_binding.dart';
import 'package:latihan1_11pplg1/bindings/movie_edit_binding';
import 'package:latihan1_11pplg1/bindings/premiere_binding.dart';
import 'package:latihan1_11pplg1/bindings/splashscreen_binding.dart';
import 'package:latihan1_11pplg1/bindings/login_binding.dart';
import 'package:latihan1_11pplg1/pages/Cac_Page.dart';
import 'package:latihan1_11pplg1/pages/buyticket.dart';
import 'package:latihan1_11pplg1/pages/card_product.dart';
import 'package:latihan1_11pplg1/pages/contact_page.dart';
import 'package:latihan1_11pplg1/pages/football_edit_page.dart';
import 'package:latihan1_11pplg1/pages/football_page.dart';
import 'package:latihan1_11pplg1/pages/login_api_page.dart';
import 'package:latihan1_11pplg1/pages/login_football_page.dart';
import 'package:latihan1_11pplg1/pages/login_page.dart';
import 'package:latihan1_11pplg1/pages/movie_edit_page.dart';
import 'package:latihan1_11pplg1/pages/movie_page.dart';
import 'package:latihan1_11pplg1/pages/premiere_table.dart';
import 'package:latihan1_11pplg1/pages/profile_page.dart';
import 'package:latihan1_11pplg1/pages/splashscreen_page.dart';
import 'package:latihan1_11pplg1/routes/routes.dart';
import 'package:latihan1_11pplg1/pages/main_page.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: AppRoutes.calculator,
      page: () => CalculatorPage(),
      binding: CalculatorBinding(),
    ),
    GetPage(
      name: AppRoutes.footballplayers,
      page: () => FootballPage(),
      binding: FootballBinding(),
    ),
    GetPage(
      name: AppRoutes.footballeditplayers,
      page: () => FootballEditPage(),
      binding: FootballEditBinding(),
    ),
    GetPage(name: AppRoutes.profile, page: () => ProfilePage()),
    GetPage(name: AppRoutes.mainpage, page: () => MainPage()),
    GetPage(
      name: AppRoutes.splashScreen,
      page: () => SplashScreen(),
      binding: SplashscreenBinding(),
    ),
    GetPage(
      name: AppRoutes.loginpagenew,
      page: () => LoginPageNew(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: AppRoutes.contact,
      page: () => ContactPage(),
      binding: ContactBinding(),
    ),
    GetPage(
      name: AppRoutes.loginapi,
      page: () => LoginApiPage(),
      binding: LoginApiBinding(),
    ),
    GetPage(
      name: AppRoutes.loginfootball,
      page: () => LoginFootballPage(),
      binding: LoginFootballBinding(),
    ),
    GetPage(
      name: AppRoutes.premieretable,
      page: () => PremiereTable(),
      binding: PremiereBinding(),
    ),
    GetPage(
      name: AppRoutes.movielist,
      page: () => MoviePage(),
      binding: MovieBinding(),
    ),
    GetPage(name: AppRoutes.cardproduct, page: () => CardProduct()),
    GetPage(
      name: '/movie-edit',
      page: () => const MovieEditPage(),
      binding: MovieEditBinding(),
    ),
     GetPage(
      name: AppRoutes.buyticket,
      page: () =>  BuyTicketPage(),
      binding: BuyTicketBinding(),
    ),
  ];
}
