import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:study_stats/global_comonents/custom_button.dart';
import 'package:study_stats/global_comonents/custom_messageHandler.dart';
import 'package:study_stats/global_comonents/custom_textfield.dart';
import 'package:study_stats/main_screen/profile_screen/upload_screen/upload_function.dart';
import 'package:study_stats/main_screen/stats_screen/dashboard_screen/dashboard_screen.dart';
import 'package:study_stats/main_screen/stats_screen/stats_function.dart';
import 'package:study_stats/providers/authProvider.dart';
import 'package:study_stats/settings/constants.dart';
import 'package:study_stats/settings/hive_goal.dart';

class SetGoalScreen extends StatefulWidget {
  const SetGoalScreen({key});

  @override
  State<SetGoalScreen> createState() => _SetGoalScreenState();
}

class _SetGoalScreenState extends State<SetGoalScreen> {
  final TextEditingController _goalController = TextEditingController();
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    var authProvider = Provider.of<AuthProvider>(context, listen: true);

    return Scaffold(
      appBar: AppBar(
        title: Text("Set your CGPA goal"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Column(
            children: [
              const Text(
                "Let's map out your academic journey! Enter your desired CGPA goal below, and we'll help you keep track of your progress.",
              ),
              Constants.gap(height: 10),
              CustomTextField(
                controller: _goalController,
                hintText: "Enter goal.",
                // keyboardType: TextInputType.numberWithOptions(),
                onChange: () {
                  setState(() {});
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 200,
        child: Center(
          child: CustomButton(
              loading: loading,
              enable: _goalController.text.isNotEmpty,
              onTap: () async {
                setState(() {
                  loading = true;
                });
                try {
                  var system = await StatFunction.getGradingSystem(context);
                  if (system < double.parse(_goalController.text)) {
                    MyMessageHandler.showSnackBar(
                        context, "Invalid GPA For your School");
                    setState(() {
                      loading = false;
                    });
                    return;
                  }
                  double value = double.parse(_goalController.text);
                  HiveGoal.saveGoal(value.toString());
                  // await UploadFunction.syncGoal(authProvider.user!.id);

                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DashboardScreen()));
                } catch (e) {
                  MyMessageHandler.showSnackBar(context, "Invalid GPA");
                }
                setState(() {
                  loading = false;
                });
              },
              title: "Next"),
        ),
      ),
    );
  }
}
