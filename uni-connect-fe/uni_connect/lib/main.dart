import 'package:flutter/material.dart';
import 'package:uni_connect/Screens/router.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'UniConnect App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routerConfig: UniConnectRouter.routerConfig,
    );
  }
}


