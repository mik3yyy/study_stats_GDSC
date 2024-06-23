import 'dart:convert';

import 'package:cloudinary/cloudinary.dart';
import 'package:flutter/material.dart';

import 'package:crypto/crypto.dart';
import 'package:intl/intl.dart';

class Constants {
  static String url = "https://bucc-ballot-backend.onrender.com";
  //"http://api.devbracket.tech/api/v1";
  //https://api.kiasup.com/api/v1

  static Color yellow = Color(0xFFFFD354);
  static Color blue = Color(0xFF055FFC);

  //COLOUR
  static Color grey = Colors.grey;
  static Color white = Color(0xFFFFFFFF);
  static Color transperent = Colors.transparent;

  static Color black = Colors.black;
  static Color orange = Color(0xFFEA985B);
  static Color primaryPink = Color(0xFFF4739E);
  static Color primaryBlue = Color(0xFF055FFC);
  static Color darkPink = Color(0xFFFF4881);

  static TextStyle title = TextStyle(
    fontSize: 27,
    fontWeight: FontWeight.w600,
  );
  static TextStyle Montserrat = TextStyle();
  static TextStyle Lato = TextStyle();
  static TextStyle Roboto = TextStyle();

  static BoxDecoration boxDecoration = BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: Constants.grey));
  ////
  static String nairaSymbol = "₦";

  static String profile =
      "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png";

  static Widget gap({double width = 0, double height = 0}) {
    return SizedBox(
      height: height,
      width: width,
    );
  }

  static Cloudinary CloudinaryKey = Cloudinary.signedConfig(
    apiKey: "314639493738266",
    apiSecret: "_BBDkH-rSxAxlg58lec-u6Wu-Ek",
    cloudName: "dwwzrtzb8",
  );
  static String hashPassword(String password) {
    var bytes = utf8.encode(password); // data being hashed

    var digest = sha1.convert(bytes);
    return digest.toString();
  }

  static TimeOfDay dateTimeToTimeOfDay(DateTime dateTime) {
    return TimeOfDay(hour: dateTime.hour, minute: dateTime.minute);
  }

  static String formatTimeOfDay(TimeOfDay time) {
    final hour = time.hour;
    final minute = time.minute;
    final period = hour >= 12 ? 'PM' : 'AM';

    // Format hour in 12-hour format instead of 24-hour
    final formattedHour = hour > 12 ? hour - 12 : (hour == 0 ? 12 : hour);

    // Add leading zero to minute if necessary
    final formattedMinute = minute.toString().padLeft(2, '0');

    return '$formattedHour:$formattedMinute $period';
  }

  static DateTime convertTimeOfDayToDateTime(TimeOfDay time, {DateTime? date}) {
    final now = date ?? DateTime.now();
    return DateTime(now.year, now.month, now.day, time.hour, time.minute);
  }

  static String formatDateTime(DateTime dateTime) {
    final DateFormat formatter = DateFormat('h:mm a');
    return formatter.format(dateTime);
  }
}
