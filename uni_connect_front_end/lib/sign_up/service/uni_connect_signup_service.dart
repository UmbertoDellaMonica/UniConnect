import 'dart:async' show Future;

import 'package:uni_connect_front_end/student/services/student_service.dart';
import 'package:uni_connect_front_end/student/student.dart';


class UniConnectSignUpService {


  // Service to Call API from Student 
  final StudentService _studentService = StudentService();


  /// signUpStudent mi permette di registrare un utente sulla piattaforma 
  /// 
  Future<bool> SignUpStudent(String email, String fullName, String password, String StudentDepartement) async {
    
    return await _studentService.SignUpStudent(email,fullName,password);
  }


  Future<Student?> getData(String typeUser, String wallet) async{
    // return Data of Student 
  }


  Future<bool> login(String email, String password, String walletMilkHub, String typeUser) async {
    // Login of User 
    return true;
  }

}


