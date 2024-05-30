import 'package:json_annotation/json_annotation.dart';
import 'package:uni_connect_front_end/shared/enums.dart';

// Definizione della classe StudentRequest
class StudentRequest {
  String email;
  String passwordHash;
  String fullName;
  String departement;

  StudentRequest({
    required this.email,
    required this.passwordHash,
    required this.fullName,
    required this.departement,
  });

  // Metodo per convertire l'oggetto in un mappa JSON
  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'passwordHash': passwordHash,
      'fullName': fullName,
      'departement': departement,
    };
  }
}
