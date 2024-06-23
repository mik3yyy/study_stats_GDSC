import 'dart:math';

import 'package:awesome_circular_chart/awesome_circular_chart.dart';
import 'package:chart_sparkline/chart_sparkline.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:mrx_charts/mrx_charts.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:study_stats/main_screen/home_screen/past_semester/past_semester.dart';
import 'package:study_stats/main_screen/home_screen/quote_screen/quote_screen.dart';
import 'package:study_stats/main_screen/profile_screen/edit_profile/edit_profile.dart';
import 'package:study_stats/main_screen/stats_screen/dashboard_screen/dashboard_screen.dart';
import 'package:study_stats/main_screen/stats_screen/dashboard_screen/set_goal.dart';
import 'package:study_stats/main_screen/stats_screen/dashboard_screen/update_screen/update_screen.dart';
import 'package:study_stats/models/update.dart';
import 'package:study_stats/providers/authProvider.dart';
import 'package:study_stats/settings/constants.dart';
import 'package:study_stats/settings/hive_goal.dart';
import 'package:study_stats/settings/hive_update.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var data = [-1.0];
  PageController _pageController = PageController(initialPage: 0);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    var goal = HiveGoal.getGoal();
    if (goal.isNotEmpty) {
      List updates = HiveUpdate.getUpdateList();
      data = [];

      for (dynamic update in updates) {
        // print(update);
        data.add(update.cgpa);
      }
      // data.add(
      //   double.parse(goal),
      // );
    }
    // data = [
    //   authProvider.user!.currentCgpa!,
    //   double.parse(goal),
    // ];
  }

  List updates = HiveUpdate.getUpdateList();
  List updates2 = HiveUpdate.getUpdateList().reversed.toList();
  var qoute = Hive.box('userBox').get('quote') ?? {};
  @override
  Widget build(BuildContext context) {
    var authProvider = Provider.of<AuthProvider>(context, listen: true);

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Row(
          children: [
            Text(
              ' Welcome',
              style: TextStyle(fontSize: 20),
            ),
            Expanded(
              child: Text(
                " ${authProvider.user?.name.substring(0, 1).toUpperCase()}${authProvider.user?.name.substring(1)}",
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
              ),
            )
          ],
        ),
        actions: [
          Image.asset(
            'assets/image/Star.png',
          ),
          Constants.gap(width: 20)
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Container(
          height: MediaQuery.sizeOf(context).height,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Your daily Quote",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => QuoteScreen(quote: qoute)));
                  },
                  child: Card(
                    child: Container(
                      height: 128,
                      // width: 322.93,
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        // color: Color(0xFF9BC6F3),
                        color: Constants.black,
                      ),
                      child: Center(
                        child: Text(
                          '"${qoute['quote']}" \n- ${qoute['author']}',
                          style: TextStyle(
                              color: Constants.white,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  ),
                ),
                Constants.gap(height: 10),
                const Text(
                  "Goal",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
                Constants.gap(height: 10),

                if (HiveGoal.getGoal().isNotEmpty) ...[
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DashboardScreen()));
                    },
                    child: Card(
                      child: Container(
                        height: 128,
                        // width: 322.93,
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          // color: Color(0xFF9BC6F3),
                          color: Constants.white,
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Your current goal is ",
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Constants.gap(height: 10),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${HiveGoal.getGoal()} ",
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      Text(
                                        "cgpa",
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w400,
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
                                AnimatedCircularChart(
                                  holeRadius: 20,
                                  size: Size(120, 120),
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
                                          (double.parse(HiveGoal.getGoal()) -
                                              authProvider.user!.currentCgpa!),
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
                                      "${HiveGoal.getGoal()}",
                                  labelStyle: TextStyle(
                                    color: Constants.black,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ))
                          ],
                        ),
                      ),
                    ),
                  ),
                  // Expanded(
                  //   flex: 1,
                  //   child: AnimatedCircularChart(
                  //     holeRadius: 10,
                  //     size: Size(MediaQuery.sizeOf(context).width * 0.8,
                  //         MediaQuery.sizeOf(context).height * 0.4),
                  //     edgeStyle: SegmentEdgeStyle.flat,
                  //     initialChartData: <CircularStackEntry>[
                  //       CircularStackEntry(
                  //         <CircularSegmentEntry>[
                  //           CircularSegmentEntry(
                  //             double.parse(HiveGoal.getGoal()),
                  //             Constants.primaryBlue,
                  //             rankKey: 'completed',
                  //           ),
                  //           CircularSegmentEntry(
                  //             double.parse(HiveGoal.getGoal()) -
                  //                 authProvider.user!.currentCgpa!,
                  //             Constants.white,
                  //             rankKey: 'remaining',
                  //           ),
                  //         ],
                  //         rankKey: 'progress',
                  //       ),
                  //     ],
                  //     chartType: CircularChartType.Radial,
                  //     percentageValues: false,
                  //     holeLabel:
                  //         // ${authProvider.user!.currentCgpa!.toStringAsFixed(2)}/
                  //         " Goal: ${HiveGoal.getGoal()}",
                  //     labelStyle: TextStyle(
                  //       color: Colors.blueGrey[600],
                  //       fontWeight: FontWeight.bold,
                  //       fontSize: 24.0,
                  //     ),
                  //   ),
                  // )
                ] else ...[
                  DottedBorder(
                      borderType: BorderType.RRect,
                      color: Theme.of(context).colorScheme.secondary,
                      // strokeWidth: 10,
                      // stackFit: StackFit.expand,
                      dashPattern: [10, 10],
                      radius: Radius.circular(12),
                      // padding: EdgeInsets.all(6),
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                        child: Card(
                          margin: EdgeInsets.zero,
                          child: Container(
                            height: 128,

                            // margin: EdgeInsets.only(bottom: 10),
                            // height: MediaQuery.sizeOf(context).width * 0.9,
                            width: MediaQuery.sizeOf(context).width * 0.9,
                            decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.primary,

                                // color: const Color(0xff20448F),
                                borderRadius: BorderRadius.circular(15)),
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                SetGoalScreen()));
                                  },
                                  child: DottedBorder(
                                    borderType: BorderType.Circle,
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                    // strokeWidth: 10,
                                    // stackFit: StackFit.expand,
                                    dashPattern: [10, 10],
                                    child: CircleAvatar(
                                      radius: 20,
                                      backgroundColor:
                                          Constants.grey.withOpacity(0.4),
                                      child: Center(
                                        child: Icon(
                                          Icons.add,
                                          color: Constants.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Text(
                                  "Set Your Goal ",
                                  style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ))
                ],
                Constants.gap(height: 10),
                // SizedBox(
                //   height: 30,
                //   child: Center(
                //     child: SmoothPageIndicator(
                //       controller: _pageController,
                //       count: 3,
                //       effect: WormEffect(
                //         // radius: 10,
                //         activeDotColor: Constants.primaryBlue,
                //         dotColor: Constants.grey,
                //         dotHeight: 8,
                //         dotWidth: 8,
                //         spacing: 15,
                //       ),
                //     ),
                //   ),
                // ),
                // Constants.gap(height: 20),
                Container(
                  // padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Text(
                        "Current Detail",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      ),
                      Constants.gap(height: 10),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => EditProfile()));
                        },
                        child: Card(
                          child: Container(
                            height: 128,

                            // width: 322.93,
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                color: Theme.of(context).colorScheme.primary

                                // color: Color(0xFF9BC6F3),
                                ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        authProvider.user?.course! ?? "",
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "${authProvider.user?.level ?? ""} level ",
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w300,
                                            ),
                                          ),
                                          Text(
                                            "${authProvider.user?.semester ?? ""} semester ",
                                            style: const TextStyle(
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
                                      "Current GPA",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Text(
                                      authProvider.user?.currentCgpa!
                                                  .toStringAsFixed(2) ==
                                              "-1.00"
                                          ? "0.00"
                                          : authProvider.user!.currentCgpa!
                                              .toStringAsFixed(2),
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
                      ),
                      if (updates2.length != 0)
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 2),
                          child: Column(
                            children: [
                              // Divider(),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('PAST SEMESTERS'),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  PastSemesterScreen()));
                                    },
                                    child: Text("View all"),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      Container(
                        height: 200,
                        child: ListView.builder(
                          // reverse: true,
                          itemCount: updates2.length > 0 ? 1 : 0,
                          itemBuilder: (context, index) {
                            Update update = updates2[index];
                            // Update update = updates[updates.length - 2];
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
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primary),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              authProvider.user!.course!,
                                              style: TextStyle(
                                                fontWeight: FontWeight.w600,
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
