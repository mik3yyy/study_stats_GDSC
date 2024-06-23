import 'package:flutter/material.dart';

class IntroPage3 extends StatelessWidget {
  const IntroPage3({key});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Image.asset(
        'assets/image/onboarding/frame3.png',
        height: 450,
        width: 350,
        fit: BoxFit.fill,
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Stay Organized',
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 12,
          ),
          Text(
            'Organise your courses, assignments, and grades in one place. Never miss a deadline and keep everything on track for academic success.',
            style: TextStyle(
                fontSize: 13, color: const Color.fromARGB(255, 119, 118, 118)),
          )
        ],
      ),
    ]);
  }
}
