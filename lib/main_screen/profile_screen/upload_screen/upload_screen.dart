import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:study_stats/global_comonents/custom_button.dart';
import 'package:study_stats/global_comonents/custom_messageHandler.dart';
import 'package:study_stats/main_screen/main_screen.dart';
import 'package:study_stats/main_screen/profile_screen/upload_screen/upload_function.dart';
import 'package:study_stats/settings/constants.dart';

import '../../../providers/authProvider.dart';

class UploadScreen extends StatefulWidget {
  const UploadScreen({key, this.auth = false});
  final bool auth;
  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  bool loading = false;
  bool quickHistory = true;
  bool updateHistory = true;
  bool simulationHistory = true;

  @override
  Widget build(BuildContext context) {
    var authProvider = Provider.of<AuthProvider>(context, listen: true);

    return Scaffold(
      appBar: AppBar(
        title: Text('Sync Data'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Expanded(
              child: Icon(
                loading ? Icons.cloud_upload : Icons.cloud,
                size: 200.0,
                color: Constants.grey,
              ),
            ),
            loading == false
                ? Expanded(
                    flex: 2,
                    child: Column(
                      children: [
                        // SizedBox(
                        //     height:
                        //         20), // Adds space between the icon and the text
                        Text(
                          'Sync Your Data',
                          style: TextStyle(
                            fontSize: 28.0,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Constants.gap(height: 50),
                        Container(
                          padding: EdgeInsets.all(8),
                          height: 70,
                          decoration: BoxDecoration(
                            border: Border.all(color: Constants.blue),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            // crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "Quick History".toUpperCase(),
                                style: TextStyle(
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    quickHistory = !quickHistory;
                                  });
                                },
                                icon: Icon(
                                  quickHistory
                                      ? Icons.toggle_on
                                      : Icons.toggle_off,
                                  size: 30,
                                  color: quickHistory ? Constants.blue : null,
                                ),
                              )
                            ],
                          ),
                        ),
                        Constants.gap(height: 20),
                        Container(
                          padding: EdgeInsets.all(8),
                          height: 70,
                          decoration: BoxDecoration(
                            border: Border.all(color: Constants.blue),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            // crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "Simulations History".toUpperCase(),
                                style: TextStyle(
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    simulationHistory = !simulationHistory;
                                  });
                                },
                                icon: Icon(
                                  simulationHistory
                                      ? Icons.toggle_on
                                      : Icons.toggle_off,
                                  size: 30,
                                  color:
                                      simulationHistory ? Constants.blue : null,
                                ),
                              )
                            ],
                          ),
                        ),
                        Constants.gap(height: 20),
                        Container(
                          padding: EdgeInsets.all(8),
                          height: 70,
                          decoration: BoxDecoration(
                            border: Border.all(color: Constants.blue),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            // crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "Update History".toUpperCase(),
                                style: TextStyle(
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    updateHistory = !updateHistory;
                                  });
                                },
                                icon: Icon(
                                  updateHistory
                                      ? Icons.toggle_on
                                      : Icons.toggle_off,
                                  size: 30,
                                  color: updateHistory ? Constants.blue : null,
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                : Expanded(
                    child: Column(
                      children: [
                        SizedBox(
                            height:
                                20), // Adds space between the icon and the text
                        Text(
                          'Uploading your data to our database...',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 100,
        child: Column(
          children: [
            CustomButton(
              // enable: authProvider.user!.premium,
              loading: loading,
              onTap: () async {
                setState(() {
                  loading = true;
                });
                try {
                  if (quickHistory)
                    await UploadFunction.syncQuick(
                        id: authProvider.user!.id, context: context);
                  print("object");
                  if (simulationHistory)
                    await UploadFunction.syncSimulate(
                        id: authProvider.user!.id, context: context);
                  print("object");

                  if (updateHistory)
                    await UploadFunction.syncUpdate(
                        id: authProvider.user!.id, context: context);
                  print("object");

                  await UploadFunction.syncGoal(authProvider.user!.id);
                  MyMessageHandler.showSnackBar(
                    context,
                    "Syncing Successful",
                    sucess: true,
                  );

                  if (widget.auth) {
                    Navigator.pushNamedAndRemoveUntil(
                        context, MainScreen.id, (route) => false);
                  } else {
                    Navigator.pop(context);
                  }
                } catch (e) {
                  print(e.toString());
                  MyMessageHandler.showSnackBar(context, "Unable to sync");
                }
                setState(() {
                  loading = false;
                });
              },
              title: "Sync Data ",
            ),
          ],
        ),
      ),
    );
  }
}
