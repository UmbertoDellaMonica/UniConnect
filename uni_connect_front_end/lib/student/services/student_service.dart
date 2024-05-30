import 'dart:convert';
import 'dart:html';

import 'package:uni_connect_front_end/shared/payloads/StudentRequest.dart';
import 'package:uni_connect_front_end/student/student.dart';
import 'package:http/http.dart' as http;
import 'package:uni_connect_front_end/student/utils/student_service_utils.dart';



class StudentService {

  final studentServiceUtils = StudentServiceUtils();


  static const String _Url = 'http://127.0.0.1:5000';

  static const String _api = 'api';

  static const String _version = 'v1';

  static const String _querySignUpStudent = 'student/signup';

  static const String _querySignInStudent = 'signin';



  /// Registrazione dello Studente 
  /// Permette di eseguire la registrazione
    Future<bool> signUpStudent(String email, String fullName, String password,String studentDepartement) async {
      
    late String Url = studentServiceUtils.buildUrl(_api,_Url, _version,_querySignUpStudent); 
    StudentRequest studentRequest = studentServiceUtils.getBodySignUpMethod(email, password, fullName, studentDepartement);
    String body = jsonEncode(studentRequest);

    print("Url: "+Url);
    print("Sono qui ----- prima dell'azione di POST");
    try{
    final response = await http.post(
      Uri.parse(Url),
      body: jsonEncode(studentRequest),
      headers: studentServiceUtils.getHeaders()
    );

    if (response.statusCode == 200) {
      print("I'm Here !");
      return true;
    } else {
      print("Error: Erorre della risposta :"+response.body);
      print("Error :" + response.toString());
      return false;
    }
    }catch(error){
      print("Errore di debug :" + error.toString());
      return false;
    }
  }

  
  
  bool login(String emailInput, String passwordInput, String selectedValueUserType) {
    return true;
  }

  Student getData(String selectedValueUserType) {
     Student student =  Student(id: "d", fullName: "fullName", password: "password", email: "email");
     return student;
  }


}