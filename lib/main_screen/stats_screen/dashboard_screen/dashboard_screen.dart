import 'package:awesome_circular_chart/awesome_circular_chart.dart';
import 'package:chart_sparkline/chart_sparkline.dart';
import 'package:flutter/material.dart';
import 'package:mrx_charts/mrx_charts.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:study_stats/global_comonents/custom_button.dart';
import 'package:study_stats/global_comonents/custom_messageHandler.dart';
import 'package:study_stats/global_comonents/custom_text_button.dart';
import 'package:study_stats/main_screen/stats_screen/dashboard_screen/set_goal.dart';
import 'package:study_stats/main_screen/stats_screen/dashboard_screen/simulate_screen/simulate_overview.dart';
import 'package:study_stats/main_screen/stats_screen/dashboard_screen/simulate_screen/simulate_screen.dart';
import 'package:study_stats/main_screen/stats_screen/dashboard_screen/update_screen/update_screen.dart';
import 'package:study_stats/main_screen/stats_screen/quick_screen/quick_calculate.dart';
import 'package:study_stats/main_screen/stats_screen/stats_function.dart';
import 'package:study_stats/main_screen/stats_screen/stats_screen.dart';
import 'package:study_stats/models/update.dart';
import 'package:study_stats/providers/authProvider.dart';
import 'package:study_stats/settings/constants.dart';
import 'package:study_stats/settings/hive_goal.dart';
import 'package:study_stats/settings/hive_update.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  PageController _pageController = PageController(initialPage: 0);

  var data = [-1.0];
  bool possible = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var authProvider = Provider.of<AuthProvider>(context, listen: false);
    var goal = HiveGoal.getGoal();
    List updates = HiveUpdate.getUpdateList();
    data = [];
    // data.add(authProvider.user!.currentCgpa!);

    for (Update update in updates) {
      if (data.length == 0) {
        if (update.past_semester != '-1.0') {
          data.add(double.parse(update.past_semester));
        } else {
          if (updates.length > 2) {
          } else {
            data.add(0.00);
          }
        }
      }

      data.add(update.cgpa);
    }

    // data.add(
    //   double.parse(goal),
    // );
    init();
  }

  init() async {
    possible = await StatFunction.getGoalPossibility(context);
    setState(() {});
  }

  List updates = HiveUpdate.getUpdateList();

  @override
  Widget build(BuildContext context) {
    var authProvider = Provider.of<AuthProvider>(context, listen: true);

    return Scaffold(
      appBar: AppBar(
        title: Text("Dashboard "),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SetGoalScreen()));
            },
            icon: Icon(
              Icons.edit,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            if (possible == false) ...[
              Container(
                height: 50,
                width: MediaQuery.sizeOf(context).width * 0.9,
                padding: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  border: Border.all(color: Constants.yellow),
                  color: Constants.yellow.withOpacity(0.4),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Text(
                      "It is impossible to reach this goal ",
                    ),
                    CustomTextButton(
                        text: "Edit Goal",
                        color: Colors.red,
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SetGoalScreen()));
                        })
                    // Expanded(child: Center(child: ,))
                  ],
                ),
              )
            ] else if (double.parse(HiveGoal.getGoal()) <
                authProvider.user!.currentCgpa!) ...[
              Container(
                height: 50,
                width: MediaQuery.sizeOf(context).width * 0.9,
                padding: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  border: Border.all(color: Constants.yellow),
                  color: Constants.yellow.withOpacity(0.4),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Text("You have surpassed your goal "),
                    CustomTextButton(
                        text: "Edit Goal",
                        color: Colors.red,
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SetGoalScreen()));
                        })
                    // Expanded(child: Center(child: ,))
                  ],
                ),
              )
            ],
            Expanded(
              child: Container(
                // color: Color(0xFF9BC6F3),
                child: PageView(
                  controller: _pageController,
                  children: [
                    AnimatedCircularChart(
                      holeRadius: 60,
                      size: Size(MediaQuery.sizeOf(context).width * 0.8,
                          MediaQuery.sizeOf(context).height * 0.4),
                      edgeStyle: SegmentEdgeStyle.round,
                      initialChartData: <CircularStackEntry>[
                        CircularStackEntry(
                          <CircularSegmentEntry>[
                            CircularSegmentEntry(
                              double.parse(HiveGoal.getGoal()),
                              Constants.black,
                              rankKey: 'completed',
                            ),
                            CircularSegmentEntry(
                              double.parse(HiveGoal.getGoal()) -
                                  authProvider.user!.currentCgpa!,
                              Constants.white,
                              rankKey: 'remaining',
                            ),
                          ],
                          rankKey: 'progress',
                        ),
                      ],
                      chartType: CircularChartType.Radial,
                      percentageValues: false,
                      holeLabel:
                          // ${authProvider.user!.currentCgpa!.toStringAsFixed(2)}/
                          " Goal: ${HiveGoal.getGoal()}",
                      labelStyle: TextStyle(
                        color: Colors.blueGrey[600],
                        fontWeight: FontWeight.bold,
                        fontSize: 24.0,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 200,
                        padding: EdgeInsets.only(left: 5, bottom: 10),
                        decoration: BoxDecoration(
                          border: Border(
                            left: BorderSide(color: Constants.black, width: 2),
                            bottom:
                                BorderSide(color: Constants.black, width: 2),
                          ),
                        ),
                        child: Sparkline(
                          pointsMode: PointsMode.all,
                          pointIndex: data.length - 2,
                          pointSize: 10,
                          pointColor: Colors.black,
                          gridLinelabelPrefix: '',
                          gridLineLabelPrecision: 3,
                          enableGridLines: true,
                          data: data,
                          fillColor: Colors.transparent,
                          maxLabel: true,
                          max: 5.0,
                          //           double.parse(HiveGoal.getGoal()) <
                          // authProvider.user!.currentCgpa!
                          //               ? 5.0
                          //               : double.parse(HiveGoal
                          //                   .getGoal()), // double.parse(HiveGoal.getGoal()),
                          maxLine: true,
                          backgroundColor: Constants.white,
                          kLine: ['max'],
                        ),
                      ),
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.all(8.0),
                    //   child: Chart(
                    //     layers: [
                    //       ChartAxisLayer(
                    //         settings: ChartAxisSettings(
                    //           x: ChartAxisSettingsAxis(
                    //             frequency: 1.0,
                    //             max: data.length.toDouble() - 1,
                    //             min: 0.0,
                    //             textStyle: TextStyle(
                    //               color: Colors.black.withOpacity(0.6),
                    //               fontSize: 10.0,
                    //             ),
                    //           ),
                    //           y: ChartAxisSettingsAxis(
                    //             frequency: 1.0,
                    //             max: 5.0,
                    //             min: double.parse(HiveGoal.getGoal()) - 1.00,
                    //             textStyle: TextStyle(
                    //               color: Colors.black.withOpacity(0.6),
                    //               fontSize: 10.0,
                    //             ),
                    //           ),
                    //         ),
                    //         labelX: (value) => value.toInt().toString(),
                    //         labelY: (value) => value.toInt().toString(),
                    //       ),
                    //       ChartGroupBarLayer(
                    //         items: List.generate(
                    //           data.length,
                    //           (index) => [
                    //             ChartGroupBarDataItem(
                    //                 color: Constants.primaryBlue,
                    //                 x: index.toDouble(),
                    //                 value: data[index]),
                    //             ChartGroupBarDataItem(
                    //               color: Constants.black,
                    //               x: index.toDouble(),
                    //               value: double.parse(HiveGoal.getGoal()),
                    //             ),
                    //           ],
                    //         ),
                    //         settings: const ChartGroupBarSettings(
                    //           thickness: 8.0,
                    //           radius: BorderRadius.all(Radius.circular(4.0)),
                    //         ),
                    //       ),
                    //       // ChartTooltipLayer(
                    //       //   shape: () =>
                    //       //       ChartTooltipBarShape<ChartGroupBarDataItem>(
                    //       //     backgroundColor: Colors.white,
                    //       //     currentPos: (item) => item.currentValuePos,
                    //       //     currentSize: (item) => item.currentValueSize,
                    //       //     onTextValue: (item) =>
                    //       //         '€${item.value.toString()}',
                    //       //     marginBottom: 6.0,
                    //       //     padding: const EdgeInsets.symmetric(
                    //       //       horizontal: 12.0,
                    //       //       vertical: 8.0,
                    //       //     ),
                    //       //     radius: 6.0,
                    //       //     textStyle: const TextStyle(
                    //       //       color: Color(0xFF8043F9),
                    //       //       letterSpacing: 0.2,
                    //       //       fontSize: 14.0,
                    //       //       fontWeight: FontWeight.w700,
                    //       //     ),
                    //       //   ),
                    //       // ),
                    //     ],
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 30,
              child: Center(
                child: SmoothPageIndicator(
                  controller: _pageController,
                  count: 2,
                  effect: WormEffect(
                    // radius: 10,
                    activeDotColor: Constants.black,
                    dotColor: Constants.grey,
                    dotHeight: 8,
                    dotWidth: 8,
                    spacing: 15,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Column(
                children: [
                  const Text(
                      "Stay focused and determined. Success is within reach. Keep pushing!"),
                  Constants.gap(height: 10),
                  StatOption(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SimulateOverview()));
                    },
                    image: 'assets/image/dashboard.png',
                    title: "CGPA Simulator",
                    // color: Color(0xFF6FAEF0),
                    body:
                        'Use a GPA simulator to predict academic performance.',
                  ),
                  Constants.gap(height: 10),
                  StatOption(
                    onTap: () {
                      int year = authProvider.courseData!['year'];
                      if (updates.isNotEmpty) {
                        Update update = updates[0];
                        if (update.semester == '2nd' &&
                            update.level.substring(0, 1) == year.toString()) {
                          MyMessageHandler.showSnackBar(context,
                              "You are done with your ${authProvider.user!.course} degree");
                        } else {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => UpdateScreen()));
                        }
                      } else {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => UpdateScreen()));
                      }
                    },
                    image: 'assets/image/quick.png',
                    title: "Upload Result",
                    // color: Color(0xFF61D29C),
                    body:
                        'Update academic details seamlessly for accurate records.',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      // bottomNavigationBar: Container(
      //   height: 100,
      //   child: Center(
      //       // child: CustomButton(onTap: (){}, title: ),
      //       ),
      // ),
    );
  }
}
