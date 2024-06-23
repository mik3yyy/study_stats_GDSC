import 'package:hive_flutter/adapters.dart';
import 'package:study_stats/models/quick.dart';

class HiveQuick {
  static var quickBox = Hive.box('quick_box');
  static List data = quickBox.get('quick_list') ?? [];
  static void addQuickData(Quick quick_list) {
    List d = quickBox.get('quick_list') ?? [];

    d.add(quick_list);
    quickBox.put("quick_list", d);
  }

  static replaceQuickList(List quick_list) {
    quickBox.put("quick_list", quick_list);
  }

  static List getQuickList() {
    // print(updateBox.get("update_list"));
    return quickBox.get("quick_list") ?? [];
  }

  static clearQuickData() {
    quickBox.delete('quick_list');
  }
}
