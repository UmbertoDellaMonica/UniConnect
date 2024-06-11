import 'package:flutter/material.dart';
import 'package:uni_connect/models/student.dart';

import '../../../models/payload/post_dto.dart';

class PostItemProfile extends StatelessWidget {
  final int index;
  final Student? student_logged;
  final PostResponse? postResponse;
  final Function onDelete;
  final Function onEdit;

  PostItemProfile({
    required this.index,
    required this.student_logged,
    required this.postResponse,
    required this.onDelete,
    required this.onEdit
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Check if the screen is narrow or wide
        bool isWideScreen = constraints.maxWidth > 600;
        print("Contenuto della risposta : "+this.postResponse!.content);

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
                      const CircleAvatar(
                        backgroundColor: Colors.blue,
                        child: Text('U'), // Placeholder per l'immagine
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(this.student_logged!.fullName),
                      ),
                      PopupMenuButton<String>(
                        onSelected: (value) {
                          if (value == 'Elimina Post') {
                            this.onDelete();
                          } else if (value == 'Modifica Post') {
                            this.onEdit();
                          }
                        },
                        itemBuilder: (BuildContext context) {
                          return {'Elimina Post', 'Modifica Post'}.map((String choice) {
                            return PopupMenuItem<String>(
                              value: choice,
                              child: Text(choice),
                            );
                          }).toList();
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(this.postResponse!.content),
                  const SizedBox(height: 10),
                  // Aggiungi qui il widget per le immagini del post se necessario
                  const Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween, // Allinea i bottoni alla fine
                    children: [
                      IconButton(
                        icon: const Icon(Icons.thumb_up_alt_outlined),
                        onPressed: () {
                          // Azione per mettere "mi piace" al post
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.comment_outlined),
                        onPressed: () {
                          // Azione per commentare il post
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.share_outlined),
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
