import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:study_stats/auth_screen/fill_profile/fill_profile_function.dart';
import 'package:study_stats/global_comonents/custom_messageHandler.dart';
import 'package:study_stats/main_screen/main_screen.dart';
import 'package:study_stats/models/quick.dart';
import 'package:study_stats/models/simulate.dart';
import 'package:study_stats/models/update.dart';
import 'package:study_stats/providers/authProvider.dart';
import 'package:study_stats/settings/hive_goal.dart';
import 'package:study_stats/settings/hive_quick.dart';
import 'package:study_stats/settings/hive_simulate.dart';
import 'package:study_stats/settings/hive_update.dart';

class StatFunction {
  static Future<bool> getGoalPossibility(BuildContext context) async {
    var authProvider = Provider.of<AuthProvider>(context, listen: false);

    int year = authProvider.courseData!['year'];
    double current_Gpa = authProvider.user!.currentCgpa!;
    if (current_Gpa == -1) {
      return true;
    }
    var currrent_semester = StatFunction.getCurrentSemester(
        authProvider.user!.semester!, authProvider.user!.level!);

    int semester_length = year * 2;
    var goal = HiveGoal.getGoal();
    int system = await StatFunction.getGradingSystem(context);

    int semester_left = (semester_length - (currrent_semester - 1));

    double highest_gpa =
        (((semester_left) * system) + (current_Gpa * (currrent_semester - 1))) /
            semester_length;
    // print(highest_gpa);
    // print(goal);
    // print(highest_gpa >= double.parse(goal));
    return highest_gpa >= double.parse(goal);
  }

  static Future<int> getGradingSystem(BuildContext context) async {
    var authProvider = Provider.of<AuthProvider>(context, listen: false);
    var user = authProvider.user;
    String uni = FillProfileFunction.convertTexttoFileName(user!.university!);

    var res =
        await FillProfileFunction.loadJsonData(url: 'schools/${uni}/main.json');
    int grading_system = res['grading-system'];
    return grading_system;
  }

  static List<int> convertGradeToScore(List<String> grades,
      {required int system}) {
    List<int> score = [];
    for (String g in grades) {
      switch (g) {
        case 'A':
          score.add(5);
          break;
        case 'B':
          score.add(4);
          break;
        case 'C':
          score.add(3);
          break;
        case 'D':
          score.add(2);
          break;
        case 'E':
          score.add(1);
          break;
        case 'F':
          score.add(0);
          break;
      }
    }
    return score;
  }

  static List<String> convertScoreToGrade(List scores, {required int system}) {
    List<String> grades = [];
    for (int g in scores) {
      switch (g) {
        case 5:
          grades.add('A');
          break;
        case 4:
          grades.add('B');
          break;
        case 3:
          grades.add('C');
          break;
        case 2:
          grades.add('D');
          break;
        case 1:
          grades.add('E');
          break;
        case 0:
          grades.add('F');
          break;
      }
    }
    return grades;
  }

  static String getResult({
    required List<String> scores,
    required int system,
    required List courseData,
  }) {
    double uXg = 0;
    double units = 0;
    double result = 0;
    List<int> score = StatFunction.convertGradeToScore(scores, system: system);

    for (int i = 0; i < courseData.length; i++) {
      uXg += courseData[i]['units'] * score[i];
      units += courseData[i]['units'];
    }
    result = uXg / units;
    // print(result);
    return result.toString();
  }

  static String getCGPA({
    required String currentCGPA,
    required String result,
    required String semester,
    required String level,
  }) {
    double cgpa = double.parse(currentCGPA);
    double gpa = double.parse(result);
    var sem = int.parse(semester.substring(0, 1));
    var lev = int.parse(level.substring(0, 1));
    // print(currentCGPA);
    if (currentCGPA == '-1.0') {
      return result;
    }
    var currrent_semester = getCurrentSemester(semester, int.parse(level));

    var newPa = ((cgpa * (currrent_semester - 1)) + gpa) / currrent_semester;

    return newPa.toStringAsFixed(2);
  }

