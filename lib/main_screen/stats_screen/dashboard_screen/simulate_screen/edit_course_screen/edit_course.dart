import 'package:flutter/material.dart';
import 'package:study_stats/global_comonents/custom_button.dart';
import 'package:study_stats/global_comonents/custom_textfield.dart';
import 'package:study_stats/settings/constants.dart';

class EditCourse extends StatefulWidget {
  const EditCourse({key, this.course, required this.onTap});
  final dynamic course;
  final Function(Map course) onTap;
  @override
  State<EditCourse> createState() => _EditCourseState();
}

class _EditCourseState extends State<EditCourse> {
  dynamic course = {};
  final TextEditingController _courseController = TextEditingController();
  final TextEditingController _courseCodeController = TextEditingController();
  final TextEditingController _unitController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.course != null) {
      course = widget.course;
      _courseController.text = course['name'];
      _courseCodeController.text = course['course code'].toString();
      _unitController.text = course['units'].toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(),
        title: Text("Course Edit"),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.cancel))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Course",
                style: TextStyle(fontSize: 15),
              ),
              CustomTextField(
                controller: _courseController,
                hintText: "Course",
                onChange: () {
                  setState(() {});
                },
              ),
              Constants.gap(height: 20),
              Text(
                "Course Code",
                style: TextStyle(fontSize: 15),
              ),
              CustomTextField(
                controller: _courseCodeController,
                hintText: "Code",
                onChange: () {
                  setState(() {});
                },
              ),
              Constants.gap(height: 20),
              Text(
                "Course Unit",
                style: TextStyle(fontSize: 15),
              ),
              CustomTextField(
                controller: _unitController,
                hintText: "Unit",
                keyboardType: TextInputType.number,
                onChange: () {
                  setState(() {});
                },
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 100,
        child: Column(
          children: [
            CustomButton(
              enable: _courseController.text.isNotEmpty &&
                  _courseCodeController.text.isNotEmpty &&
                  _unitController.text.isNotEmpty,
              onTap: () {
                course = {
                  "name": _courseController.text,
                  "course code": _courseCodeController.text,
                  "units": int.parse(_unitController.text)
                };

                widget.onTap(course);
              },
              title: "Edit",
            )
          ],
        ),
      ),
    );
  }
}
