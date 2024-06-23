import 'dart:async';

import 'package:flutter/material.dart';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:study_stats/main_screen/home_screen/home_screen.dart';
import 'package:study_stats/main_screen/profile_screen/profile_screen.dart';
import 'package:study_stats/main_screen/stats_screen/stats_screen.dart';
import 'package:study_stats/models/quick.dart';
import 'package:study_stats/providers/authProvider.dart';
import 'package:study_stats/settings/constants.dart';
import 'package:study_stats/settings/quotes.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

// class MainScreen extends StatefulWidget {
//   const MainScreen({super.key});
//   static String id = '/main_screen';
//   @override
//   State<MainScreen> createState() => _MainScreenState();
// }

// class _MainScreenState extends State<MainScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold();
//   }
// }

// ignore_for_file: avoid_print

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);
  static String id = '/main_screen';

  @override
  MainScreenState createState() => MainScreenState();
}

class MainScreenState extends State<MainScreen> {
  late TutorialCoachMark tutorialCoachMark;

  GlobalKey keyBottomNavigation1 = GlobalKey();
  GlobalKey keyBottomNavigation2 = GlobalKey();
  GlobalKey keyBottomNavigation3 = GlobalKey();
  Timer? timer;

  @override
  void initState() {
    var authProvider = Provider.of<AuthProvider>(context, listen: false);
    authProvider.checkUser();

    // if (authProvider.checkUser()) {
    //   createTutorial();
    //   Future.delayed(Duration(milliseconds: 600), showTutorial);
    // }

    super.initState();
    timer = Timer.periodic(Duration(minutes: 10), (Timer t) {
      Quotes.set();
      set();
    });
  }

  set() {
    setState(() {});
  }

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    var authProvider = Provider.of<AuthProvider>(context, listen: true);

