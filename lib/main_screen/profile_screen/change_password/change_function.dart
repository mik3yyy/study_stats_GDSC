import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:study_stats/global_comonents/custom_messageHandler.dart';
import 'package:study_stats/models/user.dart';
import 'package:study_stats/providers/authProvider.dart';

class ChangeFunction {
  static Future<void> updatePassword(
      String userId, String newPassword, BuildContext context) async {
    var authProvider = Provider.of<AuthProvider>(context, listen: false);

    try {
      final userRef =
          FirebaseFirestore.instance.collection('users').doc(userId);
      await userRef.update({'password': newPassword});

      var user = await userRef.get();
      print(user.data());
      User u = User.fromJson(user.data() as Map<String, dynamic>);

      authProvider.saveUser(u);

      MyMessageHandler.showSnackBar(context, 'Password updated successfully',
          sucess: true);
      Navigator.pop(context);
      print('Password updated successfully');
    } catch (e) {
      print('Failed to update password: $e');
      MyMessageHandler.showSnackBar(
        context,
        'Failed to update password',
      );
    }
  }
}
