import 'package:uni_connect_front_end/shared/services/secure_storage_service.dart';

class LogoutService {


  /// Logout - Mi permette di eliminare tutti i dati che ho raccolto durante il Login 
  /// Viene utilizzata quando un utente vuole uscire dal sito web 
  Future<bool> logoutStudent(SecureStorageService secureStorageService)async {

     return await secureStorageService.delete();

  }



}