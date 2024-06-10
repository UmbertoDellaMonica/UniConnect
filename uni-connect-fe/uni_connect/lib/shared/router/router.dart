import 'package:go_router/go_router.dart';
import 'package:uni_connect/Screens/home/home_screen.dart';
import 'package:uni_connect/Screens/other_student/profile/other_student_profile.dart';
import 'package:uni_connect/Screens/signin/signin_screen.dart';
import 'package:uni_connect/Screens/signup/signup_screen.dart';
import 'package:uni_connect/Screens/student/student_follower/student_follower_screen.dart';
import 'package:uni_connect/Screens/student/student_profile/student_profile_screen.dart';

import '../../Screens/student/search_student/student_search_screen.dart';
import '../../Screens/student/student_following/student_following_screen.dart';
import '../../Screens/student/student_home_screen/components/user_profile_home.dart';
import '../../Screens/student/student_home_screen/student_home_screen.dart';
import '../../models/student.dart';

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
    GoRoute(
      path: '/student/:id_user/search',
      builder: (context, state)  {
        final IDStudent = state.pathParameters['id_user']!;
        return StudentSearchPage(IDStudent: IDStudent,);
      },
    ),
    GoRoute(
      path: '/student/:id_user/follower',
      builder: (context, state)  {
        final IDStudent = state.pathParameters['id_user']!;
        return StudentFollowerPage(IDStudent: IDStudent);
      },
    ),
    GoRoute(
      path: '/student/:id_user/following',
      builder: (context, state)  {
        final IDStudent = state.pathParameters['id_user']!;
        return StudentFollowingPage(IDStudent: IDStudent);
      },
    ),



    GoRoute(
      path: '/other-student/:id_user/profile',
      builder: (context, state)  {
        final IDStudent = state.pathParameters['id_user']!;
        return OtherStudentProfilePage(IDStudent: IDStudent);
      },
    ),


  ]
);

}