
// Definizione della classe StudentSignUpRequest

class StudentSignupRequest {
  String email;
  String passwordHash;
  String fullName;
  String departement;

  StudentSignupRequest({
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
      'department': departement,
    };
  }
}


// Definizione della classe StudentSignInRequest
class StudentSigninRequest {
  String email;
  String passwordHash;
  String department;

  StudentSigninRequest({
    required this.email,
    required this.passwordHash,
    required this.department,
  });

  // Metodo per convertire l'oggetto in un mappa JSON
  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'passwordHash': passwordHash,
      'department': department,
    };
  }
}