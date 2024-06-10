import 'dart:convert';

import 'package:http/http.dart' as http;
import "package:bcrypt/bcrypt.dart";
import 'package:uni_connect/shared/services/api_builder_service.dart';
import '../../models/payload/student_dto.dart';
import '../../models/student.dart';




class StudentService {

  final apiBuilderService = ApiBuilderService();


  static const String _Url = 'http://127.0.0.1:8443';

  static const String _api = 'api';

  static const String _version = 'v1';

  static const String _querySignUpStudent = 'student/signup';

  static const String _querySignInStudent = 'student/signin';

  static const String _queryGetStudent = 'student';
  static const String _queryGetOtherStudent = 'student/other';

  static const String _querySearchStudent = 'student/search';

  /// Following Path
  static const String _queryFollowStudent = 'student/follow';
  static const String _queryUnfollowStudent = 'student/unfollow';
  static const String _queryCheckFollowStudent = 'student/isFollowing';



  /// Registrazione dello Studente
  /// Permette di eseguire la registrazione
  Future<bool> signUpStudent (String email, String fullName, String password,String selectedDepartement) async {

    late String Url = apiBuilderService.buildUrl(_api,_Url, _version,_querySignUpStudent);
    StudentSignupRequest studentRequest = apiBuilderService.getBodySignUpMethod(email, password, fullName, selectedDepartement);
    String body = jsonEncode(studentRequest);

    try{
      final response = await http.post(
          Uri.parse(Url),
          body: body,
          headers: apiBuilderService.getHeaders()
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

    late String Url = apiBuilderService.buildUrl(_api,_Url, _version,_querySignInStudent);
    StudentSigninRequest studentRequest = apiBuilderService.getBodySignInMethod(email, password, selectedDepartement);
    String body = jsonEncode(studentRequest);

    try{
      final response = await http.post(
          Uri.parse(Url),
          body: body,
          headers: apiBuilderService.getHeaders()
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

    late String Url = apiBuilderService.buildUrl(_api,_Url, _version,_queryGetStudent);

    /// Modifica degli Headers
    var headers = apiBuilderService.getHeaders();
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


  /// GetStudent mi permette di recuperare tutti i dati dello Studente
  /// GetStudent permette di inserire all'interno dell'header tutti i dati di cui necessito
  /// Headers : 'email' -> value ( Inserisco nell'headers per motivi di sicurezza )
  Future<Student?> getStudentByID(String IDStudent) async {

    late String Url = apiBuilderService.buildUrl(_api,_Url, _version,_queryGetOtherStudent);

    /// Modifica degli Headers
    var headers = apiBuilderService.getHeaders();
    headers.addAll({'IDStudent':IDStudent});

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


  Future<List<Student>> searchStudents(String query, String studentId) async {
    late String Url = apiBuilderService.buildUrl(_api,_Url, _version,'$_querySearchStudent?query=$query');
    final headers = {
      'Content-Type': 'application/json',
      'IDStudent': studentId,
    };

    final response = await http.get(Uri.parse(Url), headers: headers);
    print("Response : "+response.body.toString());

    if (response.statusCode == 200) {
      List<dynamic> body = json.decode(response.body);
      List<Student> students = body.map((dynamic item) => Student.fromJson(item)).toList();
      return students;
    } else if (response.statusCode == 204) {
      return []; // No content
    } else {
      throw Exception('Failed to load students');
    }
  }




  Future<bool> followStudent(String IDStudent, String otherIDStudent) async {
    late String Url = apiBuilderService.buildUrl(_api,_Url, _version,_queryFollowStudent);

    final response = await http.post(
      Uri.parse(Url),
      headers: {
        'Content-Type': 'application/json',
        'IDStudent': IDStudent,
        'OtherIDStudent': otherIDStudent,
      },
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> unfollowStudent(String IDStudent, String otherIDStudent) async {
    late String Url = apiBuilderService.buildUrl(_api,_Url, _version,_queryUnfollowStudent);

    final response = await http.delete(
      Uri.parse(Url),
      headers: {
        'Content-Type': 'application/json',
        'IDStudent': IDStudent,
        'OtherIDStudent': otherIDStudent,
      },
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> checkFollow(String IDStudent, String otherIDStudent) async {
    late String Url = apiBuilderService.buildUrl(_api,_Url, _version,_queryCheckFollowStudent);

    final response = await http.get(
      Uri.parse(Url),
      headers: {
        'Content-Type': 'application/json',
        'IDStudent': IDStudent,
        'OtherIDStudent': otherIDStudent,
      },
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body) as bool;
    } else {
      return false;
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