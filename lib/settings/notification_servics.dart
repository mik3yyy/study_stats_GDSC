import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:study_stats/settings/notification.dart';
import 'package:study_stats/settings/quotes.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static void initialize() {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    final DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings(
      requestSoundPermission: false,
      requestBadgePermission: false,
      requestAlertPermission: false,
      onDidReceiveLocalNotification: (id, title, body, payload) async {
        NotificationFunction.cancelAllNotifications();
        Future.delayed(
          Duration(minutes: 5),
          () => Quotes.set(),
        ); // NotificationFunction.cancelAllNotifications();
        // Quotes.set();
      },
    );

    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsIOS);

    _notificationsPlugin.initialize(
      initializationSettings,
    );
  }

  static Future<void> showDailyQuoteNotification() async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails('daily_quote_id', 'Daily Quote',
            channelDescription: 'Channel for Daily Quote Notifications',
            importance: Importance.max,
            priority: Priority.high,
            ticker: 'ticker');
    final iOSDetails = DarwinNotificationDetails();

    final NotificationDetails platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics, iOS: iOSDetails);

    // Select a random quote
    final randomQuote = (Quotes.motivationalQuotes..shuffle()).first;
    var user = Hive.box('userBox');

    user.put('quote', randomQuote);

    await _notificationsPlugin.zonedSchedule(
        0, // ID for the notification
        randomQuote['author'], // Title
        randomQuote['quote'], // Body
        _nextInstanceOfNineAM(), // Scheduled time
        platformChannelSpecifics,
        androidScheduleMode: AndroidScheduleMode.exact,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents:
            DateTimeComponents.time // Repeat daily at the same time
        );
  }

  static tz.TZDateTime _nextInstanceOfNineAM() {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledDate =
        tz.TZDateTime(tz.local, now.year, now.month, now.day, 9);
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    return scheduledDate;
  }
}
