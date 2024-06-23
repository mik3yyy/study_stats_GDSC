import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:study_stats/main_screen/stats_screen/dashboard_screen/simulate_screen/simulate_screen.dart';
import 'package:study_stats/main_screen/stats_screen/quick_screen/quick_calculate.dart';
import 'package:study_stats/models/quick.dart';
import 'package:study_stats/models/quick.dart';
import 'package:study_stats/models/simulate.dart';
import 'package:study_stats/providers/authProvider.dart';
import 'package:study_stats/settings/constants.dart';
import 'package:study_stats/settings/hive_quick.dart';
import 'package:study_stats/settings/hive_simulate.dart';
import 'package:study_stats/settings/hive_update.dart';

class SimulateHistory extends StatefulWidget {
  const SimulateHistory({key});

  @override
  State<SimulateHistory> createState() => _SimulateHistoryState();
}

class _SimulateHistoryState extends State<SimulateHistory> {
  List simulate = HiveSimulate.getSimulateList().reversed.toList();
  @override
  Widget build(BuildContext context) {
    var authProvider = Provider.of<AuthProvider>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        title: Text('Simulate Result History'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Expanded(
              child: ListView.separated(
                separatorBuilder: (context, index) => Constants.gap(height: 20),
                itemCount: simulate.length,
                // reverse: true,
                itemBuilder: (context, index) {
                  Simulate sim = simulate[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SimulateScreen(
                            simulate: sim,
                          ),
                        ),
                      );
                    },
                    child: Card(
                      margin: EdgeInsets.zero,
                      child: Container(
                        height: 140,
                        width: 322.93,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: Constants.white,
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    authProvider.user!.course!.toUpperCase(),
                                    style: TextStyle(
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${sim.level} level ",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w300,
                                        ),
                                      ),
                                      Text(
                                        "${sim.semester} semester",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w300,
                                        ),
                                      ),
                                      Text(
                                        "GPA: ${sim.gpa.toStringAsPrecision(2)}",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w300,
                                        ),
                                      ),
                                      Text(
                                        "Past Semester: ${sim.past_gpa.toStringAsPrecision(2) == "-1.0" ? "0.00" : sim.past_gpa.toStringAsPrecision(2)}  ",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w300,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                                child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "CGPA",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                                Text(
                                  sim.cgpa.toStringAsFixed(2),
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 30,
                                      letterSpacing: -2),
                                ),
                                // Icon(
                                //   Icons.chevron_right,
                                //   size: 40,
                                // )
                              ],
                            ))
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
