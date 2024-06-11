import 'package:flutter/material.dart';

import 'device/desk/student_following_screen_desk.dart';

class StudentFollowingPage extends StatelessWidget {

  /// IDStudent : ID Studente - when he logged
  final String IDStudent;

  const StudentFollowingPage({
    required this.IDStudent
  });


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(

        builder: (context, constraints) {
          if (constraints.maxWidth > 750) {
            return DesktopStudentFollowingPage(IDStudent: IDStudent,);
          } else {
            return MobileStudentFollowerPage();
          }
        },
      ),
    );
  }



}

class MobileStudentFollowerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}