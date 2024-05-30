import 'dart:async' show Future;

import 'package:uni_connect_front_end/student/services/student_service.dart';
import 'package:uni_connect_front_end/student/student.dart';


class UniConnectSignUpService {


  // Service to Call API from Student 
  final StudentService studentService = StudentService();


  /// signUpStudent - Registra uno Studente 
  Future<bool> signUpStudent(
    String email,
    String fullName,
    String password,
    String studentDepartement
  ) async {
    return await studentService.signUpStudent(email,fullName,password,studentDepartement);
  }


  Future<Student?> getData(String typeUser, String wallet) async{
    // return Data of Student 
  }


  Future<bool> login(String email, String password, String walletMilkHub, String typeUser) async {
    // Login of User 
    return true;
  }

}


