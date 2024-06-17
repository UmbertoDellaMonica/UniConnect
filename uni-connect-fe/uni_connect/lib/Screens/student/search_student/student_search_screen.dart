
import 'package:flutter/material.dart';

import 'device/desktop/search_student_screen_desk.dart';

class StudentSearchPage extends StatelessWidget {

  /// IDStudent : ID Studente - when he logged
  final String IDStudent;

  StudentSearchPage({
    required this.IDStudent
  });


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(

        builder: (context, constraints) {
          if (constraints.maxWidth > 750) {
            return DesktopStudentSearchPage(query: '', IDStudent: this.IDStudent,);
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