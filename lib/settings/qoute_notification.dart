// import 'dart:math';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:hive_flutter/adapters.dart';
// import 'package:study_stats/settings/quotes.dart';
// import 'package:timezone/data/latest.dart' as tz;
// import 'package:timezone/timezone.dart' as tz;
// import 'package:flutter_native_timezone/flutter_native_timezone.dart';

// class NotificationQuoteService {
//   static final FlutterLocalNotificationsPlugin _notificationsPlugin =
//       FlutterLocalNotificationsPlugin();

//   static Future<void> initialize() async {
//     final DarwinInitializationSettings initializationSettingsIOS =
//         DarwinInitializationSettings(
//       requestSoundPermission: true,
//       requestBadgePermission: true,
//       requestAlertPermission: true,
//       onDidReceiveLocalNotification: (id, title, body, payload) async {},
//     );

//     final InitializationSettings initializationSettings =
//         InitializationSettings(
//       android: AndroidInitializationSettings('@mipmap/ic_launcher'),
//       iOS: initializationSettingsIOS,
//     );

//     await _notificationsPlugin.initialize(initializationSettings);
//     tz.initializeTimeZones();
//     final String timeZoneName = await FlutterNativeTimezone.getLocalTimezone();
//     tz.setLocalLocation(tz.getLocation(timeZoneName));
//   }

//   static Future<void> showDailyQuoteNotification() async {
//     const AndroidNotificationDetails androidPlatformChannelSpecifics =
//         AndroidNotificationDetails(
//       'daily_quote_id',
//       'Daily Quote',
//       channelDescription: 'Channel for Daily Quote Notifications',
//       importance: Importance.max,
//       priority: Priority.high,
//       ticker: 'ticker',
//     );
//     const NotificationDetails platformChannelSpecifics = NotificationDetails(
//         android: androidPlatformChannelSpecifics,
//         iOS: DarwinNotificationDetails());

//     final quote = await getRandomQuote();
//     var user = Hive.box('userBox');

//     user.put('quote', quote);
//     tz.initializeTimeZones();

//     await _notificationsPlugin.zonedSchedule(
//         0, // ID for the notification
//         quote['author'], // Title
//         quote['quote'], // Body
//         _nextInstanceOfNineAM(), // Scheduled time
//         platformChannelSpecifics,
//         androidScheduleMode: AndroidScheduleMode.exact,
//         uiLocalNotificationDateInterpretation:
//             UILocalNotificationDateInterpretation.absoluteTime,
//         matchDateTimeComponents:
//             DateTimeComponents.time // Repeat daily at the same time
//         );
//   }

//   static tz.TZDateTime _nextInstanceOfNineAM() {
//     final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
//     tz.TZDateTime scheduledDate =
//         tz.TZDateTime(tz.local, now.year, now.month, now.day, 1, 00);
//     if (scheduledDate.isBefore(now)) {
//       scheduledDate = scheduledDate.add(const Duration(days: 1));
//     }
//     return scheduledDate;
//   }

//   static Future<Map<String, String>> getRandomQuote() async {
//     return (Quotes.motivationalQuotes..shuffle()).first;
//   }
// }
