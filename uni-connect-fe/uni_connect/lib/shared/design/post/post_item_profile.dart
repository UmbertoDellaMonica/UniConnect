import 'package:flutter/material.dart';

class PostItemProfile extends StatelessWidget {
  final int index;

  PostItemProfile({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Check if the screen is narrow or wide
        bool isWideScreen = constraints.maxWidth > 600;

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Card(
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.blue,
                        child: Text('U'), // Placeholder per l'immagine
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Text('Utente ${index + 1}'),
                      ),
                      PopupMenuButton<String>(
                        onSelected: (value) {
                          if (value == 'Elimina Post') {
                            // Logica per segnalare il post
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Post eliminato')),
                            );
                          }
                        },
                        itemBuilder: (BuildContext context) {
                          return {'Elimina Post'}.map((String choice) {
                            return PopupMenuItem<String>(
                              value: choice,
                              child: Text(choice),
                            );
                          }).toList();
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Text('Testo del post'),
                  SizedBox(height: 10),
                  // Aggiungi qui il widget per le immagini del post se necessario
                  Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween, // Allinea i bottoni alla fine
                    children: [
                      IconButton(
                        icon: Icon(Icons.thumb_up_alt_outlined),
                        onPressed: () {
                          // Azione per mettere "mi piace" al post
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.comment_outlined),
                        onPressed: () {
                          // Azione per commentare il post
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.share_outlined),
                        onPressed: () {
                          // Azione per condividere il post
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
