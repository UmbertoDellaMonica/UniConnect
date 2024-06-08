import 'dart:convert';

import 'package:http/http.dart' as http;
import "package:bcrypt/bcrypt.dart";
import 'package:uni_connect/shared/services/storage_service.dart';
import 'package:uni_connect/shared/services/student_api_service.dart';

import '../../models/request/student_request.dart';
import '../../models/student.dart';




class StudentService {

  final studentApiService = StudentApiService();


  static const String _Url = 'http://127.0.0.1:8443';

  static const String _api = 'api';

  static const String _version = 'v1';

  static const String _querySignUpStudent = 'student/signup';

  static const String _querySignInStudent = 'student/signin';

  static const String _queryGetStudent = 'student';



  /// Registrazione dello Studente
  /// Permette di eseguire la registrazione
  Future<bool> signUpStudent (String email, String fullName, String password,String selectedDepartement) async {

    late String Url = studentApiService.buildUrl(_api,_Url, _version,_querySignUpStudent);
    StudentSignupRequest studentRequest = studentApiService.getBodySignUpMethod(email, password, fullName, selectedDepartement);
    String body = jsonEncode(studentRequest);

    try{
      final response = await http.post(
          Uri.parse(Url),
          body: body,
          headers: studentApiService.getHeaders()
      );

      if ( response.statusCode == 200 ) {
        print("Registrazione avvenuta con successo");
        return true;
      } else if( response.statusCode == 500 ){

        print("Error : Studente già presente");
        return false;
      }else {
        print("Error :" + response.toString());
        print("Error body : "+ response.body.toString());
        return false;
      }
    }catch(error){
      print("Errore di debug :" + error.toString());
      return false;
    }
  }


  /// Login dello Studente
  /// Permette di eseguire il Login
  Future<bool> signInStudent (String email, String password, String selectedDepartement) async {

    late String Url = studentApiService.buildUrl(_api,_Url, _version,_querySignInStudent);
    StudentSigninRequest studentRequest = studentApiService.getBodySignInMethod(email, password, selectedDepartement);
    String body = jsonEncode(studentRequest);

    try{
      final response = await http.post(
          Uri.parse(Url),
          body: body,
          headers: studentApiService.getHeaders()
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        print("Error: Erorre della risposta :"+response.body.toString());
        print("Error :" + response.toString());
        return false;
      }
    }catch(error){
      print("Errore di debug :" + error.toString());
      return false;
    }
  }



  /// GetStudent mi permette di recuperare tutti i dati dello Studente
  /// GetStudent permette di inserire all'interno dell'header tutti i dati di cui necessito
  /// Headers : 'email' -> value ( Inserisco nell'headers per motivi di sicurezza )
  Future<Student?> getStudent (String email) async {

    late String Url = studentApiService.buildUrl(_api,_Url, _version,_queryGetStudent);

    /// Modifica degli Headers
    var headers = studentApiService.getHeaders();
    headers.addAll({'email':email});

    try{

      final response = await http.get(
          Uri.parse(Url),
          headers: headers
      );

      if (response.statusCode == 200) {
        Student retrieveStudent = Student.fromJson(jsonDecode(response.body));
        print("Student Data : "+retrieveStudent.toString());
        return retrieveStudent;

      } else {
        print("Error :" + response.toString());
        print("Error debug : "+response.body.toString());
        return null;
      }
    }catch(error){
      print("Errore di debug :" + error.toString());
      return null;
    }

  }



}


/// Password - Service
/// Service for Hashing Password 
class PasswordService {


  // Salt per fare l'Hashing della Password
  final _salt = "\$2a\$10\$Gs.PmaGJQtm0ThQF3VkX2u";

  /// Method per effettuare l'hashing della password
  /// - Password come Parametro
  String hashPassword(String password) {
    final hashedPassword = BCrypt.hashpw(password, _salt);
    return hashedPassword;
  }

  static bool checkPassword(String password,String passwordHashed){
    if(password!=passwordHashed){
      return true;
    }else{
      return false;
    }
  }


}