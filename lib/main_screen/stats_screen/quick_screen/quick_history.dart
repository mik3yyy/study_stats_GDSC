import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:study_stats/main_screen/stats_screen/quick_screen/quick_calculate.dart';
import 'package:study_stats/models/quick.dart';
import 'package:study_stats/models/quick.dart';
import 'package:study_stats/providers/authProvider.dart';
import 'package:study_stats/settings/constants.dart';
import 'package:study_stats/settings/hive_quick.dart';
import 'package:study_stats/settings/hive_update.dart';

class QuickHistory extends StatefulWidget {
  const QuickHistory({key});

  @override
  State<QuickHistory> createState() => _QuickHistoryState();
}

class _QuickHistoryState extends State<QuickHistory> {
  List quicks = HiveQuick.getQuickList();
  @override
  Widget build(BuildContext context) {
    var authProvider = Provider.of<AuthProvider>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        title: Text('Quick Result History'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Expanded(
              child: ListView.separated(
                separatorBuilder: (context, index) => Constants.gap(height: 20),
                itemCount: quicks.length,
                // reverse: true,
                itemBuilder: (context, index) {
                  Quick quick = quicks[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => QuickScreen(
                            quick_data: quick,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      height: 128,
                      width: 322.93,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: Color(0xFF61D29C),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  authProvider.user!.university!.toUpperCase(),
                                  style: TextStyle(
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${quick.level} level ",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                    Text(
                                      "${quick.semester} semester ",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                    // Text(
                                    //   "${quick..toStringAsPrecision(2)} Gpa ",
                                    //   style: TextStyle(
                                    //     fontWeight: FontWeight.w300,
                                    //   ),
                                    // ),
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
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                              Text(
                                double.parse(quick.result).toStringAsFixed(2),
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 30,
                                    letterSpacing: -2),
                              ),
                              Icon(
                                Icons.chevron_right,
                                size: 40,
                              )
                            ],
                          ))
                        ],
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
