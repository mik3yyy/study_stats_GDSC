import 'package:hive_flutter/adapters.dart';
import 'package:study_stats/models/simulate.dart';
import 'package:study_stats/models/update.dart';

class HiveUpdate {
  static var updateBox = Hive.box('update_box');
  // static List data = updateBox.get('update_list') ?? [];
  static void addUpdateData(Update update_list) {
    List d = updateBox.get('update_list') ?? [];
    d.add(update_list);
    updateBox.put("update_list", d);
  }

  static List getUpdateList() {
    // print(updateBox.get("update_list"));
    return updateBox.get("update_list") ?? [];
  }

  static replaceUpdateList(List update_list) {
    updateBox.put("update_list", update_list);
  }

  static clearUpdateList() {
    updateBox.delete('update_list');
  }
}
