// import 'package:flutter/material.dart';
// import 'package:smooth_page_indicator/smooth_page_indicator.dart';
// // import 'package:study_stats/auth_screen/signin_screen/sign_in.dart';
// import 'package:study_stats/auth_screen/signup_screen/signup.dart';
// import 'package:study_stats/intro-screens/intro_page_1.dart';
// import 'package:study_stats/intro-screens/intro_page_2.dart';
// import 'package:study_stats/intro-screens/intro_page_3.dart';
// import 'package:study_stats/settings/constants.dart';

// class OnBoardingScreen extends StatefulWidget {
//   const OnBoardingScreen({key});
// static String id = "/onboard";
//   @override
//   State<OnBoardingScreen> createState() => _OnBoardingScreenState();
// }

// class _OnBoardingScreenState extends State<OnBoardingScreen> {
//   final PageController _controller = PageController(initialPage: 0);
//   bool onLastPage = false;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Constants.white,
//       body: SafeArea(
//         child: Container(
//           padding: const EdgeInsets.symmetric(horizontal: 10),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               PageView(
//                 onPageChanged: (index) {
//                   setState(() {
//                     onLastPage = index == 2;
//                   });
//                 },
//                 controller: _controller,
//                 children: const [
//                   IntroPage1(),
//                   IntroPage2(),
//                   IntroPage3(),
//                 ],
//               ),

//               //SmoothPageIndicator
//               Expanded(
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
// SmoothPageIndicator(
//   controller: _controller,
//   effect: const SwapEffect(
//     activeDotColor: Color.fromARGB(255, 0, 0, 0),
//     dotColor: Color.fromARGB(255, 204, 202, 202),
//     dotHeight: 6,
//     dotWidth: 35,
//   ),
//   count: 3,
// ),
//                   ],
//                 ),
//               ),
//               //SKIP
//             ],
//           ),
//         ),
//       ),
//       bottomNavigationBar: Container(
//         margin: EdgeInsets.symmetric(horizontal: 20),
//         height: 100,
//         child: Row(
//           mainAxisAlignment: onLastPage
//               ? MainAxisAlignment.end
//               : MainAxisAlignment.spaceBetween,
//           children: [
//             if (!onLastPage)
//               TextButton(
//                 onPressed: () {
// Navigator.pushReplacementNamed(context, SignUpScreen.id);
//                 },
//                 child: Text(
//                   'Skip',
//                   style: TextStyle(
//                       color: const Color.fromARGB(255, 119, 118, 118),
//                       fontSize: 16),
//                 ),
//               ),
//             //NEXT
//             SizedBox(
//               width: 120,
//               child: ElevatedButton(
//                 onPressed: () {
// if (onLastPage) {
//   Navigator.pushReplacementNamed(context, SignUpScreen.id);

//   // Navigate to next screen or perform an action
// } else {
//   _controller.nextPage(
//       duration: const Duration(milliseconds: 500),
//       curve: Curves.easeInOut);
// }
//                 },
//                 style: ElevatedButton.styleFrom(
//                   minimumSize: const Size(5, 20),
//                   backgroundColor: const Color.fromARGB(255, 0, 0, 0),
//                   padding: const EdgeInsets.all(10),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(15),
//                   ),
//                 ),
//                 child: Row(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     Text(
//                       'Next',
//                       style: TextStyle(
//                           color: Colors.white,
//                           fontWeight: FontWeight.bold,
//                           fontSize: 15),
//                     ),
//                     const SizedBox(width: 5),
//                     const Icon(Icons.arrow_forward, color: Colors.white),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:study_stats/auth_screen/signup_screen/signup.dart';
import 'package:study_stats/providers/mainProvider.dart';
import 'package:study_stats/settings/constants.dart';
import 'package:study_stats/view.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({key});
  static String id = "/onboard";

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  PageController _pageController = PageController();
  @override
  Widget build(BuildContext context) {
    var mainProvider = Provider.of<MainProvider>(context, listen: true);

    return Scaffold(
      backgroundColor: Constants.white,
      body: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Stack(
          children: [
            Container(
              height: MediaQuery.sizeOf(context).height * .5,
              width: MediaQuery.sizeOf(context).width,
              // color: Constants.darkPurple,
            ),
            Column(
              children: [
                Container(
                  height: MediaQuery.sizeOf(context).height * .8,
                  child: PageView(
                    controller: _pageController,
                    children: [
                      OnboardingView(
                        mainProvider: mainProvider,
                        title: 'Welcome to StudyStats',
                        subTitle:
                            'Effortlessly track and calculate your CGPA with our user-friendly app.Input your grades, credit hourss, and let us handle the rest.',
                        image: "assets/image/onboarding/frame1.png",
                      ),
                      OnboardingView(
                        mainProvider: mainProvider,
                        title: 'Visualize Your Progress',
                        subTitle:
                            'See your academic journey at a glance. Our app provides intuitive charts and graphs to help you understand your performance over time',
                        image: "assets/image/onboarding/frame1.png",
                      ),
                      OnboardingView(
                        mainProvider: mainProvider,
                        title: 'Stay Organized',
                        subTitle:
                            'Organise your courses, assignments, and grades in one place. Never miss a deadline and keep everything on track for academic success.',
                        image: "assets/image/onboarding/frame1.png",
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    SmoothPageIndicator(
                      controller: _pageController,
                      effect: const SwapEffect(
                        activeDotColor: Color.fromARGB(255, 0, 0, 0),
                        dotColor: Color.fromARGB(255, 204, 202, 202),
                        dotHeight: 6,
                        dotWidth: 35,
                      ),
                      count: 3,
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            )
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 100,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, SignUpScreen.id);

                  // OnboardingFunction.skip(context);
                },
                child: Text(
                  "Skip",
                  style: TextStyle(color: Constants.grey),
                ),
              ),
              Stack(
                alignment: AlignmentDirectional.center,
                children: [
                  Transform(
                    alignment: Alignment.centerRight,
                    transform: Matrix4.identity()..rotateZ(1),
                    origin: Offset(-15, 12),
                    // left: 0,

                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Constants.black,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 120,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_pageController.page == 2) {
                          Navigator.pushReplacementNamed(
                              context, SignUpScreen.id);
                        } else {
                          _pageController.nextPage(
                              duration: Duration(milliseconds: 500),
                              curve: Curves.easeIn);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(5, 20),
                        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
                        padding: const EdgeInsets.all(10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Next',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 15),
                          ),
                          const SizedBox(width: 5),
                          const Icon(Icons.arrow_forward, color: Colors.white),
                        ],
                      ),
                    ),
                  ),
                  // TextButton(
                  //   onPressed: () {
                  // if (_pageController.page == 2) {
                  //   Navigator.pushReplacementNamed(
                  //       context, SignUpScreen.id);
                  // } else {
                  //   _pageController.nextPage(
                  //       duration: Duration(milliseconds: 500),
                  //       curve: Curves.easeIn);
                  // }
                  //   },
                  //   child: Text(
                  //     "Next",
                  //     style: TextStyle(
                  //       color: Constants.black,
                  //       fontWeight: FontWeight.bold,
                  //     ),
                  //   ),
                  // ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
