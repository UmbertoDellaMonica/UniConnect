import 'dart:async' show Future;

import '../../../shared/utils/constants.dart';
import '../../../shared/services/student_service.dart';



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