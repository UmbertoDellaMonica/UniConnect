
import 'package:flutter/material.dart';
import 'package:uni_connect/Screens/home/components/nav_bar.dart';
import '../../../models/student.dart';
import '../../../shared/custom_loading_bar.dart';
import 'components/connected_home_people.dart';
import 'components/post/post_form.dart';
import 'components/post/post_item.dart';
import 'components/user_profile_home.dart';
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







