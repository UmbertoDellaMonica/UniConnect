import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class UserProfileHome extends StatelessWidget {

  final String IDStudent;
  UserProfileHome({super.key, required this.IDStudent});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CircleAvatar(
              radius: 50,
              backgroundColor: Colors.blue,
              child: Text('U'), // Placeholder per l'immagine del profilo
            ),
            SizedBox(height: 10),
            Text('Nome Utente', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            UserProfileSection(
              icon: Icons.account_circle,
              title: 'Profile',
              onPressed: () {
                // Azione per andare alle impostazioni del profilo
                context.go('/student/'+this.IDStudent+'/profile');
              },
              iconColor: Colors.blue,
              textColor: Colors.black,
            ),
            UserProfileSection(
              icon: Icons.image_rounded,
              title: 'Le mie Foto',
              onPressed: () {
                // Azione per visualizzare i post dell'utente
              },
              iconColor: Colors.green,
              textColor: Colors.black,
            ),
            UserProfileSection(
              icon: Icons.people,
              title: 'Amici',
              onPressed: () {
                // Azione per visualizzare la lista degli amici dell'utente
              },
              iconColor: Colors.red,
              textColor: Colors.black,
            ),
          ],
        ),
      ),
    );
  }
}

class UserProfileSection extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onPressed;
  final Color iconColor;
  final Color textColor;

  const UserProfileSection({
    Key? key,
    required this.icon,
    required this.title,
    required this.onPressed,
    this.iconColor = Colors.black, // Colore predefinito per l'icona
    this.textColor = Colors.black, // Colore predefinito per il testo
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(

      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.transparent), // Aggiungiamo il bordo
          borderRadius: BorderRadius.circular(30), // Aggiungiamo i bordi arrotondati
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            children: [
              Icon(icon, color: iconColor),
              SizedBox(width: 10),
              Text(
                title,
                style: TextStyle(color: textColor, fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
