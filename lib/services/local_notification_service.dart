import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotificationService {
  static final FlutterLocalNotificationsPlugin
  _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  static Function(String? payload)? onNotificationClick;

  static Future<void> initialize() async {
    // 🔧 Android settings
    const AndroidInitializationSettings androidSettings =
    AndroidInitializationSettings('@mipmap/ic_launcher');

    // 🔧 iOS settings
    const DarwinInitializationSettings iOSSettings =
    DarwinInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true,
        onDidReceiveLocalNotification: onDidReceiveLocalNotification);

    const InitializationSettings initSettings =
    InitializationSettings(android: androidSettings, iOS: iOSSettings);

    await _flutterLocalNotificationsPlugin.initialize(
      initSettings,
      onDidReceiveNotificationResponse: (details) {
        final payload = details.payload;
        if (payload != null) {
          onNotificationClick?.call(payload);
        }
      },
    );

    // 🔒 iOS permission request (redundant but safe)
    await _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(alert: true, badge: true, sound: true);
  }

  static Future<void> showNotification(
      {required String title, required String body, String? payload}) async {
    const AndroidNotificationDetails androidDetails =
    AndroidNotificationDetails(
        'default_channel_id', 'General Notifications',
        channelDescription: 'Channel for general notifications',
        importance: Importance.max,
        priority: Priority.high,
        playSound: true);

    const DarwinNotificationDetails iOSDetails = DarwinNotificationDetails();

    const NotificationDetails platformDetails =
    NotificationDetails(android: androidDetails, iOS: iOSDetails);

    await _flutterLocalNotificationsPlugin.show(
        DateTime.now().millisecondsSinceEpoch ~/ 1000,
        title,
        body,
        platformDetails,
        payload: payload);
  }

  static void configureFirebaseMessagingHandlers() {
    // 💤 App launched from terminated state
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if (message != null) {
        final payload = message.data['payload'];
        onNotificationClick?.call(payload);
      }
    });

    // 🔙 App in background and opened via notification
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      final payload = message.data['payload'];
      onNotificationClick?.call(payload);
    });

    // ▶️ App in foreground
    FirebaseMessaging.onMessage.listen((message) {
      final notification = message.notification;
      if (notification != null) {
        showNotification(
          title: notification.title ?? '',
          body: notification.body ?? '',
          payload: message.data['payload'],
        );
      }
    });
  }

  // 🧠 Optional: For older iOS versions
  static void onDidReceiveLocalNotification(
      int id, String? title, String? body, String? payload) {
    onNotificationClick?.call(payload);
  }
}
