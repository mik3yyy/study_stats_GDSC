import 'package:flutter/material.dart';

class IntroPage1 extends StatelessWidget {
  const IntroPage1({key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          'assets/image/onboarding/frame1.png',
          // height: 450,
          // width: 350,
          fit: BoxFit.fill,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome to StudyStats',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 12,
            ),
            Text(
              'Effortlessly track and calculate your CGPA with our user-friendly app.Input your grades, credit hourss, and let us handle the rest.',
              style: TextStyle(
                  fontSize: 13,
                  color: const Color.fromARGB(255, 119, 118, 118)),
            )
          ],
        ),
      ],
    );
  }
}
