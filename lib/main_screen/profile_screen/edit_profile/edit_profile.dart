import 'package:dialog_alert/dialog_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dropdown/flutter_dropdown.dart';
import 'package:provider/provider.dart';
import 'package:study_stats/global_comonents/custom_button.dart';
import 'package:study_stats/global_comonents/custom_messageHandler.dart';
import 'package:study_stats/global_comonents/custom_textfield.dart';
import 'package:study_stats/main_screen/profile_screen/delete_account/delete_function.dart';
import 'package:study_stats/main_screen/profile_screen/upload_screen/upload_function.dart';
import 'package:study_stats/models/user.dart';
import 'package:study_stats/providers/authProvider.dart';
import 'package:study_stats/settings/hive_update.dart';

import '../../../auth_screen/fill_profile/fill_profile_function.dart';
import '../../../settings/constants.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
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

  bool dataChanged = false;
  bool loading2 = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var authProvider = Provider.of<AuthProvider>(context, listen: false);

    level = authProvider.user!.level!.toString();
    semester = authProvider.user!.semester!;
    _gpaController.text = authProvider.user!.currentCgpa!.toString();
    init();
  }

  init() async {
    var authProvider = Provider.of<AuthProvider>(context, listen: false);

    Universities = await FillProfileFunction.getUniversities();

    University = authProvider.user!.university!;

    faculties = await FillProfileFunction.getFaculty(
        context: context, uni: University!);
    faculty = authProvider.user!.faculty!;

    gradePoint = await FillProfileFunction.getGradePoint(
        context: context, uni: University);

    courses = await FillProfileFunction.getCourseFromFaculty(
        context: context, faculty: faculty, uni: University);
    course = authProvider.user!.course!;
    courseData = await FillProfileFunction.getCourseData(
        uni: University, faculty: faculty, course: course, context: context);

    setState(() {});
  }

  clearForUniveristy() {
    setState(() {
      faculty = '';
      // faculties = [];
      courses = [];
      course = '';
    });
  }

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
        title: Text("Profile"),
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
                    const Text(
                      "Let’s get you in, enter these details to get in",
                      style: TextStyle(
                        fontSize: 18,
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
                            color: University.isNotEmpty
                                ? Constants.black
                                : Constants.grey),
                      ),
                      child: DropdownButton<String>(
                        underline: Container(),
                        isExpanded: true,
                        hint: Text("Select University"),
                        value: University,
                        onChanged: (value) async {
                          faculties = await FillProfileFunction.getFaculty(
                              context: context, uni: value!);
                          gradePoint = await FillProfileFunction.getGradePoint(
                              context: context, uni: value);
                          if (University != value) {
                            setState(() {
                              University = value;
                              dataChanged = true;
                            });

                            clearForUniveristy();
                          }
                        },
                        items: Universities.map<DropdownMenuItem<String>>(
                            (String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
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
                            color: faculty.isNotEmpty
                                ? Constants.black
                                : Constants.grey),
                      ),
                      child: DropdownButton<String>(
                        underline: Container(),
                        isExpanded: true,
                        hint: Text("Select Faculty"),
                        value: faculty.isEmpty ? null : faculty,
                        onChanged: (value) async {
                          courses =
                              await FillProfileFunction.getCourseFromFaculty(
                                  context: context,
                                  faculty: value!,
                                  uni: University);
                          if (faculty != value) {
                            setState(() {
                              faculty = value;
                              dataChanged = true;
                            });
                            clearForfaculty();
                          }
                        },
                        items: faculties
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
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
                            color: faculty.isNotEmpty
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
                              dataChanged = true;
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
                        initialValue: level,
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
                            dataChanged = true;
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
                        initialValue: semester,
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
                            dataChanged = true;
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
                          dataChanged = true;

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
        height: 170,
        color: Colors.white,
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomButton(
                enable: dataChanged &&
                    Universities.isNotEmpty &&
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
                  if (semester == '1st' && level == '100') {
                    _gpaController.text = '-1.0';
                  }
                  if ((level != '100' || semester != '1st') &&
                      _gpaController.text == '-1.0') {
                    MyMessageHandler.showSnackBar(
                        context, "Invalid CGpa for ${University}");
                    setState(() {
                      loading = false;
                    });
                    return;
                  }
                  var authProvider =
                      Provider.of<AuthProvider>(context, listen: false);
                  User user = authProvider.user!;
                  if (dataChanged) {
                    final result = await showDialogAlert(
                      context: context,
                      title: 'Are you sure?',
                      message:
                          'This action would clear some of your data i.e past semesters',
                      actionButtonTitle: 'Edit',
                      cancelButtonTitle: 'Cancel',
                      actionButtonTextStyle: const TextStyle(
                        color: Colors.red,
                      ),
                      cancelButtonTextStyle: const TextStyle(
                        color: Colors.black,
                      ),
                    );
                    if (result == ButtonActionType.action) {
                      HiveUpdate.clearUpdateList();
                      await UploadFunction.deleteUserData(
                        userId: authProvider.user!.id,
                        context: context,
                      );
                      await authProvider.UpdateUser(
                        User(
                          id: user.id,
                          name: user.name,
                          email: user.email,
                          password: user.password,
                          matricNo: user.matricNo,
                          image: user.image,
                          university: University,
                          faculty: faculty,
                          course: course,
                          level: int.parse(level),
                          semester: semester,
                          currentCgpa: double.parse(_gpaController.text),
                          premium: user.premium,
                        ),
                      );
                      Map<String, dynamic> data =
                          await FillProfileFunction.getCourseData(
                        uni: University,
                        faculty: faculty,
                        course: course,
                        context: context,
                      );
                      await authProvider.saveCourseData(data);
                      Navigator.pop(context);
                      // ProfileFunction.LogOut(context);
                    }
                  }
                  // authProvider.fillData({
                  //   'university': University,
                  //   'faculty': faculty,
                  //   'course': course,
                  //   'level': level,
                  //   'semester': semester,
                  //   // (semester != '1st' && level != '100') ? semester : '-1',
                  //   'current_cgpa': (semester != '1st' && level != '100')
                  //       ? _gpaController.text
                  //       : '-1'
                  // });
                  // await FillProfileFunction.fillProfile(
                  //   user: authProvider.user!,
                  //   context: context,
                  //   data: courseData!,
                  // );
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
                title: "Edit",
                loading: loading,
              ),
              Constants.gap(height: 20),
              CustomButtonSecondary(
                loading: loading2,
                onTap: () async {
                  final result = await showDialogAlert(
                    context: context,
                    title: 'Delete Account',
                    message:
                        'Are sure you want to delete your profile, all data would be lost',
                    actionButtonTitle: 'Delete',
                    cancelButtonTitle: 'Cancel',
                    actionButtonTextStyle: const TextStyle(
                      color: Colors.red,
                    ),
                    cancelButtonTextStyle: const TextStyle(
                      color: Colors.black,
                    ),
                  );
                  setState(() {
                    loading2 = true;
                  });

                  if (result == ButtonActionType.action) {
                    await DeleteFunction.deleteUserById(
                        id: authProvider.user!.id, context: context);
                  } else {}
                  setState(() {
                    loading2 = false;
                  });
                },
                title: "Delete Profile",
                border: Border.all(
                  color: Colors.red,
                ),
                textColor: Colors.red,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
