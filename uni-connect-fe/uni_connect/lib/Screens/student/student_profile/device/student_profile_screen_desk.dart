import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:uni_connect/shared/utils/constants.dart';

import '../../../../models/student.dart';
import '../../../../shared/custom_loading_bar.dart';
import '../../../../shared/design/post/post_item_profile.dart';
import '../../../../shared/services/image_services.dart';
import '../../../../shared/services/storage_service.dart';
import '../../../home/components/nav_bar.dart';

class DesktopStudentProfilePage extends StatefulWidget {
  @override
  _DesktopStudentProfilePageState createState() => _DesktopStudentProfilePageState();
}

class _DesktopStudentProfilePageState extends State<DesktopStudentProfilePage> {
  // Aggiungi qui eventuali variabili di stato necessarie
  // Aggiungi qui eventuali variabili di stato necessarie

  bool isLoading = true; // Variabile per tracciare lo stato del caricamento

  late Student? student_logged;

  late SecureStorageService secureStorageService;


  @override
  void initState() {
    super.initState();
    // Secure Storage Service - retrieve
    final storage = GetIt.I.get<SecureStorageService>();
    secureStorageService = storage;
    // Simula un caricamento asincrono dei dati per 2 secondi
    Future.delayed(Duration(seconds: 1), () {
      
    });

    // Esegui la navigazione solo dopo che la pagina è stata completamente costruita
    _fetchData();
  }

  Future<void> _fetchData() async {
      var retrieveUser = await secureStorageService.get();
      if (retrieveUser != null) {
        print("OK!");
        setState(() {
          student_logged = retrieveUser;
          isLoading=false;
        });
      }else{
        print("Error");
      }
  }


  @override
  void dispose() {
    super.dispose();
  }


  static List<String> studentImagePaths = [
    '../assets/images/follow.jpg',
    '../assets/images/follow.jpg',
    '../assets/images/follow.jpg',
    '../assets/images/follow.jpg',
    '../assets/images/follow.jpg',
    '../assets/images/follow.jpg',
    '../assets/images/follow.jpg',
    '../assets/images/follow.jpg',
    '../assets/images/follow.jpg',
    // Aggiungi più URL di immagini come desiderato
  ];

