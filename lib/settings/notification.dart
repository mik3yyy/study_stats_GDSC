import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hive/hive.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationFunction {
  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  static Future<bool> requestPermissions() async {
    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();
    return await flutterLocalNotificationsPlugin
            .resolvePlatformSpecificImplementation<
                IOSFlutterLocalNotificationsPlugin>()
            ?.requestPermissions(
              alert: true,
              badge: true,
              sound: true,
            ) ??
        false;
  }

  static init() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    final DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings(
            requestSoundPermission: false,
            requestBadgePermission: false,
            requestAlertPermission: false,
            onDidReceiveLocalNotification: (id, title, body, payload) async {
              //               print("Title: ${message.notification?.title}");
              // print("Body: ${message.notification?.body}");
              // print("Payload: ${message.data}");
              // await Hive.openBox('reminderBox');
              // DateTime date = DateTime.now();
              // HiveFunction.addSingleNotifiation({
              //   "title": title,
              //   "data": payload,
              //   "body": body,
              //   "time": date
              // });
              // HiveFunction.updateBanner(true);
            });

    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsIOS);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  static Future<void> scheduleDailyNotification({
    required TimeOfDay time,
    required int id,
    required String title,
    required String body,
  }) async {
    final now = DateTime.now();
    final notificationTime =
        DateTime(now.year, now.month, now.day, time.hour, time.minute);
    final androidDetails = const AndroidNotificationDetails(
      'daily_notification_channel_id',
      'Daily Notification',
      channelDescription: 'This channel is used for daily notifications.',
      importance: Importance.max,
    );
    final iOSDetails = const DarwinNotificationDetails();
    final platformDetails =
        NotificationDetails(android: androidDetails, iOS: iOSDetails);
    tz.initializeTimeZones();
    // tz.setLocalLocation(tz.getLocation('Africa/Nigeria'));
    // tz.setLocalLocation(tz.local);

    await flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      tz.TZDateTime.from(notificationTime, tz.local)
          .add(const Duration(days: 7)), // Schedule for the next day
      platformDetails,
      androidScheduleMode: AndroidScheduleMode.exact,
      // androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents
          .time, // Match only time component for daily repetition
    );
  }

  static Future<void> cancelScheduledNotification(int id) async {
    await flutterLocalNotificationsPlugin.cancel(id);
  }

  static Future<void> cancelAllNotifications() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }
}
