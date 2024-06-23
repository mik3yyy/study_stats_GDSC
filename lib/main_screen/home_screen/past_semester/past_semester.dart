import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:study_stats/main_screen/stats_screen/dashboard_screen/update_screen/update_screen.dart';
import 'package:study_stats/models/update.dart';
import 'package:study_stats/providers/authProvider.dart';
import 'package:study_stats/settings/constants.dart';
import 'package:study_stats/settings/hive_update.dart';

class PastSemesterScreen extends StatefulWidget {
  const PastSemesterScreen({key});

  @override
  State<PastSemesterScreen> createState() => _PastSemesterScreenState();
}

class _PastSemesterScreenState extends State<PastSemesterScreen> {
  List updates = HiveUpdate.getUpdateList().reversed.toList();
  @override
  Widget build(BuildContext context) {
    var authProvider = Provider.of<AuthProvider>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        title: Text('Past Semesters'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Expanded(
              child: ListView.separated(
                separatorBuilder: (context, index) => Constants.gap(height: 20),
                itemCount: updates.length,
                // reverse: true,
                itemBuilder: (context, index) {
                  Update update = updates[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => UpdateScreen(
                                    update: update,
                                    index: index,
                                  )));
                    },
                    child: Card(
                      child: Container(
                        height: 128,
                        width: 322.93,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: Theme.of(context).colorScheme.primary),
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
                                        "${update.level} level ",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w300,
                                        ),
                                      ),
                                      Text(
                                        "${update.semester} semester ",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w300,
                                        ),
                                      ),
                                      Text(
                                        "${update.gpa.toStringAsPrecision(2)} Gpa ",
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
                              children: [
                                Text(
                                  "CGPA",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  update.cgpa.toStringAsFixed(2),
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 40,
                                      letterSpacing: -4),
                                ),
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
