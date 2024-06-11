import 'package:flutter/material.dart';
import '../../../../shared/services/image_services.dart';

class CoverImageWidget extends StatefulWidget {
  final String userEmail;
  final ImageUploadService imageUploadService;
  final bool enableEditing;

  const CoverImageWidget({
    required this.userEmail,
    required this.imageUploadService,
    required this.enableEditing,
  });

  @override
  _CoverImageWidgetState createState() => _CoverImageWidgetState();
}

class _CoverImageWidgetState extends State<CoverImageWidget> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 200.0,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(
                  '../assets/images/follow.jpg'), // URL dell'immagine di copertina
              fit: BoxFit.cover,
            ),
          ),
        ),
        if(widget.enableEditing)
        Positioned(
          top: 10,
          right: 10,
          child: IconButton(
            icon: const Icon(Icons.edit, color: Colors.white, size: 30),
            onPressed: () async {
                if(widget.enableEditing){
                await widget.imageUploadService.uploadCoverImage(widget.userEmail);
                }
              // Aggiungi qui il codice per aggiornare lo stato della tua app in modo che mostri la nuova immagine
            },
          ),
        ),
        Positioned(
          bottom: 0,
          left: 16.0,
          child: Stack(
            children: [
              const CircleAvatar(
                radius: 50.0,
                backgroundImage: NetworkImage(
                    '../assets/images/follow.jpg'), // URL dell'immagine del profilo
              ),
              if(widget.enableEditing)
              Positioned(
                bottom: 0,
                right: 0,
                child: InkWell(
                  onTap: () async {
                    if(widget.enableEditing){
                      await widget.imageUploadService.uploadProfileImage(widget.userEmail);
                    }
                    // Aggiungi qui il codice per aggiornare lo stato della tua app in modo che mostri la nuova immagine
                  },
                  child: const CircleAvatar(
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
}
