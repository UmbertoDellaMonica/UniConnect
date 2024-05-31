import 'dart:async' show Future;

import 'package:uni_connect_front_end/shared/enums.dart';
import 'package:uni_connect_front_end/student/services/student_service.dart';
import 'package:uni_connect_front_end/student/utils/password_service_utils.dart';


class SignUpService {


  /// Injection of Service 

  final StudentService _studentService = StudentService();

  final PasswordService _passwordService = PasswordService();


  /// signUpStudent - Registra uno Studente 
  /// Call - UniConnect MicroService per registrare uno studente 
  Future<bool> signUpStudent(
    String email,
    String fullName,
    String password,
    String studentDepartement
  ) async {

    /// Hashing Password 
    String passwordHashed = _passwordService.hashPassword(password);

    /// Change Value Student Departement 
    String studentDepartementSelected = Enums.getDepartmentStudent(studentDepartement);

    print("Dipeartimento Selezionato : "+studentDepartementSelected);

    return await _studentService.signUpStudent(email,fullName,passwordHashed,studentDepartementSelected);
  }

}


