import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:study_stats/global_comonents/custom_messageHandler.dart';
import 'package:study_stats/models/quick.dart';
import 'package:study_stats/models/simulate.dart';
import 'package:study_stats/models/update.dart';
import 'package:study_stats/settings/hive_goal.dart';
import 'package:study_stats/settings/hive_quick.dart';
import 'package:study_stats/settings/hive_simulate.dart';
import 'package:study_stats/settings/hive_update.dart';

class UploadFunction {
  /////SYNC VALUES
  static Future<void> syncQuick(
      {required String id, required BuildContext context}) async {
    List quicks = HiveQuick.getQuickList();
    List uploadQuicks =
        quicks.where((element) => element.uploaded == false).toList();

    final CollectionReference quicksCollection =
        FirebaseFirestore.instance.collection('UserData');

    final userQuicksCollection =
        quicksCollection.doc(id).collection('UserQuicks');

    for (Quick quick in uploadQuicks) {
      // Each Quick model is converted to a Map and uploaded
      await userQuicksCollection.add(quick.toJson());
    }

    final QuerySnapshot userQuicksSnapshot = await quicksCollection
        .doc(id)
        .collection('UserQuicks')
        .orderBy('timestamp', descending: false) // or true for descending order
        .get();
    // print("jkblbzs=--------------");
    List<Quick> newQuicks = userQuicksSnapshot.docs
        .map((doc) => Quick.fromJson(doc.data() as Map<String, dynamic>))
        .toList();
    HiveQuick.replaceQuickList(newQuicks);
  }

  static Future<void> syncSimulate(
      {required String id, required BuildContext context}) async {
    List quicks = HiveSimulate.getSimulateList();

    List uploadQuicks =
        quicks.where((element) => element.uploaded == false).toList();

    // print(uploadQuicks);
    final CollectionReference quicksCollection =
        FirebaseFirestore.instance.collection('UserData');

    final userQuicksCollection =
        quicksCollection.doc(id).collection('UserSimulations');
    // print(uploadQuicks[0].toString());
    for (Simulate quick in uploadQuicks) {
      print(quick.toString());
      // print(quick.toString())
      // Each Quick model is converted to a Map and uploaded
      await userQuicksCollection.add(quick.toJson());
    }
    //

    final QuerySnapshot userQuicksSnapshot = await quicksCollection
        .doc(id)
        .collection('UserSimulations')
        .orderBy('timestamp', descending: false) // or true for descending order
        .get();

    List<Simulate> newQuicks = userQuicksSnapshot.docs
        .map((doc) => Simulate.fromJson(doc.data() as Map<String, dynamic>))
        .toList();
    HiveSimulate.replaceSimulateList(newQuicks);
  }

  static Future<void> syncUpdate(
      {required String id, required BuildContext context}) async {
    List quicks = HiveUpdate.getUpdateList();
    List uploadQuicks =
        quicks.where((element) => element.uploaded == false).toList();

    final CollectionReference quicksCollection =
        FirebaseFirestore.instance.collection('UserData');

    final userQuicksCollection =
        quicksCollection.doc(id).collection('UserUpdates');

    for (Update quick in uploadQuicks) {
      // Each Quick model is converted to a Map and uploaded
      await userQuicksCollection.add(quick.toJson());
    }

    final QuerySnapshot userQuicksSnapshot = await quicksCollection
        .doc(id)
        .collection('UserUpdates')
        .orderBy('timestamp', descending: false) // or true for descending order
        .get();

    List<Update> newQuicks = userQuicksSnapshot.docs
        .map((doc) => Update.fromJson(doc.data() as Map<String, dynamic>))
        .toList();
    HiveUpdate.replaceUpdateList(newQuicks);
  }

