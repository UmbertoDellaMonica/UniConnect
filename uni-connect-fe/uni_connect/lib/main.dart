import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:uni_connect/shared/router/router.dart';
import 'package:uni_connect/shared/services/storage_service.dart';




void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupDependencies();
  runApp(UniConnectApp());
}

class UniConnectApp extends StatelessWidget {
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


void setupDependencies() {
  GetIt.I.registerSingleton<SecureStorageService>(SecureStorageService.instance);
}

