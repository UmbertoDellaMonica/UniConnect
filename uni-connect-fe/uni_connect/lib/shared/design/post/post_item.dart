import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:uni_connect/models/payload/post_dto.dart';
import 'package:timeago/timeago.dart' as timeago;


class PostItem extends StatefulWidget {

  final PostResponse post;
  PostItem({ required this.post});

  @override
  _PostItemState createState() => _PostItemState();
}

class _PostItemState extends State<PostItem> {
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
          child: LayoutBuilder(
            builder: (context, constraints) {
              // Check if the screen is narrow or wide
              bool isWideScreen = constraints.maxWidth > 600;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.blue,
                        child: Text('U'), // Placeholder per l'immagine
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Text('Utente'),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          PopupMenuButton<String>(
                            onSelected: (value) {
                              if (value == 'Segnala') {
                                // Logica per segnalare il post
                              }
                            },
                            itemBuilder: (BuildContext context) {
                              return {'Segnala'}.map((String choice) {
                                return PopupMenuItem<String>(
                                  value: choice,
                                  child: Text(choice),
                                );
                              }).toList();
                            },
                          ),
                          Text(
                            timeago.format(DateTime.parse(widget.post.created_at)),
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),


                    ],
                  ),
                  SizedBox(height: 10),
                  Text(widget.post.content),
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
              );
            },
          ),
        ),
      ),
    );
  }
}

