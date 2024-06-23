import 'package:flutter/material.dart';
import 'package:study_stats/main_screen/stats_screen/dashboard_screen/dashboard_screen.dart';
import 'package:study_stats/main_screen/stats_screen/dashboard_screen/set_goal.dart';
import 'package:study_stats/main_screen/stats_screen/quick_screen/quick_calculate.dart';
import 'package:study_stats/main_screen/stats_screen/quick_screen/quick_overview.dart';
import 'package:study_stats/settings/constants.dart';
import 'package:study_stats/settings/hive_goal.dart';

class StatsScreen extends StatefulWidget {
  const StatsScreen({key});

  @override
  State<StatsScreen> createState() => _StatsScreenState();
}

class _StatsScreenState extends State<StatsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Expanded(
              child: Image.asset(
                'assets/image/dash.png',
                fit: BoxFit.cover,
              ),
            ),
            Constants.gap(height: 10),
            // Text("Ready to take off? What's on your GPA journey today?"),
            Constants.gap(height: 10),
            StatOption(
              onTap: () {
                if (HiveGoal.getGoal().isEmpty) {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SetGoalScreen()));
                } else {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DashboardScreen()));
                }
              },
              image: 'assets/image/dashboard.png',
              title: "Dashboard",
              // color: Color(0xFF6FAEF0),
              body:
                  "Define semester goals, simulate current GPA, and project future CGPA.",
            ),
            Constants.gap(height: 10),
            StatOption(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => QuickOverview()));
              },
              image: 'assets/image/quick.png',
              title: "Quick Calculator",
              // color: Color(0xFF61D29C),
              body:
                  'Instantly calculate your GPA for selected courses and grades.',
            ),
            Constants.gap(height: 10),
          ],
        ),
      ),
    );
  }
}

class StatOption extends StatefulWidget {
  const StatOption(
      {key,
      required this.body,
      required this.image,
      required this.onTap,
      this.color,
      required this.title});

  final String title;
  final String body;
  final String image;
  final Function() onTap;
  final Color? color;
  @override
  State<StatOption> createState() => _StatOptionState();
}

class _StatOptionState extends State<StatOption> {
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: widget.onTap,
      padding: EdgeInsets.zero,
      child: Card(
        shadowColor: Color(0xFFF0F0F0).withOpacity(0.8),
        elevation: 6,
        // borderOnForeground: ,
        child: Container(
            padding: EdgeInsets.symmetric(horizontal: 0),
            height: 128,

            // width: MediaQuery.sizeOf(context).width * 0.9,
            decoration: BoxDecoration(
              color: widget.color ?? Constants.white,
              borderRadius: BorderRadius.circular(16.5),
            ),
            child: Center(
              child: ListTile(
                // horizontalTitleGap: 0
                // ,
                // titleAlignment: ListTileTitleAlignment.bottom,
                leading: Image.asset(
                  widget.image,
                  width: 50,
                  height: 50,
                  fit: BoxFit.contain,
                ),
                title: Text(
                  widget.title,
                  textAlign: TextAlign.start,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                subtitle: Text(
                  widget.body,
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 12, letterSpacing: -0.16),
                ),
                trailing: Icon(
                  Icons.chevron_right,
                  size: 35,
                ),
              ),
            )
            //  Column(
            //   children: [
            // Image.asset(
            //   widget.image,
            //   width: 8,
            //   height: 8,
            //   fit: BoxFit.contain,
            // ),
            //     SizedBox(
            //       height: 50,
            //       child: Row(
            //         // mainAxisAlignment: MainAxisAlignment.e,
            //         // crossAxisAlignment: CrossAxisAlignment.center,
            //         mainAxisAlignment: MainAxisAlignment.center,

            //         children: [
            //           Expanded(child: Constants.gap(width: 4)),
            //           Expanded(
            // flex: 3,
            // child: Text(
            //   widget.title,
            //   textAlign: TextAlign.start,
            //   style: const TextStyle(
            //     fontWeight: FontWeight.w800,
            //     fontSize: 25,
            //     letterSpacing: -2,
            //   ),
            //             ),
            //           ),
            //         ],
            //       ),
            //     ),
            //     Constants.gap(height: 10),
            //     Expanded(
            // child: Text(
            //   widget.body,
            //   textAlign: TextAlign.left,
            // ),
            //     ),
            //   ],
            // ),

            ),
      ),
    );
  }
}