  static int getCurrentSemester(String semester, int level) {
    // Validate inputs
    // if (!['1st', '2nd'].contains(semester)) {
    //   throw ArgumentError("Invalid semester. Please enter '1st' or '2nd'.");
    // }
    // if (level % 100 != 0 || level < 100) {
    //   throw ArgumentError(
    //       "Invalid level. Levels should be positive multiples of 100.");
    // }

    // Calculate the current semester number
    // Subtract 100 from the level and divide by 100 to get the number of levels completed,
    // then multiply by 2 to get the number of semesters completed in those levels.
    // Finally, add 1 if it's the "2nd" semester.
    int semesterNumber = ((level - 100) / 100 * 2).toInt();
    if (semester == '2nd') {
      semesterNumber += 1;
    }

    return semesterNumber + 1; // +1 to account for the current semester
  }

  static saveQuickGrade({
    required List<int> scores,
    required int system,
    required List courseData,
    required String result,
    required String level,
    required String semester,
  }) {
    HiveQuick.addQuickData(Quick(
      result: result,
      gradingSystem: system.toString(),
      scores: scores,
      courseData: courseData,
      level: level,
      semester: semester,
    ));
  }

  static saveSimulateGrade(
      {required List<int> scores,
      required int system,
      required List courseData,
      required String gpa,
      required String cgpa,
      required String level,
      required String semester,
      required String past_gpa}) {
    HiveSimulate.addSimulateData(
      Simulate(
        gpa: double.parse(gpa),
        cgpa: double.parse(cgpa),
        gradingSystem: system.toString(),
        scores: scores,
        courseData: courseData,
        level: level,
        semester: semester,
        past_gpa: double.parse(past_gpa),
      ),
    );
  }

  static Future<void> saveUpdateGrade({
    required List<int> scores,
    required int system,
    required List courseData,
    required String gpa,
    required String cgpa,
    required String level,
    required String semester,
    required String past_semester,
  }) async {
    HiveUpdate.addUpdateData(
      Update(
        gpa: double.parse(gpa),
        cgpa: double.parse(cgpa),
        gradingSystem: system.toString(),
        scores: scores,
        courseData: courseData,
        level: level,
        semester: semester,
        past_semester: past_semester,
      ),
    );
  }

  static Future<void> editUpdates(
      {required Update update,
      required int index,
      required BuildContext context}) async {
    var oldUpdateList = HiveUpdate.getUpdateList().reversed.toList();
    var authProvider = Provider.of<AuthProvider>(context, listen: false);

    for (int i = oldUpdateList.length - 1; i >= 0; i--) {
      if (i > index) {
      } else if (i == index) {
        oldUpdateList[i] = update;
        if (0 == i) {
          HiveUpdate.replaceUpdateList(oldUpdateList.reversed.toList());
          await authProvider.updateUserCGPA(update.cgpa.toString());
          MyMessageHandler.showSnackBar(
              context, "Successful, Your Current Gpa has been edited",
              sucess: true);
          Navigator.pushNamedAndRemoveUntil(
              context, MainScreen.id, (route) => false);
        }
      } else {
        Update newUpdate = StatFunction.replaceUpdate(
            thisSemester: oldUpdateList[i],
            past_semester: oldUpdateList[i + 1]);
        oldUpdateList[i] = newUpdate;

        if (0 == i) {
          HiveUpdate.replaceUpdateList(oldUpdateList.reversed.toList());
          await authProvider.updateUserCGPA(newUpdate.cgpa.toString());
          MyMessageHandler.showSnackBar(
              context, "Successful, Your Current Gpa has been edited",
              sucess: true);
          Navigator.pushNamedAndRemoveUntil(
              context, MainScreen.id, (route) => false);
        }
      }
    }
  }

  static Update replaceUpdate(
      {required Update thisSemester, required Update past_semester}) {
    String cgpa = StatFunction.getCGPA(
      currentCGPA: past_semester.cgpa.toString(),
      result: thisSemester.gpa.toString(),
      semester: thisSemester.semester,
      level: thisSemester.level,
    );
    Update newUpdate = Update(
      scores: thisSemester.scores,
      gradingSystem: thisSemester.gradingSystem.toString(),
      courseData: thisSemester.courseData,
      gpa: thisSemester.gpa,
      cgpa: double.parse(cgpa),
      level: thisSemester.level,
      semester: thisSemester.semester,
      past_semester: past_semester.cgpa.toString(),
    );
    return newUpdate;
  }
}
