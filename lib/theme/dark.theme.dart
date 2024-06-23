import 'package:flutter/material.dart';
import 'package:study_stats/settings/constants.dart';

ThemeData darkTheme = ThemeData(
  colorScheme: ColorScheme.dark(
    secondary: Constants.white,
    primary: Constants.black,
  ),
  dialogBackgroundColor: Constants.black,
  cardTheme: CardTheme(
    shadowColor: Colors.white.withOpacity(0.5),
    elevation: 4,
    color: Constants.black,
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    selectedItemColor: Constants.white,
    selectedIconTheme: IconThemeData(
      color: Constants.white,
    ),
    unselectedItemColor: Constants.grey.withOpacity(0.6),

    // selectedLabelStyle: TextStyle(color: Cons)
  ),
  textTheme: TextTheme(),
  dialogTheme: DialogTheme(
    backgroundColor: Constants.white,
    // iconColor: Constants,
    titleTextStyle: TextStyle(backgroundColor: Constants.black),
  ),
  useMaterial3: true,
);
