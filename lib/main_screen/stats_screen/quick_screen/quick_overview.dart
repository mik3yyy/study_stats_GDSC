import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:study_stats/global_comonents/custom_text_button.dart';
import 'package:study_stats/main_screen/stats_screen/dashboard_screen/simulate_screen/simulate_history.dart';
import 'package:study_stats/main_screen/stats_screen/dashboard_screen/simulate_screen/simulate_screen.dart';
import 'package:study_stats/main_screen/stats_screen/quick_screen/quick_calculate.dart';
import 'package:study_stats/main_screen/stats_screen/stats_screen.dart';
import 'package:study_stats/models/quick.dart';
import 'package:study_stats/models/simulate.dart';
import 'package:study_stats/providers/authProvider.dart';
import 'package:study_stats/settings/constants.dart';
import 'package:study_stats/settings/hive_quick.dart';
import 'package:study_stats/settings/hive_simulate.dart';

class QuickOverview extends StatefulWidget {
  const QuickOverview({key});

  @override
  State<QuickOverview> createState() => _QuickOverviewState();
}

class _QuickOverviewState extends State<QuickOverview> {
  List quicks = HiveQuick.getQuickList();

  @override
  Widget build(BuildContext context) {
    var authProvider = Provider.of<AuthProvider>(context, listen: true);

    return Scaffold(
      appBar: AppBar(
        actions: [
          Image.asset(
            'assets/image/Star.png',
          ),
          Constants.gap(width: 20)
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            StatOption(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => QuickScreen()));
              },
              image: 'assets/image/dashboard.png',
              title: "Calculate Any Semester",
              // color: Color(0xFF6FAEF0),
              body: 'Calculate any semester of your choice.',
            ),
            // Card(
            //   child: ListTile(
            //     title: Text(
            //       "Predict This Semester",
            //       style: TextStyle(fontWeight: FontWeight.w700),
            //     ),
            //     trailing: Icon(
            //       Icons.chevron_right,
            //       size: 30,
            //     ),
            //   ),
            // )
            Constants.gap(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'History',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                // CustomTextButton(
                //   text: "View all",
                //   onPressed: () {
                //     Navigator.push(
                //         context,
                //         MaterialPageRoute(
                //             builder: (context) => SimulateHistory()));
                //   },
                // )
              ],
            ),
            Constants.gap(height: 20),

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
                    child: Card(
                      child: Container(
                        height: 128,
                        width: 322.93,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: Constants.white
                            //Color(0xFF61D29C),

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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "GPA",
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
