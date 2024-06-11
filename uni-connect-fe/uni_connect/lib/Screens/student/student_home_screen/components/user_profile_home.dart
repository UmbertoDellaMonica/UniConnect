import 'package:flutter/material.dart';
import 'package:uni_connect/models/student.dart';
import 'package:uni_connect/shared/services/router_service.dart';

class UserProfileHome extends StatefulWidget {

  final Student? student_logged;
  const UserProfileHome({super.key, required this.student_logged});

  @override
  State<UserProfileHome> createState() => _UserProfileHomeState();
}

class _UserProfileHomeState extends State<UserProfileHome> {

  final RouterService _routerService = RouterService();

  @override
  Widget build(BuildContext context) {

    String fullName = widget.student_logged!.fullName;
    String id = widget.student_logged!.id;

    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            /// Image - Profile
            const CircleAvatar(
              radius: 50,
              backgroundColor: Colors.blue,
              child: Text('U'), // Placeholder per l'immagine del profilo
            ),
            const SizedBox(height: 50),
            /// Name and Suname - User
            Text(fullName, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            /// Profile - Section
            UserProfileSection(
              icon: Icons.account_circle,
              title: 'Profile',
              onPressed: () {
                // Azione per andare alle impostazioni del profilo
                _routerService.goStudentProfile(context,id);
              },
              iconColor: Colors.blue,
              textColor: Colors.black,
            ),
            /// Photo - Section
            UserProfileSection(
              icon: Icons.image_rounded,
              title: 'Le mie Foto',
              onPressed: () {
                // Azione per visualizzare i post dell'utente
              },
              iconColor: Colors.green,
              textColor: Colors.black,
            ),
            /// Follower - Section
            UserProfileSection(
              icon: Icons.account_circle,
              title: 'Followers',
              onPressed: () {
                // Azione per visualizzare la lista dei follower dell'utente
                _routerService.goStudentFollower(context, id);
              },
              iconColor: Colors.red,
              textColor: Colors.black,
            ),
            /// Followee - Section
            UserProfileSection(
              icon: Icons.people,
              title: 'Seguiti',
              onPressed: () {
                // Azione per visualizzare la lista degli utenti seguiti dall'utente
                _routerService.goStudentFollowing(context,id);
              },
              iconColor: Colors.blueAccent,
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
    super.key,
    required this.icon,
    required this.title,
    required this.onPressed,
    this.iconColor = Colors.black, // Colore predefinito per l'icona
    this.textColor = Colors.black, // Colore predefinito per il testo
  });

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
              const SizedBox(width: 10),
              Text(title, style: TextStyle(color: textColor, fontSize: 16)),
            ],
          ),
        ),
      ),
    );
  }
}
