import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:todo_app/main.dart';
import 'package:todo_app/screens/notification_screen.dart';

Future<void> handleBackgroundMessage(RemoteMessage message) async {
  print("Title:${message.notification?.title}");
  print("Body:${message.notification?.body}");
  print("Payload:${message.data}");
}

class FirebaseApi {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  final _androidChannel = const AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    description:
        'This channel is used for important notifications.', // description
    importance: Importance.defaultImportance,
  );

  final _localNotifications = FlutterLocalNotificationsPlugin();

  handleMessage(RemoteMessage? message) {
    if (message == null) return;

    navigatorKey.currentState
        ?.pushNamed(NotificationScreen.route, arguments: message);
  }

  Future initLocalNotification() async {
    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: AndroidInitializationSettings("@drawable/ic_launcher"),
    );

    await _localNotifications.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse:
          (NotificationResponse notificationResponse) {
        final message =
            RemoteMessage.fromMap(jsonDecode(notificationResponse.payload!));
        handleMessage(message);
        print("notificationResponse ${notificationResponse.payload}");
      },
    );

    final platform = _localNotifications.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();

    await platform?.createNotificationChannel(_androidChannel);
  }

  // Future initPushNotification() async {
  //   await FirebaseMessaging.instance
  //       .setForegroundNotificationPresentationOptions(
  //     alert: true,
  //     badge: true,
  //     sound: true,
  //   );

  //   FirebaseMessaging.instance.getInitialMessage().then(handleMessage);
  //   FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
  //   FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);

  //   FirebaseMessaging.onMessage.listen((message) {
  //     final notification = message.notification;
  //     if (notification == null) return;
  //     _localNotifications.show(
  //       notification.hashCode,
  //       notification.title,
  //       notification.body,
  //       payload: jsonEncode(message.toMap()),
  //       NotificationDetails(
  //         android: AndroidNotificationDetails(
  //           _androidChannel.id,
  //           _androidChannel.name,
  //           channelDescription: _androidChannel.description,
  //           icon: '@drawable/ic_launcher',
  //         ),
  //       ),
  //     );
  //   });
  // }

  Future<void> initNotifications() async {
    // await _firebaseMessaging.requestPermission();
    // final fCMToken = await _firebaseMessaging.getToken();
    // print("Token: $fCMToken");

    // initPushNotification();
    initLocalNotification();
  }
}
