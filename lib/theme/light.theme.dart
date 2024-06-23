import 'package:flutter/material.dart';
import 'package:study_stats/settings/constants.dart';

ThemeData lightTheme = ThemeData(
  // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
  dialogBackgroundColor: Constants.white,
  cardTheme: CardTheme(
    shadowColor: Color(0xFFF0F0F0).withOpacity(0.5),
    elevation: 4,
    color: Constants.white,
  ),
  textTheme: TextTheme(),
  colorScheme: ColorScheme.fromSeed(
    seedColor: Constants.white,
    primary: Constants.white,
    secondary: Constants.black,
  ),
  dialogTheme: DialogTheme(
    backgroundColor: Constants.white,
    // iconColor: Constants,
    titleTextStyle: TextStyle(backgroundColor: Constants.black),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    selectedItemColor: Constants.black,
    selectedIconTheme: IconThemeData(
      color: Constants.black,
    ),

    unselectedItemColor: Constants.grey.withOpacity(0.6),

    // selectedLabelStyle: TextStyle(color: Cons)
  ),
  useMaterial3: true,
);
