import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:provider/provider.dart';
import 'dart:convert';

import 'package:study_stats/global_comonents/custom_messageHandler.dart';
import 'package:study_stats/main_screen/main_screen.dart';
import 'package:study_stats/models/user.dart';
import 'package:study_stats/providers/authProvider.dart';
import 'package:study_stats/settings/notification.dart';
import 'package:study_stats/settings/quotes.dart';

class FillProfileFunction {
  static String basesString = 'assets/data/';
  static Future<Map<String, dynamic>> loadJsonData(
      {required String url}) async {
    final jsonString = await rootBundle.loadString("${basesString}$url");
    final jsonData = json.decode(jsonString);

    return jsonData;
  }

  static Future<List<String>> getUniversities() async {
    var res = await loadJsonData(url: 'main.json');
    List<dynamic> list = res['schools'];
    return list.map((dynamic item) => item.toString()).toList();
  }

  static Future<List<String>> getFaculty({
    required String uni,
    required BuildContext context,
  }) async {
    try {
      uni = convertTexttoFileName(uni);
      var res = await loadJsonData(url: 'schools/$uni/main.json');
      List<dynamic> list = res['faculties'];
      return list.map((dynamic item) => item.toString()).toList();
    } catch (e) {
      MyMessageHandler.showSnackBar(context, "Unable to get Faculties");
      return [];
    }
  }

  static Future<String> getGradePoint({
    required String uni,
    required BuildContext context,
  }) async {
    try {
      uni = convertTexttoFileName(uni);
      var res = await loadJsonData(url: 'schools/$uni/main.json');
      List<dynamic> list = res['faculties'];
      return res['grading-system'].toString();
    } catch (e) {
      MyMessageHandler.showSnackBar(context, "Unable to get Grade Point");
      return '';
    }
  }

  static Future<List<String>> getCourseFromFaculty({
    required String uni,
    required String faculty,
    required BuildContext context,
  }) async {
    try {
      uni = convertTexttoFileName(uni);
      // faculty = convertTexttoFileName(faculty);
      var res = await loadJsonData(url: 'schools/$uni/Faculty/$faculty.json');
      List<dynamic> list = res['courses'];
      return list.map((dynamic item) => item.toString()).toList();
    } catch (e) {
      MyMessageHandler.showSnackBar(context, "Unable to get Courses");
      return [];
    }
  }

  static Future<Map<String, dynamic>> getCourseData({
    required String uni,
    required String faculty,
    required String course,
    required BuildContext context,
  }) async {
    try {
      uni = convertTexttoFileName(uni);
      // faculty = convertTexttoFileName(faculty);
      var res = await loadJsonData(url: 'schools/$uni/Faculty/$faculty.json');
      Map<String, dynamic> courseData = res[course];
      return courseData;
    } catch (e) {
      MyMessageHandler.showSnackBar(context, "Unable to get Course Data");
      return {};
    }
  }

  static String convertTexttoFileName(String text) {
    return text.replaceAllMapped(' ', (match) => '_');
  }

  static List<String> levels = ["100", "200", "300", "400", "500", "600"];
  static List<String> semester = [
    "1st",
    "2nd",
  ];

  static Future<void> fillProfile(
      {required User user,
      required BuildContext context,
      required Map<String, dynamic> data}) async {
    try {
      var authProvider = Provider.of<AuthProvider>(context, listen: false);

      FirebaseFirestore firestore = FirebaseFirestore.instance;
      await firestore
          .collection('users')
          .doc(user.id.toString())
          .set(user.toJson());
      authProvider.saveUser(user);
      authProvider.saveCourseData(data);

      // bool accepted = await NotificationFunction.requestPermissions();

      // if (accepted) {
      await Quotes.set();
      // }
      Navigator.pushNamedAndRemoveUntil(
          context, MainScreen.id, (route) => false);
    } catch (e) {
      MyMessageHandler.showSnackBar(context, "Unbale to sign up");
    }
  }
}
