


import 'package:uni_connect_front_end/shared/services/jwt_service.dart';
import 'package:uni_connect_front_end/shared/services/secure_storage_service.dart';
import 'package:uni_connect_front_end/student/services/student_service.dart';
import 'package:uni_connect_front_end/student/student.dart';

class SigninService {


  /// Injection of Service 
  
  final studentService = StudentService();

  final jwtService = JwtService();



  Future<bool> checkLogin(
    String emailInput,
    String passwordInput,
    String selectedValueUserType, 
    )async {
      return studentService.login(emailInput, passwordInput, selectedValueUserType);
    }

  Future<Student?> onLoginSuccess(String selectedValueUserType, SecureStorageService secureStorageService) async{
    /// Go to Home User page 
    /// Create a JWT (Optional)  
    
    /// Move to home-page-user and select our product 
    Student? userProvider =  studentService.getData(selectedValueUserType);
    // Inserisco nel Database Singleton
    await _saveUserReference(userProvider, secureStorageService);

    String tokenJWT = await  jwtService.generateJwtToken(
        userProvider.email,
        userProvider.password,
        userProvider.email,
        //Enums.getActorText(userProvider.getType)
      );

    secureStorageService.saveJWT(tokenJWT);

    return userProvider;
  }




  Future<void> _saveUserReference(Student student, SecureStorageService secureStorageService) async {    
      await secureStorageService.save(
        student.id,
        student.fullName,
        student.email,
        student.password,
        //user.type
      );
  }
}