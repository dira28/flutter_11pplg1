import 'package:get/get.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationController extends GetxController {
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _localNotif =
      FlutterLocalNotificationsPlugin();

  @override
  void onInit() {
    super.onInit();
    _initLocalNotif();
    _initFCM();
  }

  void _initLocalNotif() async {
    const androidInit = AndroidInitializationSettings('@mipmap/ic_launcher');

    const initSettings = InitializationSettings(android: androidInit);

    await _localNotif.initialize(initSettings);
  }

  Future<void> _initFCM() async {
    await _messaging.requestPermission(alert: true, badge: true, sound: true);

    final token = await _messaging.getToken();
    print("🔥 FCM TOKEN: $token");

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      _showNotification(
        title: message.notification?.title ?? 'Notifikasi',
        body: message.notification?.body ?? '',
      );
    });

    /// 🔔 BACKGROUND CLICK
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      // optional (tidak print apa-apa)
    });
  }

  Future<void> _showNotification({
    required String title,
    required String body,
  }) async {
    const androidDetails = AndroidNotificationDetails(
      'default_channel',
      'Default Notification',
      importance: Importance.max,
      priority: Priority.high,
    );

    const notifDetails = NotificationDetails(android: androidDetails);

    await _localNotif.show(0, title, body, notifDetails);
  }
}
