import 'package:flutter/material.dart';

class IntroPage2 extends StatelessWidget {
  const IntroPage2({key});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Image.asset(
        'assets/image/onboarding/frame2.png',
        // height: 450,
        // width: 350,
        fit: BoxFit.fill,
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Visualize Your Progress',
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 12,
          ),
          Text(
            'See your academic journey at a glance. Our app provides intuitive charts and graphs to help you understand your performance over time',
            style: TextStyle(
                fontSize: 13, color: const Color.fromARGB(255, 119, 118, 118)),
          )
        ],
      ),
    ]);
  }
}
