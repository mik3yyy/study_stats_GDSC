import 'package:hive/hive.dart';

part 'quick.g.dart'; // File generated by build_runner

@HiveType(typeId: 2) // Ensure typeId is unique if you have other Hive models
class Quick extends HiveObject {
  @HiveField(0)
  final String result;

  @HiveField(1)
  final String gradingSystem;

  @HiveField(2)
  final List<dynamic> scores;

  @HiveField(3)
  final List<dynamic> courseData;

  @HiveField(4)
  final String level;

  @HiveField(5)
  final String semester;

  @HiveField(6)
  final bool uploaded;

  @HiveField(7) // Assuming this is the next available index
  final String timestamp; // Stored as a string for simplicity

  Quick({
    required this.result,
    required this.gradingSystem,
    required this.scores,
    required this.courseData,
    required this.level,
    required this.semester,
    this.uploaded = false,
    String? timestamp, // Made optional
  }) : timestamp = timestamp ??
            DateTime.now()
                .toIso8601String(); // Default to current time if not provided

  // Convert a Quick object into a Map object
  Map<String, dynamic> toJson() => {
        'result': result,
        'gradingSystem': gradingSystem,
        'scores': scores,
        'courseData': courseData,
        'level': level,
        'semester': semester,
        'uploaded': true,
        'timestamp': timestamp,
      };

  // Create a Quick object from a map
  factory Quick.fromJson(Map<String, dynamic> json) => Quick(
        result: json['result'],
        gradingSystem: json['gradingSystem'],
        scores:
            json['scores'] != null ? List<dynamic>.from(json['scores']) : [],
        courseData: json['courseData'] != null
            ? List<dynamic>.from(json['courseData'])
            : [],
        level: json['level'],
        semester: json['semester'],
        uploaded: json['uploaded'] ?? false,
        timestamp: json['timestamp'],
      );
  @override
  String toString() {
    return 'Quick(result: $result, gradingSystem: $gradingSystem, scores: $scores, courseData: $courseData, level: $level, semester: $semester, uploaded: $uploaded, timestamp: $timestamp)';
  }
}
