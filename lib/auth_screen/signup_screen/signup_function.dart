import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:study_stats/auth_screen/fill_profile/fill_profile.dart';
import 'package:study_stats/global_comonents/custom_messageHandler.dart';
import 'package:study_stats/models/user.dart';
import 'package:study_stats/providers/authProvider.dart';
import 'package:study_stats/settings/validators.dart';

class SignUpFunction {
  static void signUP(
      {required User user,
      required GlobalKey<ScaffoldMessengerState> scaffoldKey,
      required BuildContext context}) {
    var authProvider = Provider.of<AuthProvider>(context, listen: false);
    if (user.email.isValidEmail() == false) {
      MyMessageHandler.showSnackBar(context, "Enter Valid Email ");
      return;
    }
    if (user.name.split(' ').length > 3 || user.name.length > 25) {
      MyMessageHandler.showSnackBar(context, "Name too Long");
      return;
    }
    if (user.matricNo.isValidMatricNumber() == false) {
      MyMessageHandler.showSnackBar(context, "Invalid Matric Number");
      return;
    }
    if (user.password.isValidPassword() == false) {
      MyMessageHandler.showSnackBar(
          context, "Password must be at least 8 characters");
      return;
    }
    authProvider.initUser(user);
    Navigator.pushNamed(context, FillProfileScreen.id);
  }

  static Future<bool> doesEmailExist(String email) async {
    final collection = FirebaseFirestore.instance.collection('users');
    final querySnapshot =
        await collection.where('email', isEqualTo: email).limit(1).get();

    return querySnapshot.docs.isNotEmpty;
  }
}
