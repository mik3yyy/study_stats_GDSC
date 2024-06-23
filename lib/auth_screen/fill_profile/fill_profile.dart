import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dropdown/flutter_dropdown.dart';
import 'package:provider/provider.dart';
import 'package:study_stats/auth_screen/fill_profile/fill_profile_function.dart';
import 'package:study_stats/global_comonents/custom_button.dart';
import 'package:study_stats/global_comonents/custom_messageHandler.dart';
import 'package:study_stats/global_comonents/custom_text_button.dart';
import 'package:study_stats/global_comonents/custom_textfield.dart';
import 'package:study_stats/providers/authProvider.dart';
import 'package:study_stats/settings/constants.dart';

class FillProfileScreen extends StatefulWidget {
  const FillProfileScreen({key});
  static String id = '/fill_profile';
  @override
  State<FillProfileScreen> createState() => _FillProfileScreenState();
}

class _FillProfileScreenState extends State<FillProfileScreen> {
  final TextEditingController _gpaController = TextEditingController();
  bool obscuretext = true;

  bool loading = false;
  List<String> Universities = [];
  String University = "";
  List<String> faculties = [];
  String faculty = '';
  List<String> courses = [];
  String course = '';
  String level = '';
  String semester = '';

  Map<String, dynamic>? courseData;

