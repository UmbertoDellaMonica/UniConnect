import 'dart:convert';

import 'package:uni_connect_front_end/shared/payloads/StudentRequest.dart';
import 'package:uni_connect_front_end/student/student.dart';
import 'package:http/http.dart' as http;
import 'package:uni_connect_front_end/student/utils/student_api_service.dart';



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

      if (response.statusCode == 200) {
        return true;
      } else {
        print("Error :" + response.toString());
        print("Error body : "+response.body.toString());
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