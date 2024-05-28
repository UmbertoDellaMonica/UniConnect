import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';



// Route Application
import 'package:uni_connect_front_end/home/home_page.dart';
import 'package:uni_connect_front_end/shared/services/secure_storage_service.dart';
import 'package:uni_connect_front_end/sign_in/sign_in.dart';
import 'package:uni_connect_front_end/sign_up/sign_up.dart';


void setupDependencies() {
  GetIt.I.registerSingleton<SecureStorageService>(SecureStorageService.instance);
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupDependencies();
  runApp(UniConnectApp());
}

class UniConnectApp extends StatelessWidget {
   UniConnectApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: "UniConnect App",
      routerConfig: _router,
    );
  }
}


/// Route Consumer 

// Assuming you have defined your page widgets:
// - MyHomePage
// - MySignUpPage
// - MySignInPage
// - HomePageUser
// - UserProfilePage
// - UserProfileHistoryPage
// - UserProfileInventoryProductPage
// - UserProfileProductBuyed

final GoRouter _router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const UniConnectHomePage(),
    ),
    GoRoute(
      path: '/signup',
      builder: (context, state) => const UniConnectSignUpPage(title: "UniConnect-SignUp"),
    ),
    GoRoute(
      path: '/signin',
      builder: (context, state) => const UniConnectSignInPage(title: "UniConnect-SignIn"),
    ),/*

    // Dynamically pass user data to nested routes
    GoRoute(
      path: '/home-page-user/:userType/:id_user',
      builder: (context, state) {
        final userType = state.pathParameters['userType']!;
        final idUser = state.pathParameters['id_user']!;
        return HomePageUser(
          userType: userType,
          idUser: idUser,

        );
      },
      routes: [
        GoRoute(
          path: 'profile',
          builder: (context, state)  {
            final userType = state.pathParameters['userType']!;
            final idUser = state.pathParameters['id_user']!;
            return UserProfilePage(
              userType: userType,
              idUser: idUser,
            );
          },
          routes: [
            GoRoute(
              path: 'history',
              builder: (context, state) {
                final userType = state.pathParameters['userType']!;
                final idUser = state.pathParameters['id_user']!;

                return UserProfileHistoryPage(
                  userType: userType,
                  idUser: idUser,
                );
              },
            ),
            GoRoute(
              path: 'inventory',
              builder: (context, state) {
                final userType = state.pathParameters['userType']!;
                final idUser = state.pathParameters['id_user']!;

                return UserProfileInventoryProductPage(
                  userType: userType,
                  idUser: idUser,
                );
              },
            ),
            GoRoute(
              path: 'product-buyed',
              builder: (context, state) {
                final userType = state.pathParameters['userType']!;
                final idUser = state.pathParameters['id_user']!;

                return UserProfileProductBuyed(
                  userType: userType,
                  idUser: idUser,
                );
              },
            ),
          ],
        ),
      ],
    ),
  */
  ],
);