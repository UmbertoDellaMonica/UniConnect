import 'package:flutter/material.dart';
import 'package:uni_connect/Screens/signin/device/desktop/signin_screen_desk.dart';
import 'device/mobile/signin_screen_mobile.dart';



class SigninPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        body: LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth > 600) {
              return DesktopSigninPage();
            } else {
              return MobileSigninPage();
            }
          },
        ),
    );
  }




}