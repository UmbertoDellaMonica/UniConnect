
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../models/student.dart';

class SecureStorageService{

  SecureStorageService._internal();

  static final SecureStorageService instance = SecureStorageService._internal();

  factory SecureStorageService()  {
    final instance = SecureStorageService._internal();
    return instance;
  }



  final FlutterSecureStorage storage = FlutterSecureStorage(webOptions: WebOptions());



  /// save - Metodo che salva tutte le informazioni dello Studente all'interno della Sessione
  /// Salvataggio in base a <key-value>
  Future<void> save(Student student) async {

    try {
      print("Sono arrivato qui!");
      await storage.write(key: 'user_id', value: student.id);
      await storage.write(key: 'full_name', value: student.fullName);
      await storage.write(key: 'email', value: student.email);
      await storage.write(key: 'password', value: student.password);
      await storage.write(key: 'type', value: student.departmentUnisa.toString());
    } catch (e) {
      // Handle errors appropriately (e.g., logging, user feedback)
      print('Error saving user data: $e');
    }
  }



  /// Get - metodo per ottenere tutti i dati dello Studente
  Future<Student?> get() async {
    try {

      final id = await storage.read(key: 'user_id');
      final fullName = await storage.read(key: 'full_name');
      final email = await storage.read(key: 'email');
      final password = await storage.read(key: 'password');
      final studentDepartement = await storage.read(key: 'type');
      /// Check Params - verifica se sono nulli
      if ( this._checkParams(id!, email!, fullName!, password!, studentDepartement!) ) {
        return Student.buildStudent(id, email, fullName, password, studentDepartement as String);
      }else{
        return null;
      }

    } catch (e) {
      // Handle errors appropriately (e.g., logging, user feedback)
      print("Errror: "+e.toString());
      return null;
    }
  }

  // **Delete User data:**
  Future<bool> delete() async {
    try {
      await storage.delete(key: 'user_id');
      await storage.delete(key: 'full_name');
      await storage.delete(key: 'email');
      await storage.delete(key: 'password');
      await storage.delete(key: 'type');
      return true;
    } catch (e) {
      // Handle errors appropriately (e.g., logging, user feedback)
      print('Error deleting user data: $e');
      return false;
    }
  }



  /// checkParams - Semplice controllo dei parametri per vedere che nessuno di loro è nullo
  bool _checkParams(String id,String email,String fullName,String password,String departement){
    if ( id != null && fullName != null && email != null && password!=null && departement!=null ){
      return true;
    }
    return false;
  }


}