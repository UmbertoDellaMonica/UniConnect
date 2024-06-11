
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

/// Service - Help to Improve context.go or other action with that
class RouterService{

  /// ---------------- Student ----------------------///

  void goStudentHome(BuildContext context, id) {
    context.go('/home-page/$id');
  }

  /// Context Change to - /student/id_user/profile
  void goStudentProfile(BuildContext context, String id) {
    context.go('/student/$id/profile');
  }
  /// Context Change to - /student/id_user/follower
  void goStudentFollower(BuildContext context, String id) {
    context.go('/student/$id/follower');
  }
  /// Context Change to - /student/id_user/following
  void goStudentFollowing(BuildContext context, String id) {
    context.go('/student/$id/following');
  }

  /// Context change to - /student/id_user/search
  void goStudentSearch(BuildContext context, String? id) {
    context.go('/student/$id/search');
  }

  ///------------- OtherStudent - path ---------------///


  /// Context change to - /other-student/id_user/profile
  void goOtherStudentProfile(BuildContext context, String id) {
    context.go('/other-student/$id/profile');
  }








}