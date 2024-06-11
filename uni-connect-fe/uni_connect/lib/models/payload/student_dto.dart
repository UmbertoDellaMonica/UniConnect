

class StudentSignupRequest {
    String email;
    String biography;
    String passwordHash;
    String fullName;
    String departement;

    StudentSignupRequest({
        required this.email,
        required this.biography,
        required this.passwordHash,
        required this.fullName,
        required this.departement,
    });

    // Metodo per convertire l'oggetto in un mappa JSON
    Map<String, dynamic> toJson() {
        return {
        'email': email,
        'passwordHash': passwordHash,
        'biography': biography,
        'fullName': fullName,
        'department': departement,
          };
        }
    }


class StudentUpdateRequest {
      String passwordHash;
      String biography;

      StudentUpdateRequest({
      required this.passwordHash,
      required this.biography,
    });

    // Metodo per convertire l'oggetto in un mappa JSON
    Map<String, dynamic> toJson() {
      return {
      'biography': biography,
      'passwordHash': passwordHash,
      };
    }
}


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