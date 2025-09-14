// Firebase Messaging Service
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

@pragma('vm:entry-point')
Future<void> firebaseBackgroundMessaging(RemoteMessage message) async {
  await NotificationService.instance.showNotification(message);
  await NotificationService.instance.setupMessageHandlers();
}

class NotificationService {
  NotificationService._();
  static final NotificationService instance = NotificationService._();

  final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  final _localNotifications = FlutterLocalNotificationsPlugin();

  bool _flutterLocalInitialized = false;

  Future<void> init() async {
    FirebaseMessaging.onBackgroundMessage(firebaseBackgroundMessaging);
    await _requestPermission();
    await setupFlutternotification();
    await setupMessageHandlers();

    // final token = await _messaging.getToken();
    // debugPrint('FCM Token: $token');
  }

  Future<void> _requestPermission() async {
    // Meminta izin untuk notifikasi
    NotificationSettings settings = await _messaging.requestPermission(alert: true, badge: true, provisional: false, sound: true);

    // Memeriksa status izin yang diberikan
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      // Izin diberikan, Anda dapat menampilkan notifikasi
      debugPrint("Izin notifikasi diberikan.");
      // Tambahkan logika untuk mengatur notifikasi di sini
    } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
      // Izin sementara diberikan, Anda dapat menampilkan notifikasi dengan batasan
      debugPrint("Izin notifikasi sementara diberikan.");
      // Tambahkan logika untuk mengatur notifikasi sementara di sini
    } else {
      // Izin ditolak
      debugPrint("Izin notifikasi ditolak.");
      // Tambahkan logika untuk menangani penolakan izin di sini
    }
  }

  Future<void> setupFlutternotification() async {
    if (!_flutterLocalInitialized) {
      const channel = AndroidNotificationChannel(
        'high_importance_channel',
        'High Importance Notifications',
        description: 'This channel is used for important notifications.',
        importance: Importance.high,
      );

      await _localNotifications.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.createNotificationChannel(channel);

      final AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');

      final DarwinInitializationSettings initializationSettingsIOS =
          DarwinInitializationSettings(requestAlertPermission: true, requestBadgePermission: true, requestSoundPermission: true);

      final InitializationSettings initializationSettings = InitializationSettings(android: initializationSettingsAndroid, iOS: initializationSettingsIOS);

      await _localNotifications.initialize(
        initializationSettings,
        onDidReceiveNotificationResponse: (details) {
          // debugPrint('Notification received: ${details.toString()}');
        },
      );
      _flutterLocalInitialized = true;
    }

    return;
  }

  Future<void> showNotification(RemoteMessage message) async {
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;

    if (notification != null && android != null) {
      final androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'high_importance_channel',
        'High Importance Notifications',
        importance: Importance.high,
        priority: Priority.high,
        ticker: 'ticker',
        icon: '@mipmap/ic_launcher',
        largeIcon: const DrawableResourceAndroidBitmap('@mipmap/ic_launcher'),
      );

      final platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics);

      await _localNotifications.show(
        notification.hashCode,
        notification.title,
        notification.body,
        platformChannelSpecifics,
        payload: message.data.toString(),
      );
    }
  }

  Future<void> setupMessageHandlers() async {
    await _requestPermission();

    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      // debugPrint('Got a message whilst in the foreground!');
      // debugPrint('Message data: ${message.data}');

      if (message.notification != null) {
        // debugPrint('Message also contained a notification: ${message.notification}');
      }

      await showNotification(message);
    });

    FirebaseMessaging.onMessage.listen(_handleBackgroundMessage);
    final initialMessage = await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) {
      // debugPrint('Handling a background message: ${initialMessage.messageId}');
      _handleBackgroundMessage(initialMessage);
    }

    // FirebaseMessaging.onBackgroundMessage()
  }

  void _handleBackgroundMessage(RemoteMessage message) {
    if (message.data['type'] == 'chat') {
      // debugPrint('Key and value background message: ${message.data}');
      // Handle chat message
    }
    // debugPrint('Key and value background message: ${message.data}');
  }
}
