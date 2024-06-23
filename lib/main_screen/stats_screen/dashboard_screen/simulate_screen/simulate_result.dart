import 'package:awesome_circular_chart/awesome_circular_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_circular_progress_bar/simple_circular_progress_bar.dart';
import 'package:study_stats/global_comonents/custom_button.dart';
import 'package:study_stats/main_screen/main_screen.dart';
import 'package:study_stats/main_screen/stats_screen/dashboard_screen/simulate_screen/simulate_function.dart';
import 'package:study_stats/providers/authProvider.dart';
import 'package:study_stats/settings/constants.dart';
import 'package:study_stats/settings/hive_goal.dart';

class SimulateResult extends StatefulWidget {
  const SimulateResult({key, required this.cgpa, required this.current_gpa});
  final String cgpa;
  final String current_gpa;
  // final String ccpa;
  @override
  State<SimulateResult> createState() => _SimulateResultState();
}

class _SimulateResultState extends State<SimulateResult> {
  String goal = '';
  Map<String, String> data = {};
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    goal = HiveGoal.getGoal();
    print(goal);
    data = SimulateFunction.getSimulation(
        goal: goal, current_gpa: widget.current_gpa, cgpa: widget.cgpa);
  }

  @override
  Widget build(BuildContext context) {
    var authProvider = Provider.of<AuthProvider>(context, listen: true);

    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Example 4
            // SimpleCircularProgressBar(
            //   startAngle: 0,
            //   maxValue: 5,
            //   // size: 50,
            //   progressColors: [Constants.primaryBlue],
            //   onGetText: (p0) => Text(
            // double.parse(widget.result).toStringAsFixed(
            //   2,
            // ),
            //   ),
            //   backColor: Constants.grey,
            // ),
            AnimatedCircularChart(
              holeRadius: 50,
              size: Size(MediaQuery.sizeOf(context).width,
                  MediaQuery.sizeOf(context).height * 0.3),
              edgeStyle: SegmentEdgeStyle.round,
              initialChartData: <CircularStackEntry>[
                CircularStackEntry(
                  <CircularSegmentEntry>[
                    CircularSegmentEntry(
                      double.parse(widget.cgpa),
                      Constants.black,
                      rankKey: 'completed',
                    ),
                    CircularSegmentEntry(
                      double.parse(goal) - double.parse(widget.cgpa),
                      Constants.white,
                      rankKey: 'remaining',
                    ),
                  ],
                  rankKey: 'progress',
                ),
              ],
              chartType: CircularChartType.Radial,
              percentageValues: false,
              holeLabel: double.parse(widget.cgpa).toStringAsFixed(
                2,
              ),
              labelStyle: TextStyle(
                color: Colors.blueGrey[600],
                fontWeight: FontWeight.bold,
                fontSize: 24.0,
              ),
            ),
            Expanded(
                child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data['title']!,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    data['body']!,
                    // "Based on your predicted GPA of 4.15, it looks like there's a great opportunity ahead to enhance your academic standing. Reaching your CGPA target might require a bit more focus and dedication. Now's the perfect time to identify areas for improvement, seek additional resources, and perhaps adjust your study habits. Remember, every effort you make today shapes your academic success tomorrow.",
                    style: TextStyle(height: 2),
                  )
                ],
              ),
            ))
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 100,
        child: Column(
          children: [
            // CustomButton(
            //   enable: authProvider.user!.premium,
            //   onTap: () async {
            //     String generatedText = await SimulateFunction.generateText(
            //         "What is your name?", "gpt-3.5-turbo");
            //     print(generatedText);
            //   },
            //   title: "Advanced Analysis (ChatGPT-4)",
            // ),
            Constants.gap(height: 20),
            CustomButtonSecondary(
              onTap: () {
                Navigator.pushNamedAndRemoveUntil(
                    context, MainScreen.id, (route) => false);
              },
              title: "GO Back Home",
            )
          ],
        ),
      ),
    );
  }
}
