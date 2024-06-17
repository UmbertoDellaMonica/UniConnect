
import '../../../shared/utils/constants.dart';
import '../../../models/student.dart';
import '../../../shared/services/student_service.dart';

class SigninService {


  /// Injection of Service
  final PasswordService _passwordService = PasswordService();

  final StudentService _studentService = StudentService();



  /// SignInStudent - Metodo per effettuare il Login dello Studente
  /// Lo studente inserisce :
  /// - email
  /// - password
  /// - Dipartimento di Appartenenza
  /// Viene fatto un check sulla password inserita, sull'email e sul dipartimento ( se corrispondono )
  Future<bool> signInStudent(
      String email,
      String password,
      String studentDepartement,
      )async {

    /// Hashing Password del Form di Login
    String passwordHashed = _passwordService.hashPassword(password);

    /// Change Value Student Departement
    String studentDepartementSelected = Enums.getDepartmentStudent(studentDepartement);


    return _studentService.signInStudent(email, passwordHashed, studentDepartementSelected);
  }



  /// onLoginSuccess - Metodo per effettuare il recupero dei dati dello Studente
  /// Una volta che ha avuto successo il login
  Future<Student?> onLoginSuccess(String email) async {

    /// Recupero di tutte le informazioni dello studente che si è loggato
    Student? student = await _studentService.getStudent(email);
    print("Ho recuperato tutte le informazioni!");
    if(student == null){
      /// Error
      /// TODO: Error Code Correction
      print("Error : ");
      return null;
    }else{
      /// save Student Information
      print("Sono arrivato qui ---");
      return student;
    }
  }


}