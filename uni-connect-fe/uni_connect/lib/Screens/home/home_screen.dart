import 'package:flutter/material.dart';

import 'package:uni_connect/Screens/home/device/mobile/home_screen_mob.dart';
import 'package:uni_connect/Screens/home/device/desktop/home_screen_desk.dart';

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(

        builder: (context, constraints) {
          if (constraints.maxWidth > 600) {
            return DesktopWelcomePage();
          } else {
            return MobileWelcomePage();
          }
        },
      ),
    );
  }
}