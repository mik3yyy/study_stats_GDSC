import 'dart:io';

import 'package:cloudinary/cloudinary.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dropdown/flutter_dropdown.dart';
import 'package:image_picker/image_picker.dart';
import 'package:study_stats/auth_screen/fill_profile/fill_profile.dart';
import 'package:study_stats/auth_screen/signin_screen/sign_in.dart';
import 'package:study_stats/auth_screen/signup_screen/signup_function.dart';
import 'package:study_stats/global_comonents/custom_button.dart';
import 'package:study_stats/global_comonents/custom_messageHandler.dart';
import 'package:study_stats/global_comonents/custom_text_button.dart';
import 'package:study_stats/global_comonents/custom_textfield.dart';
import 'package:study_stats/models/user.dart';
import 'package:study_stats/settings/constants.dart';
import 'package:uuid/uuid.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({key});
  static String id = "/sign_up";
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _matricController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool obscuretext = true;
  final GlobalKey<ScaffoldMessengerState> scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();
  bool loading = false;
  final ImagePicker _picker = ImagePicker();
  String _imageFile = '';
  String imageName = '';
  dynamic _pickedImageError;
  bool agreedTerms = false;
  static const _channel = MethodChannel("flutter_launcher_plus");
  late TapGestureRecognizer _tapGestureRecognizer;
  late TapGestureRecognizer _tapGestureRecognizerTerms;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tapGestureRecognizer = TapGestureRecognizer()
      ..onTap = () async {
        var url = "github.com/mik3yyy/study_stat_policy";

        print(url);
        try {
          if (!url.contains('https') || !url.contains('http')) {
            url = 'https:' + url;
          }

          await _channel.invokeMethod(
            'launchUrl',
            <String, String>{'website_url': url},
          );
        } catch (e) {
          print(e.toString());

          MyMessageHandler.showSnackBar(context, "Unable to open link");
        }
      };
    _tapGestureRecognizerTerms = TapGestureRecognizer()
      ..onTap = () async {
        showAboutDialog(
            context: context,
            applicationName: "Study Stats",
            applicationVersion: "1.0.0",
            applicationIcon: Image.asset(
              "assets/image/onboarding/splash.png",
              width: 100,
              height: 100,
            ),
            children: [
              const Text(
                '1. Acceptance of Terms: By downloading, accessing, or using the Study Stats mobile application Study Stats, you agree to be bound by these Terms and Conditions. If you do not agree with any part of these terms, you may not use the App.' +
                    "\n2. Use of the App: Study Stats is intended solely for personal, non-commercial use. You may use the App to track your academic performance and set goals related to your GPA." +
                    "\n3. User Accounts: You may be required to create a user account to access certain features of the App. You are responsible for maintaining the confidentiality of your account information and for all activities that occur under your account." +
                    "\n4. Data Privacy: We are committed to protecting your privacy. We will not share your personal information with third parties without your consent. Please review our Privacy Policy for more information."
                        "\n5. Accuracy of Information:While we strive to provide accurate GPA calculations and analysis, we cannot guarantee the accuracy or completeness of the information provided by the App. You are responsible for verifying the accuracy of your academic data."
                        "\n6. Intellectual Property:The App and its content, including but not limited to text, graphics, logos, and images, are the property of Study Stats and are protected by copyright and other intellectual property laws. You may not reproduce, modify, or distribute any part of the App without our prior written consent."
                        "\n7. Updates and Changes:We may update or change the App, including its features and functionality, at any time without notice. By continuing to use the App after such updates or changes, you agree to be bound by the revised Terms and Conditions."
                        "\n8. Limitation of Liability: In no event shall Study Stats be liable for any indirect, incidental, special, consequential, or punitive damages arising out of or related to your use of the App."
                        "\n9. Governing Law: These Terms and Conditions shall be governed by and construed in accordance with the laws of [Jurisdiction], without regard to its conflict of law principles."
                        "\n10. Contact Us: If you have any questions or concerns about these Terms and Conditions, please contact us at [contact email].",
              )
            ]);
      };
  }

  void _pickImageFromGallery() async {
    try {
      final pickedImage = await _picker.pickImage(
          source: ImageSource.gallery,
          maxHeight: 300,
          maxWidth: 300,
          imageQuality: 95);
      if (pickedImage!.path != null) {
        setState(() {
          imageName = "Image.png";
          _imageFile = pickedImage.path;
        });
      }
    } catch (e) {
      setState(() {
        _pickedImageError = e.toString();
      });
      MyMessageHandler.showSnackBar(context, "Invalid Image");
    }
  }

  void _pickImageFromCamera() async {
    try {
      final pickedImage = await _picker.pickImage(
          source: ImageSource.camera,
          maxHeight: 300,
          maxWidth: 300,
          imageQuality: 95);
      if (pickedImage!.path != null) {
        setState(() {
          _imageFile = pickedImage.path;
        });
      }
    } catch (e) {
      setState(() {
        _pickedImageError = e.toString();
      });
      MyMessageHandler.showSnackBar(context, "Invalid Image");
    }
  }

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
        body: SafeArea(
          child: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: Container(
              height: MediaQuery.sizeOf(context).height,
              child: SingleChildScrollView(
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Container(
                      //   height: 200,
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.center,
                      //     children: [
                      //       Container(
                      //         decoration: BoxDecoration(
                      //           border: Border.all(color: Colors.blue),
                      //           borderRadius: BorderRadius.circular(70),
                      //         ),
                      //         child: CircleAvatar(
                      //           radius: 70,
                      //           backgroundColor: Colors.transparent,
                      //           child: _imageFile.isNotEmpty
                      //               ? ClipRRect(
                      //                   borderRadius: BorderRadius.circular(70),
                      //                   child: Image.file(
                      //                     File(_imageFile),
                      //                     width: 137,
                      //                     height: 137,
                      //                     fit: BoxFit.cover,
                      //                   ),
                      //                 )
                      //               : Icon(
                      //                   Icons.person,
                      //                   size: 50,
                      //                   color: Colors.blue,
                      //                 ),
                      //         ),
                      //       ),
                      //       // Constants.gap(width: 20),
                      //       Column(
                      //         mainAxisAlignment: MainAxisAlignment.center,
                      //         children: [
                      //           MaterialButton(
                      //             onPressed: () {
                      //               _pickImageFromCamera();
                      //             },
                      //             child: Container(
                      //               height: 50,
                      //               width: 50,
                      //               decoration: const BoxDecoration(
                      //                   color: Colors.blue,
                      //                   borderRadius: BorderRadius.only(
                      //                       topRight: Radius.circular(10),
                      //                       topLeft: Radius.circular(10))),
                      //               child: Center(
                      //                 child: Icon(
                      //                   Icons.camera,
                      //                   color: Constants.white,
                      //                 ),
                      //               ),
                      //             ),
                      //           ),
                      //           Constants.gap(height: 10),
                      //           MaterialButton(
                      //             onPressed: () {
                      //               _pickImageFromGallery();
                      //             },
                      //             child: Container(
                      //               height: 50,
                      //               width: 50,
                      //               decoration: BoxDecoration(
                      //                   color: Colors.blue,
                      //                   borderRadius: BorderRadius.only(
                      //                       bottomLeft: Radius.circular(10),
                      //                       bottomRight: Radius.circular(10))),
                      //               child: Center(
                      //                 child: Icon(
                      //                   CupertinoIcons.photo,
                      //                   color: Constants.white,
                      //                 ),
                      //               ),
                      //             ),
                      //           ),
                      //         ],
                      //       )
                      //     ],
                      //   ),
                      // ),

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Sign up",
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Constants.gap(height: 20),
                          Text(
                            "Name",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Constants.black,
                            ),
                          ),
                          Constants.gap(height: 5),
                          CustomTextField(
                            controller: _nameController,
                            hintText: "Enter full name, surname first",
                            onChange: () {
                              setState(() {});
                            },
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
                            "Matric No",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Constants.black,
                            ),
                          ),
                          Constants.gap(height: 5),
                          CustomTextField(
                            controller: _matricController,
                            hintText: "Enter Matric No.",
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
                            hintText: "Must be 8 characters ",
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
                          if (_imageFile.isEmpty) ...[
                            GestureDetector(
                              onTap: () {
                                _pickImageFromGallery();
                              },
                              child: DottedBorder(
                                borderType: BorderType.RRect,
                                // strokeWidth: 10,
                                // stackFit: StackFit.expand,
                                dashPattern:
                                    _imageFile.isEmpty ? [2, 10] : [1, 1],

                                radius: Radius.circular(12),
                                padding: EdgeInsets.all(6),
                                child: ClipRRect(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12)),
                                  child: Container(
                                    height: 40,
                                    // width: 120,
                                    child: const Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        CircleAvatar(
                                          radius: 15,
                                          backgroundColor: Color(0xFFB3BFCB),
                                          child: Center(
                                            child: Icon(
                                              Icons.add,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                        Text(
                                          "  Add Image",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ] else ...[
                            GestureDetector(
                              onTap: () {
                                _pickImageFromGallery();
                              },
                              child: ClipRRect(
                                // borderRadius:
                                //     BorderRadius.all(Radius.circular(10)),
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                  ),
                                  height: 50,
                                  // width: 120,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Row(
                                          children: [
                                            ClipRRect(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10)),
                                              child: Container(
                                                child: Image.file(
                                                  File(_imageFile),
                                                  fit: BoxFit.fill,
                                                ),
                                                width: 70,
                                              ),
                                            ),
                                            Constants.gap(width: 40),
                                            Expanded(
                                              child: Text(
                                                "${_nameController.text}.png",
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          setState(() {
                                            _imageFile = '';
                                            imageName = '';
                                          });
                                        },
                                        icon: Icon(Icons.delete),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: 20,
                                  child: Checkbox(
                                    value: agreedTerms,
                                    activeColor: Constants.black,
                                    checkColor: Colors.white,
                                    side: BorderSide(color: Constants.black),
                                    materialTapTargetSize:
                                        MaterialTapTargetSize.shrinkWrap,
                                    onChanged: (value) {
                                      setState(() {
                                        agreedTerms = !agreedTerms;
                                      });
                                    },
                                  ),
                                ),
                                Constants.gap(width: 10),
                                Expanded(
                                  child: RichText(
                                    // maxLines: 5,
                                    textAlign: TextAlign.left,
                                    text: TextSpan(
                                      style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 16,
                                      ),
                                      children: [
                                        TextSpan(
                                          text: 'i agree to  ',
                                          style: TextStyle(
                                            color: Constants.black,
                                          ),
                                        ),
                                        TextSpan(
                                          text: "Terms and condition",
                                          recognizer:
                                              _tapGestureRecognizerTerms,
                                          style: TextStyle(
                                            color: Constants.black,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        TextSpan(
                                          text: " and read ",
                                          style: TextStyle(
                                            color: Constants.black,
                                          ),
                                        ),
                                        TextSpan(
                                          text: "Privacy Policy",
                                          recognizer: _tapGestureRecognizer,
                                          style: TextStyle(
                                            color: Constants.black,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        bottomNavigationBar: Container(
          height: 150,
          color: Colors.transparent,
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomButton(
                  // enable: true,
                  enable: _nameController.text.isNotEmpty &&
                      _emailController.text.isNotEmpty &&
                      _passwordController.text.isNotEmpty &&
                      _matricController.text.isNotEmpty &&
                      // _imageFile.isNotEmpty &&
                      agreedTerms,
                  onTap: () async {
                    try {
                      String image = '';
                      final cloudinary = Constants.CloudinaryKey;
                      setState(() {
                        loading = true;
                      });
                      bool exists = await SignUpFunction.doesEmailExist(
                          _emailController.text);
                      if (exists) {
                        MyMessageHandler.showSnackBar(context, "Email exists");
                        setState(() {
                          loading = false;
                        });
                        return;
                      }
                      if (_imageFile.isNotEmpty) {
                        var response = await cloudinary.upload(
                            file: _imageFile,
                            // fileBytes: file.readAsBytesSync(),
                            resourceType: CloudinaryResourceType.image,
                            folder: "GDSC/Users",
                            fileName: '${_emailController.text}',
                            progressCallback: (count, total) {
                              print(
                                  'Uploading image from file with progress: $count/$total');
                            });
                        if (response.isSuccessful) {
                          image = response.url!;
                          SignUpFunction.signUP(
                            user: User(
                              id: Uuid().v4(),
                              name: _nameController.text,
                              email: _emailController.text.toLowerCase(),
                              password: _passwordController.text,
                              matricNo: _matricController.text,
                              image: image,
                            ),
                            scaffoldKey: scaffoldKey,
                            context: context,
                          );
                        } else {
                          print(response.toJson());
                          MyMessageHandler.showSnackBar(
                              context, "Unable to Upload Image");
                        }
                      } else {
                        image = Constants.profile;
                        SignUpFunction.signUP(
                          user: User(
                            id: Uuid().v4(),
                            name: _nameController.text,
                            email: _emailController.text.toLowerCase(),
                            password: _passwordController.text,
                            matricNo: _matricController.text,
                            image: image,
                          ),
                          scaffoldKey: scaffoldKey,
                          context: context,
                        );
                      }
                    } catch (e) {
                      MyMessageHandler.showSnackBar(context,
                          "Unable to Upload Image, check your network");
                    }
                    setState(() {
                      loading = false;
                    });
                  },
                  title: "Sign up",
                  loading: loading,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Already have an account? "),
                    CustomTextButton(
                      text: "Log in",
                      onPressed: () {
                        Navigator.pushReplacementNamed(
                            context, SignInScreen.id);
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
