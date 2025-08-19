import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:latihan1_11pplg1/routes/pages.dart';
import 'package:latihan1_11pplg1/routes/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Latihan GetX',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.cyan),
        useMaterial3: true,
      ),
      initialRoute: AppRoutes.calculator,
      getPages: AppPages.pages,
    );
  }
}