  String gradePoint = '';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    init();
  }

  init() async {
    Universities = await FillProfileFunction.getUniversities();
    setState(() {});
  }

  // clearForUniveristy() {
  //   setState(() {
  //     faculty = '';
  //     courses = [];
  //     course = '';
  //   });
  // }

  clearForfaculty() {
    setState(() {
      course = '';
    });
  }

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
      body: SafeArea(
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Fill your profile",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const Text(
                      "Share your name, program, and university for a custom-tailored app experience designed exclusively for you.",
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                    Constants.gap(height: 20),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      decoration: BoxDecoration(
                        color: Constants.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                            color: University.isNotEmpty
                                ? Constants.black
                                : Constants.grey),
                      ),
                      child: DropDown(
                        isExpanded: true,
                        items: Universities,
                        showUnderline: false,
                        hint: Text("Select University"),
                        icon: Icon(
                          Icons.expand_more,
                          color: Constants.black,
                        ),
                        onChanged: (value) async {
                          faculties = await FillProfileFunction.getFaculty(
                              context: context, uni: value as String);
                          gradePoint = await FillProfileFunction.getGradePoint(
                              context: context, uni: value as String);
                          setState(() {
                            University = value as String;
                          });
                          // clearForUniveristy();
                        },
                      ),
                    ),
                    Constants.gap(height: 20),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      decoration: BoxDecoration(
                        color: Constants.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                            color: faculty.isNotEmpty
                                ? Constants.black
                                : Constants.grey),
                      ),
                      child: DropDown(
                        isExpanded: true,
                        items: faculties,
                        showUnderline: false,
                        hint: Text("Select Faculty"),
                        icon: Icon(
                          Icons.expand_more,
                          color: Constants.black,
                        ),
                        onChanged: (value) async {
                          courses =
                              await FillProfileFunction.getCourseFromFaculty(
                                  context: context,
                                  faculty: value as String,
                                  uni: University);
                          setState(() {
                            faculty = value;
                          });
                          clearForfaculty();
                        },
                      ),
                    ),
                    Constants.gap(height: 20),
                    Container(
                      width: MediaQuery.sizeOf(context).width * 0.9,
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      decoration: BoxDecoration(
                        color: Constants.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                            color: course.isNotEmpty
                                ? Constants.black
                                : Constants.grey),
                      ),
                      child: DropdownButton<String>(
                        underline: Container(),
                        isExpanded: true,
                        hint: Text("Select Course"),
                        value: course.isEmpty ? null : course,
                        onChanged: (value) async {
                          // faculties = await FillProfileFunction.getFaculty(
                          //     uni: value!);
                          if (course != value) {
                            setState(() {
                              course = value!;
                            });
                            courseData =
                                await FillProfileFunction.getCourseData(
                                    uni: University,
                                    faculty: faculty,
                                    course: course,
                                    context: context);
                            print(courseData);
                          }
                        },
                        items: courses
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                    Constants.gap(height: 20),
                    // Container(
                    //   padding: EdgeInsets.symmetric(horizontal: 15),
                    //   decoration: BoxDecoration(
                    //     color: Constants.white,
                    //     borderRadius: BorderRadius.circular(10),
                    //     border: Border.all(
                    //         color: course.isNotEmpty
                    //             ? Constants.black
                    //             : Constants.grey),
                    //   ),
                    //   child: DropDown(
                    //     isExpanded: true,
                    //     items: courses,
                    //     showUnderline: false,
                    //     hint: Text("Select Course"),
                    //     icon: Icon(
                    //       Icons.expand_more,
                    //       color: Constants.black,
                    //     ),
                    //     onChanged: (value) async {
                    //       // faculties = await FillProfileFunction.getFaculty(
                    //       //     uni: value!);
                    //       setState(() {
                    //         course = value!;
                    //       });
                    //       courseData = await FillProfileFunction.getCourseData(
                    //         uni: University,
                    //         faculty: faculty,
                    //         course: course,
                    //         context: context,
                    //       );
                    //       print(courseData);
                    //     },
                    //   ),
                    // ),
                    // Constants.gap(height: 20),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      decoration: BoxDecoration(
                        color: Constants.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                            color: level.isNotEmpty
                                ? Constants.black
                                : Constants.grey),
                      ),
                      child: DropDown(
                        isExpanded: true,
                        items: FillProfileFunction.levels,
                        showUnderline: false,
                        hint: Text("Select Level"),
                        icon: Icon(
                          Icons.expand_more,
                          color: Constants.black,
                        ),
                        onChanged: (value) async {
                          setState(() {
                            level = value as String;
                          });
                        },
                      ),
                    ),
                    Constants.gap(height: 20),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      decoration: BoxDecoration(
                        color: Constants.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                            color: semester.isNotEmpty
                                ? Constants.black
                                : Constants.grey),
                      ),
                      child: DropDown(
                        isExpanded: true,
                        items: FillProfileFunction.semester,
                        showUnderline: false,
                        hint: Text("Select Semester"),
                        icon: Icon(
                          Icons.expand_more,
                          color: Constants.black,
                        ),
                        onChanged: (value) async {
                          setState(() {
                            semester = value as String;
                          });
                        },
                      ),
                    ),
                    Constants.gap(height: 20),
                    if (semester != '1st' || level != '100')
                      CustomTextField(
                        controller: _gpaController,
                        hintText: "Current CGPA",
                        keyboardType: const TextInputType.numberWithOptions(
                            decimal: true),
                        onChange: () {
                          setState(() {});
                        },
                      ),
                    Constants.gap(height: 500),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      bottomSheet: Container(
        height: 130,
        color: Colors.white,
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomButton(
                enable: Universities.isNotEmpty &&
                    faculty.isNotEmpty &&
                    course.isNotEmpty &&
                    level.isNotEmpty &&
                    semester.isNotEmpty &&
                    ((semester == '1st' && level == '100') ||
                        _gpaController.text.isNotEmpty) &&
                    gradePoint.isNotEmpty &&
                    courseData != null,
                onTap: () async {
                  setState(() {
                    loading = true;
                  });
                  if (int.parse(level.substring(0, 1)) >
                      int.parse(courseData!['year'].toString())) {
                    MyMessageHandler.showSnackBar(
                        context, "Your Level is Incorrect");
                    setState(() {
                      loading = false;
                    });
                    return;
                  }
                  try {
                    if (double.parse(gradePoint.toString()) <
                        double.parse(_gpaController.text)) {
                      MyMessageHandler.showSnackBar(
                          context, "Invalid CGpa for ${University}");
                      setState(() {
                        loading = false;
                      });
                      return;
                    }
                  } catch (e) {
                    if (_gpaController.text.isNotEmpty) {
                      MyMessageHandler.showSnackBar(
                          context, "Invalid CGpa for ${University}");
                      setState(() {
                        loading = false;
                      });
                      return;
                    }
                  }
                  print(semester);
                  print(level);
                  print((semester == '1st' && level == '100'));
                  authProvider.fillData({
                    'university': University,
                    'faculty': faculty,
                    'course': course,
                    'level': level,
                    'semester': semester,
                    // (semester != '1st' && level != '100') ? semester : '-1',
                    'current_cgpa': (semester == '1st' && level == '100')
                        ? '-1'
                        : _gpaController.text
                  });
                  await FillProfileFunction.fillProfile(
                    user: authProvider.user!,
                    context: context,
                    data: courseData!,
                  );
                  setState(() {
                    loading = false;
                  });

                  //               university: data['university'],
                  // faculty: data['faculty'],
                  // course: data['course'],
                  // level: data['level'],
                  // semester: data['semester'],
                  // currentCgpa: data['current_cgpa'],
                  // premium: data['premium'] ?? user.premium, // Updated to include premium
                },
                title: "Submit",
                loading: loading,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
