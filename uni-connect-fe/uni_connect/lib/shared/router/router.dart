import 'package:go_router/go_router.dart';
import 'package:uni_connect/Screens/home/home_screen.dart';
import 'package:uni_connect/Screens/signin/signin_screen.dart';
import 'package:uni_connect/Screens/signup/signup_screen.dart';
import 'package:uni_connect/Screens/student/student_profile/student_profile_screen.dart';

import '../../Screens/student/student_home_screen/components/user_profile_home.dart';
import '../../Screens/student/student_home_screen/student_home_screen.dart';

class UniConnectRouter{
/// The route configuration.
static  GoRouter routerConfig = GoRouter(
  initialLocation: '/',
  routes: [
    /// Home Route
    GoRoute(
      path: '/',
      builder: (context, state) => WelcomePage(),
    ),
    /// Signup Route
    GoRoute(
      path: '/signup',
      builder: (context, state) =>  SignupPage(),
    ),
    GoRoute(
      path: '/signin',
      builder: (context, state) => SigninPage(),
    ),
    // Dynamically pass user data to nested routes
    GoRoute(
    path: '/home-page/:id_user',
    builder: (context, state) {
        final IDStudent = state.pathParameters['id_user']!;
        return StudentHomePage(IDStudent: IDStudent,);
      },
    ),
    GoRoute(
      path: '/student/:id_user/profile',
      builder: (context, state)  {
        final IDStudent = state.pathParameters['id_user']!;
        return StudentProfilePage(IDStudent: IDStudent,);
      },
    ),

  ]
);

}