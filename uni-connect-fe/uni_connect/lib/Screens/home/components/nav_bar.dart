import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:uni_connect/Screens/home/components/welcome_image.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uni_connect/shared/custom_alert_dialog.dart';
import 'package:uni_connect/shared/services/logout_service.dart';
import 'package:uni_connect/shared/services/router_service.dart';
import 'package:uni_connect/shared/services/storage_service.dart';

import '../../../models/student.dart';
import '../../../shared/utils/constants.dart';
import '../utils/constants_home.dart'; // Importa il pacchetto Google Fonts

/// Custom App Bar
/// Used in Every Page with Not Logged User
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      shadowColor: const Color(0xA9D0ECFF),
      foregroundColor: Colors.lightBlueAccent,
      backgroundColor: const Color(0x244BCCA9),
      leading: _buildImageAppBar(context),
      title: _buildTextNavBar(Constants.titleApp),
    );
  }

}


class CustomAppBarLogged extends StatefulWidget implements PreferredSizeWidget {

  final Student? student_logged;
  final String? IDStudent;
  final Function(String)? onSearch; // Now it's optional
  final bool enableSearch;

  const CustomAppBarLogged({
    super.key,
    this.student_logged,
    this.onSearch, // Optional search function
    this.IDStudent, // Optional when
    this.enableSearch = false, // Default to false
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  _CustomAppBarLoggedState createState() => _CustomAppBarLoggedState();
}

class _CustomAppBarLoggedState extends State<CustomAppBarLogged> {
  final LogoutService _logoutService = LogoutService();
  final RouterService _routerService = RouterService();

  // Secure Storage Service - retrieve
  final storage = GetIt.I.get<SecureStorageService>();
  late SecureStorageService secureStorageService = storage;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 3,
      shadowColor: const Color(0xA9D0ECFF),
      foregroundColor: Colors.lightBlueAccent,
      backgroundColor: const Color(0x244BCCA9),
      leading: _buildImageAppBar(context),
      title: Row(
        children: [
          _buildTextNavBar(Constants.titleApp),
          const Spacer(),
          if (widget.enableSearch)
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
        const SizedBox(width: 100),
        _buildNotificationIcon(),
        const SizedBox(width: 20),
        _buildHomeIcon(context, _routerService, widget.IDStudent),
        const SizedBox(width: 20),
        _buildLogoutIcon(context, _logoutService, secureStorageService),
      ],
    );
  }

  Widget _buildSearchField() {
    return Expanded(
      child: Container(
        alignment: Alignment.center,
        width: 300,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.8), // Colore di sfondo trasparente
          borderRadius: BorderRadius.circular(20), // Bordi arrotondati
        ),
        child: Row(
          children: [
            Tooltip(
              message: 'Cerca',
              child: Padding(
                padding: const EdgeInsets.only(right: 8.0),
                // Aggiungi spazio tra l'icona e il testo
                child: IconButton(
                  icon: const Icon(
                    Icons.search,
                    color: Colors.black,
                    size: 28, // Icona di ricerca più grande
                  ),
                  onPressed: () {
                    if (widget.onSearch == null) {
                      // Redirect to search page if onSearch is not provided
                      _routerService.goStudentSearch(
                          context, widget.student_logged!.id);
                    }
                  },
                ),
              ),
            ),
            Expanded(
              child: TextField(
                onChanged: widget.onSearch,
                onTap: () {
                  if (widget.onSearch == null) {
                    // Redirect to search page if onSearch is not provided
                    _routerService.goStudentSearch(
                        context, widget.IDStudent);
                  }
                },
                textAlign: TextAlign.start,
                decoration: InputDecoration(
                  alignLabelWithHint: true,
                  hintText: 'Search students',
                  hintStyle: TextStyle(color: Colors.black.withOpacity(0.5)),
                  border: InputBorder.none,
                ),
                style: const TextStyle(color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


/// Build Text Nav Bar
Widget _buildTextNavBar(String title){
  return Text(
    title,
    style: GoogleFonts.quicksand( // Utilizza GoogleFonts.quicksand per applicare il font Quicksand
      textStyle: const TextStyle(
        color: Colors.blueAccent, // Cambia il colore del testo
        fontSize: 20.0, // Opzionale: Modifica la dimensione del testo
        fontWeight: FontWeight.bold, // Opzionale: Modifica lo spessore del testo
      ),
    ),
  );
}

/// Build Image to App Bar
GestureDetector _buildImageAppBar(BuildContext context) {
  return GestureDetector(
    onTap: () {
      context.go("/");  // Navigate to the home page
    },
    child: RoundedImage(logoImage),
  );
}

/// Build Notification Icon App Bar
Widget _buildNotificationIcon() {
  return Tooltip(
    message: 'Notifiche',
    child: IconButton(
      icon: const Icon(
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


Widget _buildHomeIcon(context,routerService,id) {

  return IconButton(
    icon: const Icon(Icons.home),
    onPressed: () {
      // Naviga alla home page
      routerService.goStudentHome(context,id);
    },
    tooltip: 'Home', // Tooltip per l'icona della home
  );
}


Widget _buildLogoutIcon(BuildContext context,LogoutService logoutService,SecureStorageService secureStorageService) {
  return IconButton(
    icon: const Tooltip(
      message: 'Logout',
      child: Icon(Icons.power_settings_new_rounded, color: Colors.redAccent),
    ),
    onPressed: () async {
      await _showLogoutConfirmationDialog(context,logoutService,secureStorageService);
    },
  );
}


Future<void> _showLogoutConfirmationDialog(BuildContext context,LogoutService logoutService,SecureStorageService secureStorageService) async {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.yellow[100], // Imposta il colore di sfondo
        title: Column( // Utilizza una colonna per posizionare l'icona sopra il titolo
          mainAxisSize: MainAxisSize.min, // Imposta la dimensione principale della colonna a minimo
          children: [
            Icon(Icons.warning, color: Colors.yellow[700], size: 40), // Icona di avviso gialla
            const SizedBox(height: 8), // Spazio tra l'icona e il testo del titolo
            const Text('Conferma Logout', style: TextStyle(color: Colors.black)), // Testo del titolo
          ],
        ),
        content: const Text('Sei sicuro di voler effettuare il logout?', style: TextStyle(color: Colors.black)), // Testo del contenuto
        actions: <Widget>[
          TextButton(
            onPressed: () async {
              Navigator.of(context).pop(); // Chiudi il dialogo di conferma
              await _LogoutChoicePressed(context,logoutService,secureStorageService); // Esegui la funzione di logout
            },
            child: const Text('Conferma', style: TextStyle(color: Colors.redAccent)), // Stile del testo di conferma
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Chiudi il dialogo di conferma
            },
            child: const Text('Annulla', style: TextStyle(color: Colors.blueAccent)), // Stile del testo di annulla
          ),
        ],
      );

    },
  );
}



Future<void> _LogoutChoicePressed(context,logoutService,secureStorageService) async{
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