  static Future<void> syncGoal(String id) async {
    String goal = HiveGoal.getGoal();
    final CollectionReference quicksCollection =
        FirebaseFirestore.instance.collection('UserData');
    if (goal.isEmpty) {
      // Reference to the user's UserQuicks subcollection
      final QuerySnapshot userGoal =
          await quicksCollection.doc(id).collection('Goal').limit(1).get();
      if (userGoal.docs.isNotEmpty) {
        HiveGoal.saveGoal(userGoal.docs[0]['goal']);

        // var batch = FirebaseFirestore.instance.batch();

        // for (DocumentSnapshot doc in userGoal.docs) {
        //   batch.delete(doc.reference); // Add delete operation to batch
        // }
        // batch.commit();
      }
    } else {
      final QuerySnapshot userGoal =
          await quicksCollection.doc(id).collection('Goal').get();

      var batch = FirebaseFirestore.instance.batch();

      for (DocumentSnapshot doc in userGoal.docs) {
        batch.delete(doc.reference); // Add delete operation to batch
      }
      batch.commit();
      //  userQuicksCollection.add(quick.toJson());
      final CollectionReference Goal =
          quicksCollection.doc(id).collection('Goal');
      await Goal.add({'goal': HiveGoal.getGoal()});
    }
  }

//DELETE VALUES
  static Future<void> deleteUserQuicks(String userId) async {
    final CollectionReference quicksCollection =
        FirebaseFirestore.instance.collection('UserData');

    // Reference to the user's UserQuicks subcollection
    final CollectionReference userQuicksCollection =
        quicksCollection.doc(userId).collection('UserQuicks');

    // Retrieve all documents in the UserQuicks collection
    final QuerySnapshot snapshot = await userQuicksCollection.get();

    // Firestore transactions or batched writes can also be used for efficiency
    var batch = FirebaseFirestore.instance.batch();

    for (DocumentSnapshot doc in snapshot.docs) {
      batch.delete(doc.reference); // Add delete operation to batch
    }

    // Commit the batch
    return batch.commit().catchError((error) {
      print("Error deleting user quicks: $error");
    });
  }

  static Future<void> deleteUserSimulations(String userId) async {
    final CollectionReference quicksCollection =
        FirebaseFirestore.instance.collection('UserData');

    // Reference to the user's UserQuicks subcollection
    final CollectionReference userQuicksCollection =
        quicksCollection.doc(userId).collection('UserSimulations');

    // Retrieve all documents in the UserQuicks collection
    final QuerySnapshot snapshot = await userQuicksCollection.get();

    // Firestore transactions or batched writes can also be used for efficiency
    var batch = FirebaseFirestore.instance.batch();

    for (DocumentSnapshot doc in snapshot.docs) {
      batch.delete(doc.reference); // Add delete operation to batch
    }

    // Commit the batch
    return batch.commit().catchError((error) {
      print("Error deleting user quicks: $error");
    });
  }

  static Future<void> deleteUserUpdates(String userId) async {
    final CollectionReference quicksCollection =
        FirebaseFirestore.instance.collection('UserData');

    // Reference to the user's UserQuicks subcollection
    final CollectionReference userQuicksCollection =
        quicksCollection.doc(userId).collection('UserUpdates');

    // Retrieve all documents in the UserQuicks collection
    final QuerySnapshot snapshot = await userQuicksCollection.get();

    // Firestore transactions or batched writes can also be used for efficiency
    var batch = FirebaseFirestore.instance.batch();

    for (DocumentSnapshot doc in snapshot.docs) {
      batch.delete(doc.reference); // Add delete operation to batch
    }

    // Commit the batch
    return batch.commit().catchError((error) {
      print("Error deleting user quicks: $error");
    });
  }

  static Future<void> deleteUserData(
      {required String userId, required BuildContext context}) async {
    try {
      // await UploadFunction.deleteUserQuicks(userId);
      // await UploadFunction.deleteUserSimulations(userId);
      await UploadFunction.deleteUserUpdates(userId);
    } catch (e) {
      MyMessageHandler.showSnackBar(context, "Unable to Deleter User data");
    }
  }
}
