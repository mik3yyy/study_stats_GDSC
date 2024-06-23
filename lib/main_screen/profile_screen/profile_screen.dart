import 'package:dialog_alert/dialog_alert.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:study_stats/auth_screen/signin_screen/sign_in.dart';
import 'package:study_stats/auth_screen/signup_screen/signup.dart';
import 'package:study_stats/global_comonents/custom_button_tile.dart';
import 'package:study_stats/main_screen/profile_screen/change_password/change_password.dart';
import 'package:study_stats/main_screen/profile_screen/contact_us/contact_us.dart';
import 'package:study_stats/main_screen/profile_screen/edit_profile/edit_profile.dart';
import 'package:study_stats/main_screen/profile_screen/upload_screen/upload_screen.dart';
import 'package:study_stats/providers/authProvider.dart';
import 'package:study_stats/settings/constants.dart';
import 'package:study_stats/settings/notification.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    var authProvider = Provider.of<AuthProvider>(context, listen: true);

    return Scaffold(
      appBar: AppBar(
        title: Text("Profile", style: TextStyle()),
        // centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: ListView(
          children: [
            CircleAvatar(
                radius: 70,
                backgroundColor: Constants.grey,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(70),
                  child: Image.network(
                    authProvider.user?.image ?? Constants.profile,
                    width: 137,
                    height: 137,
                    fit: BoxFit.cover,
                  ),
                )),
            ButtonTile(
              title: "Edit Profile",
              leading: Icon(Icons.edit),
              traling: Icon(Icons.chevron_right),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => EditProfile()));
              },
            ),

            ButtonTile(
              title: "Change Password",
              leading: Icon(Icons.lock),
              traling: Icon(Icons.chevron_right),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ChnagePassword()));
              },
            ),

            ButtonTile(
              title: "Contact us",
              leading: Icon(Icons.headset_mic_sharp),
              traling: Icon(Icons.chevron_right),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ContactUs()));
              },
            ),
            if (authProvider.user?.premium ?? false)
              ButtonTile(
                title:
                    "Sync data ${authProvider.user?.premium ?? false ? "" : "(Premium Feature)"}",
                leading: Icon(Icons.sync),
                traling: Icon(Icons.chevron_right),
                onTap: () {
                  if (authProvider.user?.premium ?? false) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => UploadScreen()));
                  } else {}
                },
              ),
            ButtonTile(
              title: "Terms and Conditions",
              leading: const Icon(Icons.book),

              // traling: Icon(Icons.book),
              onTap: () {
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
              },
            ),
            // ButtonTile(
            //   title: "Dark Mode",
            //   leading: Icon(Icons.dark_mode),
            //   traling: IconButton(
            //     onPressed: () {
            //       mainProvider.changeTheme();
            //     },
            //     icon: mainProvider.isLight()
            //         ? Icon(Icons.toggle_off)
            //         : Icon(Icons.toggle_on_outlined),
            //   ),
            //   onTap: () {},
            // ),
            ButtonTile(
              title: "Log Out",
              leading: Icon(
                Icons.logout,
                color: Constants.white,
              ),
              color: Constants.black,
              // traling: Icon(Icons.chevron_right),
              onTap: () async {
                final result = await showDialogAlert(
                  context: context,
                  title: 'Are you sure?',
                  message: 'Do you want to Log Out?',
                  actionButtonTitle: 'Log out',
                  cancelButtonTitle: 'Cancel',
                  actionButtonTextStyle: const TextStyle(
                    color: Colors.red,
                  ),
                  cancelButtonTextStyle: const TextStyle(
                    color: Colors.black,
                  ),
                );
                if (result == ButtonActionType.action) {
                  Navigator.pushNamedAndRemoveUntil(
                      context, SignInScreen.id, (route) => false);
                  authProvider.clearData();
                  NotificationFunction.cancelAllNotifications();

                  // ProfileFunction.LogOut(context);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
