


import 'package:uni_connect_front_end/student/student.dart';

class StudentService {



  bool SignUpStudent(String email, String fullName, String password) {
    return true;
  }

  
  
  bool login(String emailInput, String passwordInput, String selectedValueUserType) {
    return true;
  }

  Student getData(String selectedValueUserType) {
     Student student =  Student(id: "d", fullName: "fullName", password: "password", email: "email");
     return student;
  }


}