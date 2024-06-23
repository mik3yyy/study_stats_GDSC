import 'package:flutter/material.dart';
import 'package:flutter_dropdown/flutter_dropdown.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:study_stats/auth_screen/fill_profile/fill_profile_function.dart';
import 'package:study_stats/global_comonents/custom_button.dart';
import 'package:study_stats/global_comonents/custom_messageHandler.dart';
import 'package:study_stats/main_screen/stats_screen/dashboard_screen/simulate_screen/edit_course_screen/edit_course.dart';
import 'package:study_stats/main_screen/stats_screen/dashboard_screen/simulate_screen/simulate_result.dart';
import 'package:study_stats/main_screen/stats_screen/dashboard_screen/update_screen/update_result_screen.dart';
import 'package:study_stats/main_screen/stats_screen/stats_function.dart';
import 'package:study_stats/models/update.dart';
import 'package:study_stats/providers/authProvider.dart';
import 'package:study_stats/settings/constants.dart';

class UpdateScreen extends StatefulWidget {
  const UpdateScreen({key, this.update, this.index});
  final Update? update;
  final int? index;
  @override
  State<UpdateScreen> createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  List courseData = [];
  String semester = '';
  String level = '';
  List<String> grades = [];
  bool clear = false;
  List<String> scores = [];
  int system = 5;
  String currentGpa = '';
  bool loading = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.update != null) {
      UpdateHistoryInit();
    } else {
      init();
    }
  }

  init() async {
    var authProvider = Provider.of<AuthProvider>(context, listen: false);
    semester = authProvider.user!.semester!;
    currentGpa = authProvider.user!.currentCgpa!.toString();
    print(semester);
    level = authProvider.user!.level!.toString();
    courseData = authProvider.courseData![level][semester.substring(0, 1)];
    print(courseData);
    scores = List.generate(courseData.length, (index) => '-1');
    grades = await getGrade();

    setState(() {});
  }

  UpdateHistoryInit() async {
    Update update = widget.update!;
    currentGpa = update.past_semester.toString();

    semester = update.semester;
    level = update.level;
    courseData = update.courseData;
    grades = await getGrade();
    List<String> g =
        StatFunction.convertScoreToGrade(update.scores, system: system);
    scores = g;
    // List.generate(quick.scores.length, (index) => quick.scores[index]);
    setState(() {});
  }

  Future<List<String>> getGrade() async {
    var authProvider = Provider.of<AuthProvider>(context, listen: false);
    var user = authProvider.user;
    String uni = FillProfileFunction.convertTexttoFileName(user!.university!);

    var res =
        await FillProfileFunction.loadJsonData(url: 'schools/${uni}/main.json');
    String grading_system = res['grading-system'].toString();
    if (grading_system == '5') {
      system = 5;
      return ['A', 'B', 'C', 'D', 'E', 'F'];
    } else {
      system = 4;
      return ['A', 'B', 'C', 'D', 'E'];
    }
  }

  @override
  Widget build(BuildContext context) {
    var authProvider = Provider.of<AuthProvider>(context, listen: true);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Upload Result"),
        actions: [
          Image.asset(
            'assets/image/Star.png',
          ),
          Constants.gap(width: 20)
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const Text(
              "Slide the course tile to edit and delete a course ",
              textAlign: TextAlign.center,
            ),
            if (currentGpa != '-1.0')
              Text(
                'Current CGPA: ${double.parse(currentGpa).toStringAsFixed(2)}',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
              ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 100,
                  // padding: EdgeInsets.symmetric(horizontal: 15),
                  decoration: BoxDecoration(
                    color: Constants.white,
                    borderRadius: BorderRadius.circular(10),
                    // border: Border.all(color: Constants.grey),
                  ),
                  child: Text(semester + " Semester"),
                ),
                Container(
                    width: 100,
                    // padding: EdgeInsets.symmetric(horizontal: 15),
                    decoration: BoxDecoration(
                      color: Constants.white,
                      borderRadius: BorderRadius.circular(10),
                      // border: Border.all(color: Constants.grey),
                    ),
                    child: Text(level + " Level")),
              ],
            ),
            Divider(),
            // Row(
            //   children: [
            //     Expanded(
            //       child: Center(
            //         child: Text('Course'),
            //       ),
            //     ),
            //     Expanded(
            //       child: Center(
            //         child: Text('Code'),
            //       ),
            //     ),
            //     Expanded(
            //       child: Center(
            //         child: Text('Unit'),
            //       ),
            //     ),
            //     Expanded(
            //       child: Center(
            //         child: Text('Grade'),
            //       ),
            //     ),
            //   ],
            // ),
            Expanded(
              child: Scrollbar(
                child: Container(
                  margin: EdgeInsets.only(right: 5),
                  child: ListView.separated(
                      separatorBuilder: (context, index) =>
                          Constants.gap(height: 5),
                      itemCount: courseData.length,
                      itemBuilder: (context, index) {
                        return Slidable(
                          key: const ValueKey(0),

                          // The start action pane is the one at the left or the top side.
                          startActionPane: ActionPane(
                            // A motion is a widget used to control how the pane animates.
                            motion: const ScrollMotion(),

                            // A pane can dismiss the Slidable.
                            // dismissible: DismissiblePane(onDismissed: () {}),

                            // All actions are defined in the children parameter.
                            children: [
                              // A SlidableAction can have an icon and/or a label.
                              SlidableAction(
                                onPressed: (BuildContext context) {
                                  courseData
                                      .removeAt(index); // Remove the course
                                  scores.removeAt(index); // R
                                  setState(() {});
                                },
                                backgroundColor: Color(0xFFFE4A49),
                                foregroundColor: Colors.white,
                                icon: Icons.delete,
                                label: 'Delete',
                              ),
                            ],
                          ),

                          // The end action pane is the one at the right or the bottom side.
                          endActionPane: ActionPane(
                            motion: ScrollMotion(),
                            children: [
                              SlidableAction(
                                // An action can be bigger than the others.
                                flex: 2,
                                onPressed: (BuildContext context) {
                                  showModalBottomSheet(
                                    context: context,
                                    backgroundColor:
                                        Colors.black38.withOpacity(0),
                                    builder: (context) => EditCourse(
                                      course: courseData[index],
                                      onTap: (course) {
                                        setState(() {
                                          courseData[index] = course;
                                        });
                                        Navigator.pop(context);
                                      },
                                    ),
                                  );
                                },
                                backgroundColor: Color(0xFF7BC043),
                                foregroundColor: Colors.white,
                                icon: Icons.edit,
                                label: 'Edit',
                              ),
                            ],
                          ),

                          child: SizedBox(
                            // height: 0,
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Text('${courseData[index]['name']}'),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Center(
                                    child: Text(
                                        '${courseData[index]['course code']}'),
                                  ),
                                ),
                                Expanded(
                                  child: Center(
                                    child:
                                        Text('${courseData[index]['units']}'),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Center(
                                    child: Container(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 15),
                                      decoration: BoxDecoration(
                                        color: Constants.white,
                                        borderRadius: BorderRadius.circular(10),
                                        border:
                                            Border.all(color: Constants.grey),
                                      ),
                                      child: DropdownButton<String>(
                                        underline: Container(),
                                        // hint: Text(""),
                                        value: scores[index] == '-1'
                                            ? null
                                            : scores[index],
                                        onChanged: (newValue) {
                                          setState(() {
                                            scores[index] = newValue!;
                                          });
                                        },
                                        items: grades
                                            .map<DropdownMenuItem<String>>(
                                                (String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value),
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                ),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: GestureDetector(
        onTap: () {
          showModalBottomSheet(
            context: context,
            backgroundColor: Colors.black38.withOpacity(0),
            builder: (context) => EditCourse(
              // course: courseData[index],
              onTap: (course) {
                setState(() {
                  scores.add('-1');

                  courseData.add(course);
                });
                Navigator.pop(context);
              },
            ),
          );
        },
        child: CircleAvatar(
          radius: 25,
          backgroundColor: Constants.black.withOpacity(.8),
          child: Center(
            child: Icon(
              Icons.add,
              color: Constants.white,
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 100,
        child: Center(
          child: CustomButton(
            loading: loading,
            onTap: widget.update != null && widget.index != null
                ? () async {
                    for (int i = 0; i < courseData.length; i++) {
                      if (scores[i] == '-1') {
                        MyMessageHandler.showSnackBar(
                            context, "Choose all options");
                        return;
                      }
                    }
                    String gpa = StatFunction.getResult(
                      scores: scores,
                      system: system,
                      courseData: courseData,
                    );
                    List<int> score = StatFunction.convertGradeToScore(scores,
                        system: system);
                    // print(result);
                    String cgpa = StatFunction.getCGPA(
                      currentCGPA: currentGpa,
                      result: gpa,
                      semester: semester,
                      level: level,
                    );

                    Update newUpdate = Update(
                      scores: score,
                      gradingSystem: system.toString(),
                      courseData: courseData,
                      gpa: double.parse(gpa),
                      cgpa: double.parse(cgpa),
                      level: level,
                      semester: semester,
                      past_semester: currentGpa,
                    );
                    setState(() {
                      loading = true;
                    });
                    try {
                      await StatFunction.editUpdates(
                          update: newUpdate,
                          index: widget.index!,
                          context: context);
                    } catch (e) {
                      MyMessageHandler.showSnackBar(
                          context, "Error Calculating new Update");
                    }
                    setState(() {
                      loading = false;
                    });
                  }
                : () {
                    for (int i = 0; i < courseData.length; i++) {
                      if (scores[i] == '-1') {
                        MyMessageHandler.showSnackBar(
                            context, "Choose all options");
                        return;
                      }
                    }
                    String gpa = StatFunction.getResult(
                      scores: scores,
                      system: system,
                      courseData: courseData,
                    );
                    // result =
                    List<int> score = StatFunction.convertGradeToScore(scores,
                        system: system);
                    // print(result);
                    String cgpa = StatFunction.getCGPA(
                      currentCGPA: currentGpa,
                      result: gpa,
                      semester: semester,
                      level: level,
                    );

                    StatFunction.saveUpdateGrade(
                      scores: score,
                      system: system,
                      courseData: courseData,
                      gpa: gpa,
                      cgpa: cgpa,
                      level: level,
                      semester: semester,
                      past_semester: currentGpa,
                    );
                    authProvider.incrementUser(cgpa: cgpa);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UpdateResult(
                          cgpa: cgpa,
                          current_gpa: currentGpa,
                        ),
                      ),
                    );
                  },
            title: "Update",
          ),
        ),
      ),
    );
  }
}