  @override
  Widget build(BuildContext context) {

    if(isLoading){
      return CustomLoadingIndicator(progress: 4.5);
    }
    return Scaffold(
      appBar: CustomAppBarLogged(this.student_logged),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            /// Cover -Image Profile
            _buildCoverImage(),
            /// Information and BioGraphy- Profile
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: _buildPersonalInformation(),
                ),
                SizedBox(width: 20.0), // Spazio tra le due sezioni
                Expanded(
                  child: _buildBiography(),
                ),
              ],
            ),
            Divider(),
            buildRecentPost(),
            Divider(),
            _buildRecentPhoto(studentImagePaths)
            ],
        ),
      ),
    );
  }


  Widget _buildPersonalInformation() {
    return Padding(
      padding: EdgeInsets.all(20.0),
      child: LayoutBuilder(
        builder: (context, constraints) {
          bool isWideScreen = constraints.maxWidth > 600;

          return Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.person, size: 30, color: Colors.blue),
                      SizedBox(width: 10),
                      Text(
                        this.student_logged!.fullName,
                        style: TextStyle(
                          fontSize: 22.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Divider(),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Icon(Icons.school, size: 30, color: Colors.blue),
                      SizedBox(width: 10),
                      Text(
                        'Università degli Studi di Salerno',
                        style: TextStyle(
                          fontSize: 18.0,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Icon(Icons.account_balance, size: 30, color: Colors.blue),
                      SizedBox(width: 10),
                      Text(
                        'Dipartimento: ' + this.student_logged!.departmentUnisa,
                        style: TextStyle(
                          fontSize: 18.0,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Icon(Icons.email, size: 30, color: Colors.blue),
                      SizedBox(width: 10),
                      Text(
                        'Email: ' + this.student_logged!.email,
                        style: TextStyle(
                          fontSize: 18.0,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Icon(Icons.lock, size: 30, color: Colors.blue),
                      SizedBox(width: 10),
                      Text(
                        'Password: ••••••••', // Non mostrare la password reale per motivi di sicurezza
                        style: TextStyle(
                          fontSize: 18.0,
                        ),
                      ),
                      Spacer(),
                      IconButton(
                        icon: Icon(Icons.edit, color: Colors.blue),
                        onPressed: () {
                          // Logica per modificare la password
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildBiography() {
    return Padding(
      padding: EdgeInsets.all(20.0),
      child: LayoutBuilder(
        builder: (context, constraints) {
          bool isWideScreen = constraints.maxWidth > 600;

          return Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.person_outline, size: 30, color: Colors.blue),
                      SizedBox(width: 10),
                      Text(
                        'Biografia:',
                        style: TextStyle(
                          fontSize: 22.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Spacer(),
                      IconButton(
                        icon: Icon(Icons.edit, color: Colors.blue),
                        onPressed: () {
                          // Logica per modificare la biografia
                        },
                      ),
                    ],
                  ),
                  Divider(),
                  SizedBox(height: 10),
                  Text(
                    Enums.loremIpsumString,
                    style: TextStyle(
                      fontSize: 16.0,
                      height: 1.5, // Aggiunge un po' di spazio tra le righe per migliorare la leggibilità
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  final ImageUploadService _imageUploadService = ImageUploadService();

  Widget _buildCoverImage() {
    return Stack(
      children: [
        Container(
          height: 200.0,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(
                  '../assets/images/follow.jpg'), // URL dell'immagine di copertina
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          top: 10,
          right: 10,
          child: IconButton(
            icon: Icon(Icons.edit, color: Colors.white, size: 30),
            onPressed: () async {
              await _imageUploadService.uploadCoverImage(this.student_logged!.email);
              // Aggiungi qui il codice per aggiornare lo stato della tua app in modo che mostri la nuova immagine
            },
          ),
        ),
        Positioned(
          bottom: 0,
          left: 16.0,
          child: Stack(
            children: [
              CircleAvatar(
                radius: 50.0,
                backgroundImage: NetworkImage(
                    '../assets/images/follow.jpg'), // URL dell'immagine del profilo
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: InkWell(
                  onTap: () async {
                    await _imageUploadService.uploadProfileImage(this.student_logged!.email);
                    // Aggiungi qui il codice per aggiornare lo stato della tua app in modo che mostri la nuova immagine
                  },
                  child: CircleAvatar(
                    radius: 15,
                    backgroundColor: Colors.blue,
                    child: Icon(Icons.add, color: Colors.white, size: 20),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildRecentPost() {
    return Container(
      margin: EdgeInsets.all(30),
      padding: EdgeInsets.all(20),
      child: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Post Recenti:',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10.0),
            // Utilizza un ListView.builder per generare dinamicamente gli elementi della lista dei post
            GridView.builder(
              padding: EdgeInsets.all(20),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 10,
                mainAxisSpacing: 15,
                childAspectRatio: 2.0, // Rappresenta il rapporto tra larghezza e altezza degli elementi
                mainAxisExtent: 200, // Altezza fissa degli elementi della griglia
              ),
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(), // Per evitare che il ListView all'interno di un Column scrolli
              itemCount: 30, // Sostituisci numberOfPosts con il numero effettivo di post
              itemBuilder: (BuildContext context, int index) {
                return PostItemProfile(index: index);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentPhoto(List<String> imagePaths) {
    return Container(
      margin: EdgeInsets.all(30),
      padding: EdgeInsets.all(20),
      child: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Foto Recenti:',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10.0),
            Flexible(
              fit: FlexFit.loose,
              child: GridView.builder(
                padding: EdgeInsets.all(20),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 1.0, // Rappresenta il rapporto tra larghezza e altezza degli elementi
                  mainAxisExtent: 300, // Altezza fissa degli elementi della griglia
                ),
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(), // Per evitare che il ListView all'interno di un Column scrolli
                itemCount: imagePaths.length,
                itemBuilder: (BuildContext context, int index) {
                  return Image.network(
                    imagePaths[index],
                    fit: BoxFit.fill,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }




}
