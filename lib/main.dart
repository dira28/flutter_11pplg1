import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:latihan1_11pplg1/login_page.dart';
import 'package:latihan1_11pplg1/pages/Cac_Page.dart';
import 'package:latihan1_11pplg1/routes/pages.dart';
import 'package:latihan1_11pplg1/routes/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: AppRoutes.calculator,
      getPages: AppPages.pages,
    );
  }
}
