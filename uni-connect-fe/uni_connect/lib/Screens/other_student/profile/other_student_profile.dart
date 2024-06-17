import 'package:flutter/material.dart';

import 'device/desktop/other_student_profile_desk.dart';

class OtherStudentProfilePage extends StatelessWidget {

  /// IDStudent : ID Studente - that i want see
  final String otherIDStudent;

  const OtherStudentProfilePage({
    required this.otherIDStudent,
  });


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: LayoutBuilder(

        builder: (context, constraints) {
          if (constraints.maxWidth > 750) {
            return DesktopOtherStudentProfilePage(OtherIDStudent: otherIDStudent,);
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



