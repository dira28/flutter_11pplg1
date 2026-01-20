import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:latihan1_11pplg1/controllers/notification_controller.dart';
import 'package:latihan1_11pplg1/controllers/login_football_controller.dart';
import 'package:latihan1_11pplg1/routes/pages.dart';
import 'package:latihan1_11pplg1/routes/routes.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  Get.put(LoginFootballController());
  Get.put(NotificationController());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.cyan),
        useMaterial3: true,
      ),
      initialRoute: AppRoutes.splashScreen,
      getPages: AppPages.pages,
    );
  }
}
