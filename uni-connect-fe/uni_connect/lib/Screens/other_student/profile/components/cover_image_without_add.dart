import 'package:flutter/material.dart';
import '../../../../shared/services/image_services.dart';

class OtherStudentCoverImageWidget extends StatefulWidget {
  final String userEmail;
  final ImageUploadService imageUploadService;

  const OtherStudentCoverImageWidget({
    required this.userEmail,
    required this.imageUploadService,
  });

  @override
  _OtherStudentCoverImageWidgetState createState() => _OtherStudentCoverImageWidgetState();
}

class _OtherStudentCoverImageWidgetState extends State<OtherStudentCoverImageWidget> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 200.0,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(
                  '../assets/images/follow.jpg'), // URL dell'immagine di copertina
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          left: 16.0,
          child: Stack(
            children: [
              CircleAvatar(
                radius: 50.0,
                backgroundImage: NetworkImage(
                    '../assets/images/follow.jpg'), // URL dell'immagine del profilo
              ),
            ],
          ),
        ),
      ],
    );
  }
}
