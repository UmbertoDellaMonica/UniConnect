
import 'package:flutter/material.dart';
import 'package:uni_connect/Screens/home/components/nav_bar.dart';
import 'package:uni_connect/shared/custom_loading_bar.dart';
import 'package:uni_connect/shared/services/router_service.dart';
import 'package:uni_connect/shared/services/student_service.dart';

import '../../../../../models/student.dart';

class DesktopStudentFollowingPage extends StatefulWidget {
  final String IDStudent;

  const DesktopStudentFollowingPage({Key? key, required this.IDStudent}) : super(key: key);

  @override
  _DesktopStudentFollowingPageState createState() => _DesktopStudentFollowingPageState();
}

class _DesktopStudentFollowingPageState extends State<DesktopStudentFollowingPage> {
  List<Student> following = []; // Lista dei follower

  final StudentService _studentService = StudentService();
  final RouterService _routerService = RouterService();

  bool isLoading = true;

  List<Student> _students = [];

  @override
  void initState() {
    super.initState();
    // Inizializza la lista dei follower
    _fetchFollowers();
  }

  // Metodo per recuperare i follower dello studente
  Future<void> _fetchFollowers() async {
    List<Student> retrieve_following = await _studentService.getFollowings(widget.IDStudent);

    setState(() {
      if(retrieve_following.isNotEmpty){
        following = retrieve_following;
      }
      isLoading = false;
    });
  }



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
        final students = await _studentService.searchStudents(query, widget.IDStudent);
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
    if(isLoading){
      return const CustomLoadingIndicator(progress: 4.5);
    }
    return Scaffold(
      appBar: CustomAppBarLogged(
        IDStudent: widget.IDStudent,
        onSearch: search,enableSearch: true,),
      body: isLoading
          ? const CustomLoadingIndicator(progress: 4.5)
          : following.isEmpty
          ? Center(
        child: ElevatedButton(
          onPressed: () {
            // Mostra una dialog e ritorna alla home page quando il pulsante viene premuto
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text('Nessun Follower'),
                  content: const Text('Al momento non hai nessun follower.'),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () {
                        // Torna alla home page
                        _routerService.goStudentHome(context, widget.IDStudent);
                      },
                      child: const Text('OK'),
                    ),
                  ],
                );
              },
            );
          },
          child: const Text('Torna alla Home Page'),
        ),
      )
          : Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Padding(
            padding: EdgeInsets.all(20), // Aggiunge spazio attorno al titolo
            child: Text(
              'Persone che seguo : ', // Testo del titolo
              style: TextStyle(
                fontSize: 24, // Dimensione del testo del titolo
                fontWeight: FontWeight.bold, // Stile del testo del titolo
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: following.length,
              itemBuilder: (context, index) {
                final followee = following[index];
                return Card(
                  elevation: 3, // Aggiunge un'ombra al card per farlo risaltare
                  margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20), // Margine attorno al card
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(20), // Padding interno al ListTile
                    leading: const CircleAvatar(
                      radius: 30, // Dimensione del CircleAvatar
                      backgroundImage: NetworkImage('../assets/images/welcome.jpg'), // Immagine di profilo del follower
                    ),
                    title: Text(
                      followee.fullName,
                      style: const TextStyle(
                        fontSize: 20, // Dimensione del testo del nome del follower
                        fontWeight: FontWeight.bold, // Stile del testo del nome del follower
                      ),
                    ),
                    onTap: () {
                      _routerService.goOtherStudentProfile(context, followee.id);
                      },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
