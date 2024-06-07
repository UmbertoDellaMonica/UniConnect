
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PostItem extends StatelessWidget {
  final int index;

  PostItem({required this.index});

  @override
  Widget build(BuildContext context) {
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.blue,
                    child: Text('U'), // Placeholder per l'immagine
                  ),
                  SizedBox(width: 10),
                  Text('Utente ${index + 1}'),
                ],
              ),
              SizedBox(height: 10),
              Text('Testo del post'),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
  }
}
