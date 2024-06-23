import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:study_stats/Firebase/storage.dart';
import 'package:study_stats/auth_screen/fill_profile/fill_profile_function.dart';
import 'package:study_stats/global_comonents/custom_messageHandler.dart';
import 'package:study_stats/main_screen/main_screen.dart';
import 'package:study_stats/main_screen/profile_screen/upload_screen/upload_screen.dart';
import 'package:study_stats/models/user.dart';
import 'package:study_stats/providers/authProvider.dart';
import 'package:study_stats/settings/constants.dart';
import 'package:study_stats/settings/notification.dart';
import 'package:study_stats/settings/quotes.dart';

class LoginFunction {
  static login({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    var authProvider = Provider.of<AuthProvider>(context, listen: false);
    try {
      Map<String, dynamic> userDoc =
          await FirebaseStorageApi.userDoc(email: email, collection: 'users');
      print(userDoc);
      if (userDoc.isNotEmpty) {
        User user = User.fromJson(userDoc);
        print(user.password);
        if (user.password == Constants.hashPassword(password)) {
          authProvider.saveUser(user);
          Map<String, dynamic> data = await FillProfileFunction.getCourseData(
            uni: user.university!,
            faculty: user.faculty!,
            course: user.course!,
            context: context,
          );
          authProvider.saveCourseData(data);
          if (user.premium) {
            // bool accepted = await NotificationFunction.requestPermissions();

            // if (accepted) {
            await Quotes.set();
            // }
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (context) => UploadScreen(
                          auth: true,
                        )),
                (route) => false);
          } else {
            // bool accepted = await NotificationFunction.requestPermissions();
            await Quotes.set();

            // if (accepted) {
            //   await Quotes.set();
            // }
            Navigator.pushNamedAndRemoveUntil(
                context, MainScreen.id, (route) => false);
          }
        } else {
          MyMessageHandler.showSnackBar(context, "Wrong email or password");
        }
      } else {
        MyMessageHandler.showSnackBar(context, "Cannot find user");
      }
    } catch (e) {
      MyMessageHandler.showSnackBar(context, "Check your network");
    }
  }
}
