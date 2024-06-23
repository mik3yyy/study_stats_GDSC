import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:study_stats/auth_screen/fill_profile/fill_profile_function.dart';
import 'package:study_stats/providers/authProvider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SimulateFunction {
  static Map<String, String> getSimulation(
      {required String goal,
      required String current_gpa,
      required String cgpa}) {
    double Goal = double.parse(goal);
    double Gpa = double.parse(current_gpa);
    double Cgpa = double.parse(cgpa);
    Map<String, String> data = {};
    if (Gpa < Cgpa) {
      data = {
        'title': "A Path to improvement",
        'body':
            "Based on your predicted CGPA of ${cgpa}, it looks like there's a great opportunity ahead to enhance your academic standing. Reaching your CGPA target might require a bit more focus and dedication. Now's the perfect time to identify areas for improvement, seek additional resources, and perhaps adjust your study habits. Remember, every effort you make today shapes your academic success tomorrow.",
      };
      if (Goal < Cgpa) {
        data = {
          'title': "On Track to Success!!!",
          'body':
              "Your predicted CGPA of ${cgpa} is exactly what you need to keep moving towards your CGPA goals. This is a clear sign of your commitment and the positive direction you're headed in. Staying on this path means continuing your hard work and maybe even setting new, higher goals. Keep the momentum going; your future self will thank you!",
        };
      }
    } else {
      data = {
        'title': "You can still do it",
        'body':
            "Your predicted GPA of ${cgpa} indicates you're maintaining a steady pace towards achieving your CGPA goals. This balance is crucial for sustaining your academic achievements. Stay focused, manage your time efficiently, and remain open to seeking help whenever necessary. With consistent effort, you're likely to maintain this commendable performance. Keep it up!",
      };
    }

    return data;
  }
}
