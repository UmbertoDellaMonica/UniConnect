import 'package:go_router/go_router.dart';
import 'package:uni_connect/Screens/home/home_screen.dart';
import 'package:uni_connect/Screens/signin/signin_screen.dart';
import 'package:uni_connect/Screens/signup/signup_screen.dart';

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
  ]);

}