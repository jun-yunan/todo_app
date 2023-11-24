import 'package:get/get.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/rxdart.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:todo_app/utils/utils.dart';

class NotificationController extends GetxController {
  @override
  void onInit() async {
    super.onInit();
  }

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static final onClickNotification = BehaviorSubject();

  void onNotificationTap(NotificationResponse notificationResponse) {
    onClickNotification.add(notificationResponse.payload!);
  }

  Future<void> initLocalNotification() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    final DarwinInitializationSettings initializationSettingsDarwin =
        DarwinInitializationSettings(
            onDidReceiveLocalNotification: (id, title, body, payload) => null);
    const LinuxInitializationSettings initializationSettingsLinux =
        LinuxInitializationSettings(defaultActionName: 'Open notification');
    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsDarwin,
            linux: initializationSettingsLinux);
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      // onDidReceiveNotificationResponse: onNotificationTap,
      onDidReceiveNotificationResponse: (details) => null,
      // onDidReceiveBackgroundNotificationResponse: onNotificationTap,
    );
  }

  Future showSimpleNotification(
      {required String title,
      required String body,
      required String payload}) async {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails('your channel id', 'your channel name',
            channelDescription: 'your channel description',
            importance: Importance.max,
            priority: Priority.high,
            ticker: 'ticker');
    const NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);
    await flutterLocalNotificationsPlugin.show(
      0,
      title,
      body,
      notificationDetails,
      payload: payload,
    );
  }

  Future showPeriodicNotifications(
      {required String title,
      required String body,
      required String payload}) async {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      'channel 2',
      'your channel name',
      channelDescription: 'your channel description',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
    );
    const NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);
    await flutterLocalNotificationsPlugin.periodicallyShow(
      1,
      title,
      body,
      RepeatInterval.everyMinute,
      notificationDetails,
      payload: payload,
    );
  }

  // Future<void> scheduleNotification({
  //   required String title,
  //   required String body,
  //   required String payload,
  // }) async {
  //   tz.initializeTimeZones();

  //   await flutterLocalNotificationsPlugin.zonedSchedule(
  //     5,
  //     title,
  //     body,
  //     tz.TZDateTime.now(tz.local).add(const Duration(seconds: 5)),
  //     const NotificationDetails(
  //       android: AndroidNotificationDetails(
  //         'channel 3',
  //         'your channel name',
  //         channelDescription: 'your channel description',
  //         importance: Importance.max,
  //         priority: Priority.high,
  //         ticker: 'ticker',
  //       ),
  //     ),
  //     androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
  //     uiLocalNotificationDateInterpretation:
  //         UILocalNotificationDateInterpretation.absoluteTime,
  //     payload: payload,
  //   );
  // }

  Future<void> scheduleNotification({
    required int id,
    required String title,
    required String body,
    required String payload,
    required DateTime time,
  }) async {
    tz.initializeTimeZones();

    await flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      tz.TZDateTime.from(time, tz.local),
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'channel 3',
          'your channel name',
          channelDescription: 'your channel description',
          importance: Importance.max,
          priority: Priority.high,
          ticker: 'ticker',
        ),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      payload: payload,
    );
  }

  Future cancel(int id) async {
    await flutterLocalNotificationsPlugin.cancel(id);
  }

  Future cancelAll() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }
}
