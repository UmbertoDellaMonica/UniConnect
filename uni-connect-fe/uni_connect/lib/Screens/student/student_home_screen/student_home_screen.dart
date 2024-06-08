
import 'package:flutter/material.dart';
import 'device/desktop/student_home_screen_desk.dart';

class StudentHomePage extends StatelessWidget {

  /// IDStudent : ID Studente - when he logged
  final String IDStudent;

  const StudentHomePage({
    required this.IDStudent
  });


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(

        builder: (context, constraints) {
          if (constraints.maxWidth > 750) {
            return DesktopStudentHomePage();
          } else {
            return MobileStudentHomePage();
          }
        },
      ),
    );
  }
}

class MobileStudentHomePage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}







