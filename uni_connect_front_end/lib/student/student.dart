class Student{
  final String id;
  final String fullName;
  final String password; // Si presume che sia già crittografata dal front-end
  final String email;

  const Student( {
    required this.id,
    required this.fullName,
    required this.password,
    required this.email,
  });

  // Getters Function 
  
  String get getId => id;

  String get getFullName => fullName;
  
  String get getPassword => password; 
  
  String get getEmail => email;


}