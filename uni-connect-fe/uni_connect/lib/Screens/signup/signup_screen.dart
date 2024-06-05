import 'package:flutter/material.dart';

import 'device/desktop/signup_screen_desk.dart';
import 'device/mobile/signup_screen_mob.dart';

class SignupPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(

        builder: (context, constraints) {
          if (constraints.maxWidth > 750) {
            return DesktopSignupPage();
          } else {
            return MobileSignupPage();
          }
        },
      ),
    );
  }
}
