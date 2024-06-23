import 'package:flutter/material.dart';
import 'package:study_stats/providers/mainProvider.dart';
// import 'package:google_fonts/google_fonts.dart';

import '../../settings/constants.dart';

class OnboardingView extends StatelessWidget {
  const OnboardingView({
    required this.mainProvider,
    required this.title,
    required this.subTitle,
    required this.image,
  });

  final MainProvider mainProvider;
  final String title;
  final String subTitle;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: MediaQuery.sizeOf(context).height * .5,
          width: MediaQuery.sizeOf(context).width,
          padding: EdgeInsets.only(bottom: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Image.asset(
                image,
                width: 300,
                height: 300,
                fit: BoxFit.contain,
              ),
            ],
          ),
        ),
        Container(
          height: 150,
          width: MediaQuery.sizeOf(context).width,
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: Constants.black,
                  fontSize: 20,
                ),
              ),
              Text(
                subTitle,
                textAlign: TextAlign.start,
                // style: Constants.Poppins.copyWith(),
              )
            ],
          ),
        )
      ],
    );
  }
}
