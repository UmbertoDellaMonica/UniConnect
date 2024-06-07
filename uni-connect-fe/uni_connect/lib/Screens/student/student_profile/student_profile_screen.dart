import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:uni_connect/Screens/home/components/footer_bar.dart';
import 'package:uni_connect/Screens/home/components/nav_bar.dart';
import 'package:uni_connect/shared/custom_loading_bar.dart';

import '../../../models/student.dart';
import '../../../shared/services/storage_service.dart';
import '../student_home_screen/components/post/post_item.dart';

class StudentProfileScreen extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return _StudentProfileScreenState();
  }

  final String IDStudent;

  StudentProfileScreen({required this.IDStudent});


}




class _StudentProfileScreenState extends State<StudentProfileScreen>{


  late Student? student_logged;

  late SecureStorageService secureStorageService;
  bool isLoading = true; // Variabile per tracciare lo stato del caricamento



  @override
  Widget build(BuildContext context) {
    if(isLoading){
      return CustomLoadingIndicator(progress: 4.5);
    }
    
    return Scaffold(
      appBar: CustomAppBarLogged(student_logged),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Prima riga: UserProfileSection() e DepartmentSection()
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: UserProfileSection()),
                SizedBox(width: 20), // Spazio tra le sezioni
                Expanded(child: DepartmentSection()),
              ],
            ),
            SizedBox(height: 20), // Spazio tra le sezioni

            // Seconda riga: FriendListSection()
            FriendListSection(),
            SizedBox(height: 20), // Spazio tra le sezioni

            // Terza riga: PostSection() e PhotoSection()
          PostSection(),
          SizedBox(width: 20), // Spazio tra le sezioni
          PhotoSection(),

            SizedBox(height: 20), // Spazio tra le sezioni

            // Footer personalizzato
            FooterBar(),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    // Secure Storage Service - retrieve
    final storage = GetIt.I.get<SecureStorageService>();
    secureStorageService = storage;


    // Esegui la navigazione solo dopo che la pagina è stata completamente costruita
    WidgetsBinding.instance?.addPostFrameCallback((_) async {
      var retrieveUser = await secureStorageService.get();
      student_logged = retrieveUser;
      if (student_logged != null) {
        print("OK!");
        this.isLoading = false;
      }else{
        print("Error");
      }
    });
  }
}



class UserProfileSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Dati di esempio per il profilo
    String name = 'Nome Cognome';
    String email = 'studente@example.com';
    String password = '*********'; // Password nascosta per motivi di sicurezza
    String profileImage = 'images/chat.jpg'; // Immagine di esempio del profilo

    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey), // Aggiungi il bordo
        borderRadius: BorderRadius.circular(10), // Aggiungi i bordi arrotondati
      ),
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Foto del profilo
          Center(
            child: CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage(profileImage),
            ),
          ),
          SizedBox(height: 20),
          // Nome
          Text(
            name,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          // Email
          Text(
            'Email: $email',
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 10),
          // Password
          Text(
            'Password: $password',
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}


// Sezione per l'elenco degli amici

class FriendListSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Esempio di lista di amici
    List<Map<String, dynamic>> friendList = [
      {'name': 'Amico 1', 'image': 'assets/amico1.jpg'},
      {'name': 'Amico 2', 'image': 'assets/amico2.jpg'},
      {'name': 'Amico 3', 'image': 'assets/amico3.jpg'},
    ];

    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey), // Aggiungi il bordo
        borderRadius: BorderRadius.circular(10), // Aggiungi i bordi arrotondati
      ),
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Elenco Amici',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10), // Aggiungi spazio tra il titolo e la lista degli amici
          // Lista degli amici
          ListView.builder(
            shrinkWrap: true,
            itemCount: friendList.length,
            itemBuilder: (context, index) {
              // Ottieni i dati dell'amico corrente
              final friend = friendList[index];
              return ListTile(
                leading: CircleAvatar(
                  backgroundImage: AssetImage(friend['image']),
                ),
                title: Text(friend['name']),
              );
            },
          ),
        ],
      ),
    );
  }
}


// Sezione per il dipartimento di appartenenza
class DepartmentSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey), // Aggiungi il bordo
        borderRadius: BorderRadius.circular(10), // Aggiungi i bordi arrotondati
      ),
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Dipartimento di Appartenenza',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          // Qui dovresti inserire il widget per visualizzare il dipartimento di appartenenza dello studente
        ],
      ),
    );
  }
}


class BiographySection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Biografia di esempio
    String biography =
        'Sono uno studente appassionato di informatica presso l\'Università XYZ. '
        'Ho una forte passione per lo sviluppo di app mobili e ho già lavorato su vari progetti '
        'che hanno migliorato le esperienze degli utenti. Al di fuori degli studi, amo viaggiare '
        'e sperimentare nuove culture.';

    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey), // Aggiungi il bordo
        borderRadius: BorderRadius.circular(10), // Aggiungi i bordi arrotondati
      ),
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Biografia',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Text(
            biography,
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}


// Sezione per i post dello studente
class PostSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey), // Aggiungi il bordo
        borderRadius: BorderRadius.circular(10), // Aggiungi i bordi arrotondati
      ),
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'I Tuoi Post',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),

      SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Visualizzazione dei post degli altri utenti
            GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 8,
                mainAxisSpacing: 10.0,
                crossAxisSpacing: 10.0,
                childAspectRatio: 0.6, // Modifica questo valore per ottenere più post visualizzati sulle righe
              ),
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: 30,
              itemBuilder: (context, index) {
                return PostItem(index: index);
              },
            )


          ],
        ),
      )
        ],
      ),
    );
  }
}

// Sezione per le foto dello studente
class PhotoSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey), // Aggiungi il bordo
        borderRadius: BorderRadius.circular(10), // Aggiungi i bordi arrotondati
      ),
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Le Tue Foto',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          // Qui dovresti inserire il widget per visualizzare le foto dello studente
        ],
      ),
    );
  }
}
