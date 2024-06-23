import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:study_stats/auth_screen/signin_screen/sign_in.dart';
import 'package:study_stats/global_comonents/custom_messageHandler.dart';
import 'package:study_stats/providers/authProvider.dart';
import 'package:study_stats/settings/notification.dart';

class DeleteFunction {
  static Future<void> deleteUserById(
      {required String id, required BuildContext context}) async {
    var authProvider = Provider.of<AuthProvider>(context, listen: false);

    try {
      await FirebaseFirestore.instance.collection('users').doc(id).delete();
      Navigator.pushNamedAndRemoveUntil(
          context, SignInScreen.id, (route) => false);
      authProvider.clearData();
      NotificationFunction.cancelAllNotifications();
      Navigator.pushNamedAndRemoveUntil(
          context, SignInScreen.id, (route) => false);
    } catch (e) {
      MyMessageHandler.showSnackBar(context, "Error deleting account");
    }
  }
}
