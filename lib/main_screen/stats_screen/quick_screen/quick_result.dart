import 'package:awesome_circular_chart/awesome_circular_chart.dart';
import 'package:flutter/material.dart';
import 'package:simple_circular_progress_bar/simple_circular_progress_bar.dart';
import 'package:study_stats/global_comonents/custom_button.dart';
import 'package:study_stats/main_screen/main_screen.dart';
import 'package:study_stats/main_screen/stats_screen/quick_screen/quick_function.dart';
import 'package:study_stats/settings/constants.dart';

class QuickResult extends StatefulWidget {
  const QuickResult({key, required this.result});
  final String result;
  @override
  State<QuickResult> createState() => _QuickResultState();
}

class _QuickResultState extends State<QuickResult> {
  Map<String, String> data = {};
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    data = QuickFunction.getQuickResult(cgpa: widget.result);
  }

  @override
  Widget build(BuildContext context) {
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
              size: Size(MediaQuery.sizeOf(context).width * 0.8,
                  MediaQuery.sizeOf(context).height * 0.4),
              edgeStyle: SegmentEdgeStyle.round,
              initialChartData: <CircularStackEntry>[
                CircularStackEntry(
                  <CircularSegmentEntry>[
                    CircularSegmentEntry(
                      double.parse(widget.result),
                      Constants.black,
                      rankKey: 'completed',
                    ),
                    CircularSegmentEntry(
                      5.0 - double.parse(widget.result),
                      Constants.white,
                      rankKey: 'remaining',
                    ),
                  ],
                  rankKey: 'progress',
                ),
              ],
              chartType: CircularChartType.Radial,
              percentageValues: false,
              holeLabel: double.parse(widget.result).toStringAsFixed(
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
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    data['body']!,
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
            //   onTap: () {},
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
