import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:study_stats/auth_screen/signin_screen/sign_in.dart';
import 'package:study_stats/auth_screen/signup_screen/signup.dart';
import 'package:study_stats/main_screen/main_screen.dart';
import 'package:study_stats/on_boarding_screen.dart';
import 'package:study_stats/providers/authProvider.dart';
import 'package:study_stats/settings/constants.dart';
import 'package:study_stats/settings/notification.dart';
import 'package:study_stats/settings/quotes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({key});
  static String id = '/splash';
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var authProvider = Provider.of<AuthProvider>(context, listen: false);

    var userBox = Hive.box('userBox');
    Quotes.set();

    Future.delayed(Duration(seconds: 2), () async {
      var user = await userBox.get('userKey');
      var data = await userBox.get('CourseData');

      if (user != null) {
        authProvider.saveUser(user);
        authProvider.saveCourseData(data);
        initU() {
          var user = Hive.box('userBox');
          // if (user.get('quote') == null) {
          //   Quotes.set();
          // }
        }

        Navigator.pushReplacementNamed(context, MainScreen.id);
      } else {
        try {
          // if (authProvider.checkUser()) {
          DateTime now = DateTime.now();
          DateTime nineAMToday;
          // if (user.get('quote') == null) {
          nineAMToday = DateTime(now.year, now.month, now.day, 9, 0, 0);
          // } else {
          //   nineAMToday = DateTime(now.year, now.month, now.day, 7, 0, 0);
          // }

          await NotificationFunction.scheduleDailyNotification(
            time: Constants.dateTimeToTimeOfDay(nineAMToday),
            id: 1,
            title: "Study Stats",
            body: "Track and predict your grades now",
          );
          Navigator.pushReplacementNamed(context, OnBoardingScreen.id);
          // } else {
          // Navigator.pushReplacementNamed(context, OnBoardingScreen.id);
        } catch (e) {
          Navigator.pushReplacementNamed(context, OnBoardingScreen.id);
        }
        // }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        // child: Image(image: ,)
        child: Image.asset("assets/image/onboarding/splash.png"),
      ),
    );
  }
}
