import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:uni_connect/models/student.dart';

import 'device/desktop/other_student_profile_desk.dart';

class OtherStudentProfilePage extends StatelessWidget {

  /// IDStudent : ID Studente - when he logged
  final String IDStudent;
  final Student other_student;

  const OtherStudentProfilePage({
    required this.IDStudent,
    required this.other_student
  });


  @override
  Widget build(BuildContext context) {

    print("Other student : "+this.other_student.toString());
    return Scaffold(
      body: LayoutBuilder(

        builder: (context, constraints) {
          if (constraints.maxWidth > 750) {
            return DesktopOtherStudentProfilePage(other_student: this.other_student);
          } else {
            return MobileOtherStudentProfilePage();
          }
        },
      ),
    );
  }

  Widget MobileOtherStudentProfilePage() {
    throw UnimplementedError();
  }
}



