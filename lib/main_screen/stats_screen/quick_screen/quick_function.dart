import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:study_stats/auth_screen/fill_profile/fill_profile_function.dart';
import 'package:study_stats/providers/authProvider.dart';

class QuickFunction {
  static Map<String, String> getQuickResult({required String cgpa}) {
    double Cgpa = double.parse(cgpa);
    Map<String, String> data = {};
    if (Cgpa > 4.0 && Cgpa < 5.0) {
      data = {
        'title': "Exemplary Achievement",
        'body':
            "Your GPA of ${cgpa} is a testament to your hard work and dedication to your studies. This outstanding performance places you at the pinnacle of academic excellence. Continue to challenge yourself and explore deeper insights into your subjects. Remember, the pursuit of knowledge is endless, and your potential is limitless. Maintain this impressive momentum, and don't hesitate to share your learning strategies with peers. Your journey is inspiring"
      };
    } else if (Cgpa > 3.5 && Cgpa < 3.99) {
      data = {
        'title': "Strong Performance",
        'body':
            "With a GPA of ${cgpa}, you're demonstrating a solid commitment to your academic pursuits. This is a strong foundation, but there's room to elevate your achievement to the next level. Identify areas where you can deepen your understanding and seek resources that can help enrich your learning. Participation in study groups and engaging in discussions can also enhance your comprehension. Keep up the good work, and aim for continuous improvement."
      };
    } else if (Cgpa > 2.5 && Cgpa < 3.49) {
      data = {
        'title': "Steady Progress",
        'body':
            "A GPA of ${cgpa} reflects steady academic progress. You're on the right track, showing good potential. To enhance your performance, consider reviewing your study habits and time management strategies. Explore different learning methods to find what works best for you, and don't hesitate to ask for feedback from instructors. Remember, every step forward is a step towards your goals. Believe in your ability to improve and keep pushing forward"
      };
    } else if (Cgpa > 2.0 && Cgpa < 2.49) {
      data = {
        'title': "Room for Improvement",
        'body':
            "Your GPA of ${cgpa} indicates that there are areas requiring your attention and effort. This is an opportunity to reassess your study strategies and identify the challenges you're facing. Seek support from teachers and peers, and consider utilizing academic resources available to you. Improvement is a gradual process, and every effort counts. Set small, achievable goals and celebrate your progress. Your potential is untapped, and with persistence, you will see positive changes."
      };
    } else {
      data = {
        'title': "Time for Reflection and Action",
        'body':
            "A GPA of ${cgpa} signals a crucial moment for reflection and strategizing. It's important to recognize the barriers to your academic success and actively seek ways to overcome them. Academic challenges can be daunting, but they are not insurmountable. Reach out for support from academic advisors, utilize tutoring services, and consider developing a personalized study plan. Your journey is unique, and with dedication and resilience, you can turn your situation around. Remember, every great comeback starts with a decision to try again"
      };
    }

    return data;
  }
}
