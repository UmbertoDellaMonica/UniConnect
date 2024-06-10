import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:uni_connect/Screens/home/components/nav_bar.dart';
import 'package:uni_connect/shared/custom_loading_bar.dart';
import 'package:uni_connect/shared/services/student_service.dart';

import '../../../../../models/student.dart';

class DesktopStudentSearchPage extends StatefulWidget {
  final String IDStudent;
  final String query;
  DesktopStudentSearchPage({
    required this.query,
    required this.IDStudent
  });

  @override
  _SearchStudentsPageState createState() => _SearchStudentsPageState();
}

class _SearchStudentsPageState extends State<DesktopStudentSearchPage> {

  StudentService studentService = StudentService();
  final TextEditingController _searchController = TextEditingController();


  List<Student> _students = [];

  bool _isLoading = false;
  late String _errorMessage = "";


  void search(String query) async {
    // Se la barra di ricerca è vuota
    if (query.isEmpty) {
      setState(() {
        _students = []; // Cancella tutti gli studenti quando la query è vuota
      });
      return; // Esci dalla funzione per evitare di eseguire la ricerca
    }else if(query.length >=2 ){

    // Altrimenti, esegui la ricerca degli studenti
    _errorMessage = "";
    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    try {
      final students = await studentService.searchStudents(query, widget.IDStudent);
      setState(() {
        _students = students;
      });
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
    }else{
      _students = [];
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarLoggedSearch(IDStudent: widget.IDStudent, onSearch: search),
      body: Column(
        children: [
          if (_isLoading) const CustomLoadingIndicator(progress: 4.5),
          if (_errorMessage.isNotEmpty) Text(_errorMessage),
          Expanded(
            child: ListView.builder(
              itemCount: _students.length,
              itemBuilder: (context, index) {
                final student = _students[index];
                return GestureDetector(
                  onTap: () {
                    // Implementa la navigazione al profilo dello studente
                    context.go('/other-student/'+_students[index].id+'/profile', extra: _students[index]);
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                    decoration: BoxDecoration(
                      border: Border(bottom: BorderSide(color: Colors.grey)),
                    ),
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundImage: AssetImage('../assets/logo.png'), // Aggiungi l'immagine dello studente
                          radius: 20.0,
                        ),
                        SizedBox(width: 16.0),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                student.fullName,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.0,
                                ),
                              ),
                              Text(
                                student.email,
                                style: TextStyle(
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 16.0),
                        ElevatedButton(
                          onPressed: () {
                            // Implementa la logica per seguire o smettere di seguire lo studente
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                          ),
                          child: Text(
                            'Segui',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
