import 'package:hive_flutter/adapters.dart';
import 'package:study_stats/models/simulate.dart';

class HiveSimulate {
  static var simulateBox = Hive.box('simulate_box');
  // static List data = simulateBox.get('simulate_list') ?? [];
  static void addSimulateData(Simulate simulate_list) {
    List d = simulateBox.get('simulate_list') ?? [];
    d.add(simulate_list);
    simulateBox.put("simulate_list", d);
  }

  static replaceSimulateList(List simulate_list) {
    simulateBox.put("simulate_list", simulate_list);
  }

  static List getSimulateList() {
    return simulateBox.get("simulate_list") ?? [];
  }

  static clearSimulateList() {
    simulateBox.delete('simulate_list');
  }
}
