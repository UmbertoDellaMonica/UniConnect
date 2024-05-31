import 'package:bcrypt/bcrypt.dart';

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