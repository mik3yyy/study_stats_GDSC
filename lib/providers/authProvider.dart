import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:study_stats/models/update.dart';
import 'package:study_stats/models/user.dart';
import 'package:study_stats/settings/hive_goal.dart';
import 'package:study_stats/settings/hive_quick.dart';
import 'package:study_stats/settings/hive_simulate.dart';
import 'package:study_stats/settings/hive_update.dart';

class AuthProvider extends ChangeNotifier {
  User? user;
  Map<dynamic, dynamic>? courseData;

  bool tutorial = true;
  bool checkUser() {
    var userBox = Hive.box('userBox');
    tutorial = userBox.get('new', defaultValue: true);
    userBox.put('new', false);
    return tutorial;
  }

  bool check() {
    var userBox = Hive.box('userBox');

    return userBox.get('new', defaultValue: true);
  }

  // checkUser() {}

  initUser(User u) {
    user = u;
    notifyListeners();
  }

  fillData(Map<String, dynamic> data) {
    user = User.fillData(user!, data);
    notifyListeners();
  }

  saveUser(User u) async {
    var userBox = Hive.box('userBox');
    // var box = await Hive.openBox<Donor>('userBox');
    await userBox.put('userKey', u);

    // var box2 = await Hive.openBox<BloodBank>('bankBox');
    user = u;
    notifyListeners();
  }

  saveCourseData(Map<dynamic, dynamic> data) async {
    var userBox = Hive.box('userBox');
    // var box = await Hive.openBox<Donor>('userBox');
    await userBox.put('CourseData', data);
    courseData = data;
    notifyListeners();
  }

  incrementUser({required String cgpa}) async {
    int level = user!.level!;
    String semester = user!.semester!;
    if (semester == "1st") {
      semester = '2nd';
    } else if (semester == "2nd") {
      if (courseData!['year'].toString() == level.toString().substring(0, 1)) {
      } else {
        semester = '1st';
        level = level + 100;
      }
    }
    User newUser = User(
      id: user!.id,
      name: user!.name,
      email: user!.email,
      password: user!.password,
      matricNo: user!.matricNo,
      image: user!.image,
      level: level,
      semester: semester,
      university: user!.university,
      course: user!.course,
      faculty: user!.faculty,
      currentCgpa: double.parse(cgpa),
      premium: user!.premium,
    );
    saveUser(newUser);
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    await firestore
        .collection('users')
        .doc(newUser.id.toString())
        .update(newUser.toJson());
    notifyListeners();
  }

  Future<void> UpdateUser(User u) async {
    user = u;
    saveUser(u);
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    await firestore.collection('users').doc(u.id.toString()).update(u.toJson());
    notifyListeners();
  }

  updateUserCGPA(String cgpa) async {
    User newUser = User(
      id: user!.id,
      name: user!.name,
      email: user!.email,
      password: user!.password,
      matricNo: user!.matricNo,
      image: user!.image,
      level: user!.level,
      semester: user!.semester,
      university: user!.university,
      course: user!.course,
      faculty: user!.faculty,
      currentCgpa: double.parse(cgpa),
      premium: user!.premium,
    );

    await UpdateUser(newUser);
    notifyListeners();
  }

  void clearData() {
    var userBox = Hive.box('userBox');
    userBox.delete('userKey');
    userBox.delete('CourseData');
    userBox.delete('quote');

    HiveGoal.clearQuickData();

    HiveQuick.clearQuickData();
    HiveSimulate.clearSimulateList();
    HiveUpdate.clearUpdateList();
    user = null;
    courseData = null;

    // notifyListeners();
  }
}
