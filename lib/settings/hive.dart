import 'package:hive_flutter/adapters.dart';

class HiveFunction {
  static var reminderBox = Hive.box('reminderBox');

  ////////////// NOTIFICATIONS////////////////
  static void updateNotificationList(List<Map<String, dynamic>> notifications) {
    reminderBox.put("notifications", notifications);
  }

  static void addSingleNotifiation(Map<String, dynamic> notification) {
    List<Map<String, dynamic>> notifications = getNotification();
    notifications.add(notification);
    reminderBox.put("notifications", notifications);
    print("saved");
  }

  static List<Map<String, dynamic>> getNotification() {
    List<dynamic> add = reminderBox.get("notifications") ?? [];
    List<Map<String, dynamic>> adds = [];
    add.forEach((element) {
      Map<dynamic, dynamic> e = element;

      Map<String, dynamic> stringQueryParameters = Map.fromEntries(e.entries
          .map((entry) => MapEntry(entry.key.toString(), entry.value)));
      adds.add(stringQueryParameters);
    });

    return adds;
  }

  static void deleteNotifications() {
    reminderBox.delete("notifications");
  }
  //////////////////////////

  static bool showBanner() {
    return reminderBox.get("badge") ?? false;
  }

  static updateBanner(bool badge) {
    reminderBox.put("badge", badge);
  }

///////////////////////////////////
}
