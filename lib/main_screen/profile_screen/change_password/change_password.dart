import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:study_stats/global_comonents/custom_button.dart';
import 'package:study_stats/global_comonents/custom_messageHandler.dart';
import 'package:study_stats/global_comonents/custom_textfield.dart';
import 'package:study_stats/main_screen/profile_screen/change_password/change_function.dart';
import 'package:study_stats/providers/authProvider.dart';
import 'package:study_stats/settings/constants.dart';
import 'package:study_stats/settings/validators.dart';

class ChnagePassword extends StatefulWidget {
  const ChnagePassword({key});

  @override
  State<ChnagePassword> createState() => _ChnagePasswordState();
}

class _ChnagePasswordState extends State<ChnagePassword> {
  final TextEditingController _passwordController = TextEditingController();
  bool obscuretext = true;
  final TextEditingController _NpasswordController = TextEditingController();
  bool obscuretext2 = true;
  final TextEditingController _CpasswordController = TextEditingController();
  bool obscuretext3 = true;
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    var authProvider = Provider.of<AuthProvider>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Change Password'),
        actions: [
          Image.asset(
            'assets/image/Star.png',
          ),
          Constants.gap(width: 20)
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Old Password",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Constants.black,
              ),
            ),
            Constants.gap(height: 5),
            CustomTextField(
              controller: _passwordController,
              obscureText: obscuretext,
              hintText: "Enter Password",
              onChange: () {
                setState(() {});
              },
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    obscuretext = !obscuretext;
                  });
                },
                icon: obscuretext
                    ? Icon(Icons.visibility_outlined)
                    : Icon(Icons.visibility_off_outlined),
              ),
            ),
            Constants.gap(height: 20),
            Text(
              "New Password",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Constants.black,
              ),
            ),
            Constants.gap(height: 5),
            CustomTextField(
              controller: _NpasswordController,
              obscureText: obscuretext2,
              hintText: "Enter Password",
              onChange: () {
                setState(() {});
              },
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    obscuretext2 = !obscuretext2;
                  });
                },
                icon: obscuretext
                    ? Icon(Icons.visibility_outlined)
                    : Icon(Icons.visibility_off_outlined),
              ),
            ),
            Constants.gap(height: 20),
            Text(
              "Confirm Password",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Constants.black,
              ),
            ),
            Constants.gap(height: 5),
            CustomTextField(
              controller: _CpasswordController,
              obscureText: obscuretext3,
              hintText: "Enter Password",
              onChange: () {
                setState(() {});
              },
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    obscuretext3 = !obscuretext3;
                  });
                },
                icon: obscuretext
                    ? Icon(Icons.visibility_outlined)
                    : Icon(Icons.visibility_off_outlined),
              ),
            ),
            Constants.gap(height: 20),
            CustomButton(
              loading: loading,
              enable: _passwordController.text.isNotEmpty &&
                  _NpasswordController.text.isNotEmpty &&
                  _CpasswordController.text.isNotEmpty,
              onTap: () async {
                if (Constants.hashPassword(_passwordController.text) ==
                    authProvider.user!.password) {
                  if (_NpasswordController.text == _CpasswordController.text) {
                    if (_NpasswordController.text.isValidPassword()) {
                      setState(() {
                        loading = true;
                      });
                      await ChangeFunction.updatePassword(
                          authProvider.user!.id,
                          Constants.hashPassword(_NpasswordController.text),
                          context);
                      setState(() {
                        loading = false;
                      });
                    } else {
                      MyMessageHandler.showSnackBar(
                          context, "Password must be at least 8 characters");
                    }
                  } else {
                    MyMessageHandler.showSnackBar(
                        context, "Error Confirming Password");
                  }
                } else {
                  MyMessageHandler.showSnackBar(
                      context, "Enter your password correctly");
                }
              },
              title: "Change Password",
            )
          ],
        ),
      ),
    );
  }
}
