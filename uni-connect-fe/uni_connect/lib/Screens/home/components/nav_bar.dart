import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:uni_connect/Screens/home/components/welcome_image.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uni_connect/shared/custom_alert_dialog.dart';
import 'package:uni_connect/shared/services/logout_service.dart';
import 'package:uni_connect/shared/services/storage_service.dart';

import '../../../models/student.dart';
import '../../../shared/utils/constants.dart';
import '../utils/constants_home.dart'; // Importa il pacchetto Google Fonts

/// Custom App Bar
/// Used in Every Page with Not Logged User
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      shadowColor: Color(0xA9D0ECFF),
      foregroundColor: Colors.lightBlueAccent,
      backgroundColor: Color(0x244BCCA9),
      leading: _buildImageAppBar(context),
      title: _buildTextNavBar(Constants.titleApp),
    );
  }
  
  GestureDetector _buildImageAppBar(BuildContext context){
    return GestureDetector(
      onTap: () {
        context.go("/");  // Naviga verso la home page
      },
      child: RoundedImage(logoImage),
    );
  }

 /// Build Text Nav Bar with Style 
 Text _buildTextNavBar(String title){
    return Text(
        title,
        style: GoogleFonts.quicksand( // Utilizza GoogleFonts.quicksand per applicare il font Quicksand
        textStyle: TextStyle(
            color: Colors.blueAccent, // Cambia il colore del testo
            fontSize: 20.0, // Opzionale: Modifica la dimensione del testo
            fontWeight: FontWeight.bold, // Opzionale: Modifica lo spessore del testo
        ),
      ),
    );
  }

}




/// Custom App Bar Logged
/// Used in Every Page with Logged User
/// Perform - Profile Page
/// Perform - Logout Page
/// Perform - Search Bar
class CustomAppBarLogged extends StatefulWidget implements PreferredSizeWidget{
  CustomAppBarLogged(Student? student_logged);




  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
  @override
  _CustomAppBarLoggedState createState() => _CustomAppBarLoggedState();

}

class _CustomAppBarLoggedState extends State<CustomAppBarLogged> {

  LogoutService logoutService = LogoutService();
  // Secure Storage Service - retrieve
  final storage = GetIt.I.get<SecureStorageService>();
  late SecureStorageService secureStorageService = storage;

  Student? student_logged;




  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 3,
      shadowColor: Color(0xA9D0ECFF),
      foregroundColor: Colors.lightBlueAccent,
      backgroundColor: Color(0x244BCCA9),
      leading: _buildImageAppBar(context),
      title: Row(
        children: [
          _buildTextNavBar(Constants.titleApp),
          const Spacer(),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildSearchField(),
              ],
            ),
          ),
        ],
      ),
      actions: [
        SizedBox(width: 100),
        _buildNotificationIcon(),
        SizedBox(width: 20,),
        _buildHomeIcon(),
        SizedBox(width: 20),
        // Aggiunge uno spazio tra l'icona di notifica e il menu
        _buildLogoutIcon(context),
      ],
    );
  }


  GestureDetector _buildImageAppBar(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.go("/");  // Navigate to the home page
      },
      child: RoundedImage(logoImage),
    );
  }

  Text _buildTextNavBar(String title) {
    return Text(
      title,
      style: GoogleFonts.quicksand(
        textStyle: TextStyle(
          color: Colors.blueAccent,
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildSearchField() {
    return Expanded(
      child: Container(
        alignment: Alignment.center,
        width: 300,
        padding: EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.8), // Colore di sfondo trasparente
          borderRadius: BorderRadius.circular(20), // Bordi arrotondati
        ),
        child: Row(
          children: [
            Tooltip(
              message: 'Cerca',
              child: Padding(
                padding: const EdgeInsets.only(right: 8.0), // Aggiungi spazio tra l'icona e il testo
                child: IconButton(
                  icon: Icon(
                    Icons.search,
                    color: Colors.black,
                    size: 28, // Icona di ricerca più grande
                  ), onPressed: () { return;  },
                ),
              ),
            ),
            Expanded(
              child: TextField(
                textAlign: TextAlign.start,
                decoration: InputDecoration(
                  alignLabelWithHint: true,
                  hintText: 'Search students',
                  hintStyle: TextStyle(color: Colors.black.withOpacity(0.5)), // Colore leggermente più chiaro per il testo suggerimento
                  border: InputBorder.none,
                ),
                style: TextStyle(color: Colors.black),
                onChanged: (value) {
                  // Handle search logic here
                },
              ),
            ),
          ],
        ),
      ),
    );
  }


  Widget _buildLogoutIcon(BuildContext context) {
    return IconButton(
      icon: const Tooltip(
        message: 'Logout',
        child: Icon(Icons.power_settings_new_rounded, color: Colors.redAccent),
      ),
      onPressed: () async {
        await _showLogoutConfirmationDialog(context);
      },
    );
  }


  Widget _buildNotificationIcon() {
    return Tooltip(
      message: 'Notifiche',
      child: IconButton(
        icon: Icon(
          Icons.notifications,
          color: Colors.blueAccent,
          size: 28, // Aumenta le dimensioni dell'icona
        ),
        onPressed: () {
          // Handle notification logic here
        },
      ),
    );

  }



  Future<void> _showLogoutConfirmationDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.yellow[100], // Imposta il colore di sfondo
          title: Column( // Utilizza una colonna per posizionare l'icona sopra il titolo
            mainAxisSize: MainAxisSize.min, // Imposta la dimensione principale della colonna a minimo
            children: [
              Icon(Icons.warning, color: Colors.yellow[700], size: 40), // Icona di avviso gialla
              SizedBox(height: 8), // Spazio tra l'icona e il testo del titolo
              Text('Conferma Logout', style: TextStyle(color: Colors.black)), // Testo del titolo
            ],
          ),
          content: Text('Sei sicuro di voler effettuare il logout?', style: TextStyle(color: Colors.black)), // Testo del contenuto
          actions: <Widget>[
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop(); // Chiudi il dialogo di conferma
                await _LogoutChoicePressed(); // Esegui la funzione di logout
              },
              child: Text('Conferma', style: TextStyle(color: Colors.redAccent)), // Stile del testo di conferma
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Chiudi il dialogo di conferma
              },
              child: Text('Annulla', style: TextStyle(color: Colors.blueAccent)), // Stile del testo di annulla
            ),
          ],
        );

      },
    );
  }
  
  

  Future<void> _LogoutChoicePressed() async{
    // Handle logout logic here
    print("Sto per cancellare i dati di sessione!");
    if(await logoutService.logoutStudent(secureStorageService)) {
      print("Ho cancellato i dati di sessione!");
      CustomPopUpDialog.show(context, AlertDialogType.Logout, CustomType.success,path: '/');
    }else{
      CustomPopUpDialog.show(context, AlertDialogType.Logout, CustomType.error);
      return;
    }
  }

  Widget _buildHomeIcon() {
    return IconButton(
      icon: Icon(Icons.home),
      onPressed: () {
        // Naviga alla home page
        context.go('/home-page/'+this.student_logged!.id);
      },
      tooltip: 'Home', // Tooltip per l'icona della home
    );
  }

}