    List<Widget> _screens = [
      HomeScreen(),
      StatsScreen(),
      ProfileScreen(),
    ];
    return Scaffold(
      // appBar: AppBar(
      //   actions: <Widget>[],
      // ),
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              key: keyBottomNavigation1,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calculate, key: keyBottomNavigation2),
            label: 'Stats',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, key: keyBottomNavigation3),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        // selectedItemColor: Constants.black,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }

  void showTutorial() {
    tutorialCoachMark.show(context: context);
  }

  void createTutorial() {
    tutorialCoachMark = TutorialCoachMark(
      targets: _createTargets(),
      colorShadow: Constants.primaryBlue,
      textSkip: "SKIP",
      paddingFocus: 10,
      opacityShadow: 0.5,
      imageFilter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
      onFinish: () {
        print("finish");
      },
      onClickTarget: (target) {
        print('onClickTarget: $target');
      },
      onClickTargetWithTapPosition: (target, tapDetails) {
        print("target: $target");
        print(
            "clicked at position local: ${tapDetails.localPosition} - global: ${tapDetails.globalPosition}");
      },
      onClickOverlay: (target) {
        print('onClickOverlay: $target');
      },
      onSkip: () {
        print("skip");
        return true;
      },
    );
  }

  List<TargetFocus> _createTargets() {
    List<TargetFocus> targets = [];
    targets.add(
      TargetFocus(
        identify: "keyBottomNavigation1",
        keyTarget: keyBottomNavigation1,
        alignSkip: Alignment.topRight,
        enableOverlayTab: true,
        paddingFocus: 20,
        contents: [
          TargetContent(
            align: ContentAlign.top,
            builder: (context, controller) {
              return const Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Titulo lorem ipsum",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );

    targets.add(
      TargetFocus(
        identify: "keyBottomNavigation2",
        keyTarget: keyBottomNavigation2,
        alignSkip: Alignment.topRight,
        paddingFocus: 20,
        contents: [
          TargetContent(
            align: ContentAlign.top,
            builder: (context, controller) {
              return const Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Titulo lorem ipsum",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );

    targets.add(
      TargetFocus(
        identify: "keyBottomNavigation3",
        keyTarget: keyBottomNavigation3,
        alignSkip: Alignment.topRight,
        paddingFocus: 20,
        contents: [
          TargetContent(
            align: ContentAlign.top,
            builder: (context, controller) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text(
                    "Titulo lorem ipsum",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      tutorialCoachMark.goTo(0);
                    },
                    child: const Text('Go to index 0'),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );

    return targets;
  }
}


//  targets.add(
//       TargetFocus(
//         identify: "Target 0",
//         keyTarget: keyButton1,
//         contents: [
//           TargetContent(
//             align: ContentAlign.bottom,
//             builder: (context, controller) {
//               return const Column(
//                 mainAxisSize: MainAxisSize.min,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: <Widget>[
//                   Text(
//                     "Titulo lorem ipsum",
//                     style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         color: Colors.white,
//                         fontSize: 20.0),
//                   ),
//                   Padding(
//                     padding: EdgeInsets.only(top: 10.0),
//                     child: Text(
//                       "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin pulvinar tortor eget maximus iaculis.",
//                       style: TextStyle(color: Colors.white),
//                     ),
//                   ),
//                 ],
//               );
//             },
//           ),
//         ],
//       ),
//     );
//     targets.add(
//       TargetFocus(
//         identify: "Target 1",
//         keyTarget: keyButton,
//         color: Colors.purple,
//         contents: [
//           TargetContent(
//             align: ContentAlign.bottom,
//             builder: (context, controller) {
//               return Column(
//                 mainAxisSize: MainAxisSize.min,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: <Widget>[
//                   const Text(
//                     "Titulo lorem ipsum",
//                     style: TextStyle(
//                       fontWeight: FontWeight.bold,
//                       color: Colors.white,
//                       fontSize: 20.0,
//                     ),
//                   ),
//                   const Padding(
//                     padding: EdgeInsets.only(top: 10.0),
//                     child: Text(
//                       "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin pulvinar tortor eget maximus iaculis.",
//                       style: TextStyle(color: Colors.white),
//                     ),
//                   ),
//                   ElevatedButton(
//                     onPressed: () {
//                       controller.previous();
//                     },
//                     child: const Icon(Icons.chevron_left),
//                   ),
//                 ],
//               );
//             },
//           )
//         ],
//         shape: ShapeLightFocus.RRect,
//         radius: 5,
//       ),
//     );
//     targets.add(
//       TargetFocus(
//         identify: "Target 2",
//         keyTarget: keyButton4,
//         contents: [
//           TargetContent(
//             align: ContentAlign.left,
//             child: const Column(
//               mainAxisSize: MainAxisSize.min,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: <Widget>[
//                 Text(
//                   "Multiples content",
//                   style: TextStyle(
//                       fontWeight: FontWeight.bold,
//                       color: Colors.white,
//                       fontSize: 20.0),
//                 ),
//                 Padding(
//                   padding: EdgeInsets.only(top: 10.0),
//                   child: Text(
//                     "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin pulvinar tortor eget maximus iaculis.",
//                     style: TextStyle(color: Colors.white),
//                   ),
//                 )
//               ],
//             ),
//           ),
//           TargetContent(
//               align: ContentAlign.top,
//               child: const Column(
//                 mainAxisSize: MainAxisSize.min,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: <Widget>[
//                   Text(
//                     "Multiples content",
//                     style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         color: Colors.white,
//                         fontSize: 20.0),
//                   ),
//                   Padding(
//                     padding: EdgeInsets.only(top: 10.0),
//                     child: Text(
//                       "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin pulvinar tortor eget maximus iaculis.",
//                       style: TextStyle(color: Colors.white),
//                     ),
//                   )
//                 ],
//               ))
//         ],
//         shape: ShapeLightFocus.RRect,
//       ),
//     );
//     targets.add(TargetFocus(
//       identify: "Target 3",
//       keyTarget: keyButton5,
//       contents: [
//         TargetContent(
//             align: ContentAlign.right,
//             child: const Column(
//               mainAxisSize: MainAxisSize.min,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: <Widget>[
//                 Text(
//                   "Title lorem ipsum",
//                   style: TextStyle(
//                       fontWeight: FontWeight.bold,
//                       color: Colors.white,
//                       fontSize: 20.0),
//                 ),
//                 Padding(
//                   padding: EdgeInsets.only(top: 10.0),
//                   child: Text(
//                     "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin pulvinar tortor eget maximus iaculis.",
//                     style: TextStyle(color: Colors.white),
//                   ),
//                 )
//               ],
//             ))
//       ],
//       shape: ShapeLightFocus.RRect,
//     ));
//     targets.add(TargetFocus(
//       identify: "Target 4",
//       keyTarget: keyButton3,
//       contents: [
//         TargetContent(
//           align: ContentAlign.top,
//           child: Column(
//             children: <Widget>[
//               InkWell(
//                 onTap: () {
//                   tutorialCoachMark.previous();
//                 },
//                 child: Padding(
//                   padding: const EdgeInsets.all(10.0),
//                   child: Image.network(
//                     "https://juststickers.in/wp-content/uploads/2019/01/flutter.png",
//                     height: 200,
//                   ),
//                 ),
//               ),
//               const Padding(
//                 padding: EdgeInsets.only(bottom: 20.0),
//                 child: Text(
//                   "Image Load network",
//                   style: TextStyle(
//                       color: Colors.white,
//                       fontWeight: FontWeight.bold,
//                       fontSize: 20.0),
//                 ),
//               ),
//               const Text(
//                 "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin pulvinar tortor eget maximus iaculis.",
//                 style: TextStyle(color: Colors.white),
//               ),
//             ],
//           ),
//         ),
//       ],
//       shape: ShapeLightFocus.Circle,
//     ));
//     targets.add(
//       TargetFocus(
//         identify: "Target 5",
//         keyTarget: keyButton2,
//         shape: ShapeLightFocus.Circle,
//         contents: [
//           TargetContent(
//             align: ContentAlign.top,
//             child: const Column(
//               mainAxisSize: MainAxisSize.min,
//               children: <Widget>[
//                 Padding(
//                   padding: EdgeInsets.only(bottom: 20.0),
//                   child: Text(
//                     "Multiples contents",
//                     style: TextStyle(
//                         color: Colors.white,
//                         fontWeight: FontWeight.bold,
//                         fontSize: 20.0),
//                   ),
//                 ),
//                 Text(
//                   "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin pulvinar tortor eget maximus iaculis.",
//                   style: TextStyle(color: Colors.white),
//                 ),
//               ],
//             ),
//           ),
//           TargetContent(
//               align: ContentAlign.bottom,
//               child: const Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: <Widget>[
//                   Padding(
//                     padding: EdgeInsets.only(bottom: 20.0),
//                     child: Text(
//                       "Multiples contents",
//                       style: TextStyle(
//                           color: Colors.white,
//                           fontWeight: FontWeight.bold,
//                           fontSize: 20.0),
//                     ),
//                   ),
//                   Text(
//                     "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin pulvinar tortor eget maximus iaculis.",
//                     style: TextStyle(color: Colors.white),
//                   ),
//                 ],
//               ))
//         ],
//       ),
//     );