class Student{
  final String departmentUnisa;
  final String id;
  final String fullName;
  String biography;
  final String password; // Si presume che sia già crittografata dal front-end
  final String email;

  Student(  {
    required this.id,
    required this.fullName,
    required this.password,
    this.biography="",
    required this.email,
    required this.departmentUnisa
  });

  // Getters Function

  String get getId => id;

  String get getFullName => fullName;

  String get getPassword => password;

  String get getEmail => email;

  String get getBiography => biography;

  String get getDepartmentUnisa => departmentUnisa;

  static Student buildStudent(String id, String email, String fullName,String password,String departmentUnisa,String biography){
    return Student(id: id, fullName: fullName, password: password, email: email, departmentUnisa: departmentUnisa,biography: biography);
  }

  /// Metodo per deserializzare un oggetto JSON in un'istanza di Student
  /// Utilizzato quando devo ricevere dati dal Server
  factory Student.fromJson(Map<dynamic, dynamic> json) {
    return Student(
      email: json['email'],
      password: json['passwordHash'],
      fullName: json['fullName'],
      biography: json['biography'],
      departmentUnisa:  json['department'],
      id: json['ID'],
    );
  }

}