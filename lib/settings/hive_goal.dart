import 'package:hive_flutter/adapters.dart';

class HiveGoal {
  static var goal_box = Hive.box('goal_box');
  // static List data = goal_box.get('goal_list') ?? [];
  String goal = goal_box.get('goal') ?? '';
  // static void addGoalData(Map<String, dynamic> goal) {
  //   List data = getGoaList();
  //   data.add(goal);
  //   goal_box.put("goal_list", data);
  // }

  static saveGoal(String goal) {
    goal_box.put("goal", goal);
  }

  static String getGoal() {
    return goal_box.get("goal") ?? '';
  }

  static clearQuickData() {
    goal_box.delete('goal');
  }
}
