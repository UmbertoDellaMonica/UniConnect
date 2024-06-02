import 'package:flutter/material.dart';
import 'package:uni_connect/Screens/home/components/welcome_image.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../constants.dart';
import '../utils/constants_home.dart'; // Importa il pacchetto Google Fonts

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      shadowColor: Color(0xA9D0ECFF),
      foregroundColor: Colors.lightBlueAccent,
      backgroundColor: Color(0x244BCCA9),
      leading: RoundedImage(logoImage),
      title: _buildTextNavBar(Constants.titleApp),
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
