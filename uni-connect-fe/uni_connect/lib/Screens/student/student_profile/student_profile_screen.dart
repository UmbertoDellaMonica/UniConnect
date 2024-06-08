import 'package:flutter/material.dart';
import 'device/student_profile_screen_desk.dart';
import 'device/studente_profile_screen_mobile.dart';

class StudentProfilePage extends StatelessWidget {

  /// IDStudent : ID Studente - when he logged
  final String IDStudent;

  const StudentProfilePage({
    required this.IDStudent
  });


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(

        builder: (context, constraints) {
          if (constraints.maxWidth > 750) {
            return DesktopStudentProfilePage();
          } else {
            return MobileStudentProfilePage();
          }
        },
      ),
    );
  }
}






















