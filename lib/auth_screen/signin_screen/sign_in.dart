import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:study_stats/auth_screen/signin_screen/sign_in_function.dart';
import 'package:study_stats/auth_screen/signup_screen/signup.dart';
import 'package:study_stats/global_comonents/custom_button.dart';
import 'package:study_stats/global_comonents/custom_messageHandler.dart';
import 'package:study_stats/global_comonents/custom_text_button.dart';
import 'package:study_stats/global_comonents/custom_textfield.dart';
import 'package:study_stats/settings/constants.dart';
import 'package:study_stats/settings/validators.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({key});
  static String id = "/sign_in";
  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();
  bool obscuretext = true;
  final GlobalKey<ScaffoldMessengerState> scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      key: scaffoldKey,
      child: Scaffold(
        appBar: AppBar(
          actions: [
            Image.asset(
              'assets/image/Star.png',
            ),
            Constants.gap(width: 20)
          ],
        ),
        body: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: SafeArea(
            child: Container(
              height: MediaQuery.sizeOf(context).height * 0.8,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    // Container(
                    //   height: MediaQuery.sizeOf(context).height * .3,
                    //   child: Image.asset("assets/image/onboarding/splash.png"),
                    // ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Hi, Welcome!👋",
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Constants.gap(height: 20),
                        Text(
                          "Email",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Constants.black,
                          ),
                        ),
                        Constants.gap(height: 5),
                        CustomTextField(
                          controller: _emailController,
                          hintText: "Enter email address",
                          onChange: () {
                            setState(() {});
                          },
                        ),
                        Constants.gap(height: 20),
                        Text(
                          "Password",
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
                        Constants.gap(height: 30),
                        CustomButton(
                          enable: _emailController.text.isNotEmpty &&
                              _passwordController.text.isNotEmpty,
                          onTap: () async {
                            if (_emailController.text.isValidEmail()) {
                              setState(() {
                                loading = true;
                              });

                              await LoginFunction.login(
                                context: context,
                                email: _emailController.text.toLowerCase(),
                                password: _passwordController.text,
                              );
                              setState(() {
                                loading = false;
                              });
                            } else {
                              MyMessageHandler.showSnackBar(
                                  context, "Enter Valid Email");
                            }
                          },
                          title: "Log in",
                          loading: loading,
                        ),
                      ],
                    ),
                    Constants.gap(height: 30),
                  ],
                ),
              ),
            ),
          ),
        ),
        bottomNavigationBar: Container(
          height: 100,
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don't havce an account? "),
                    CustomTextButton(
                      text: "Sign up",
                      onPressed: () {
                        Navigator.pushReplacementNamed(
                            context, SignUpScreen.id);
                      },

                      // color: Constants.primaryBlue,
                      underlined: true,
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
