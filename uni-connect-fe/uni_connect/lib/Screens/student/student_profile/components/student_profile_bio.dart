import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:uni_connect/models/payload/student_dto.dart';
import 'package:uni_connect/shared/services/storage_service.dart';
import 'package:uni_connect/shared/services/student_service.dart';

import '../../../../models/student.dart';

class BiographyWidget extends StatefulWidget {
  final String IDStudent;
  final Student? student_logged;
  final String currentBio;
  const BiographyWidget({super.key, required this.IDStudent,this.student_logged, required this.currentBio});

  @override
  _BiographyWidgetState createState() => _BiographyWidgetState();
}

class _BiographyWidgetState extends State<BiographyWidget> {
  // Dichiarare il TextEditingController come variabile di istanza
  late TextEditingController bioController ;

  late String bio;

  final StudentService studentService = StudentService();
  late SecureStorageService secureStorageService = SecureStorageService();

  @override
  void initState() {
    super.initState();
    // Secure Storage Service - retrieve
    final storage = GetIt.I.get<SecureStorageService>();
    secureStorageService = storage;
    bioController = TextEditingController(text: widget.currentBio);
    setState(() {
      bio = widget.currentBio;
    });
  }

  @override
  void dispose() {
    bioController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: LayoutBuilder(
        builder: (context, constraints) {
          bool isWideScreen = constraints.maxWidth > 600;

          return Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.person_outline, size: 30, color: Colors.blue),
                      const SizedBox(width: 10),
                      const Text(
                        'Biografia:',
                        style: TextStyle(
                          fontSize: 22.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                      IconButton(
                        icon: const Icon(Icons.edit, color: Colors.blue),
                        onPressed: () {
                          // Logica per modificare la biografia
                          _showEditBioDialog(context, bio);
                        },
                      ),
                    ],
                  ),
                  const Divider(),
                  const SizedBox(height: 10),
                  Text(
                  bio,
                    style: const TextStyle(
                      fontSize: 16.0,
                      height: 1.5, // Aggiunge un po' di spazio tra le righe per migliorare la leggibilità
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
  Future<void> _showEditBioDialog(BuildContext context, String currentBio) async {
    bioController.text = currentBio;

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          title: const Text(
            'Modifica Biografia',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextField(
                  controller: bioController,
                  maxLength: 100,
                  maxLines: null,
                  decoration: const InputDecoration(
                    hintText: "Inserisci la nuova biografia (max 100 caratteri)",
                    border: InputBorder.none,
                  ),
                ),
              ),
            ],
          ),
          actions: [
            TextButton.icon(
              icon: const Icon(Icons.cancel, color: Colors.red),
              label: const Text(
                'Annulla',
                style: TextStyle(color: Colors.red),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton.icon(
              icon: const Icon(Icons.save, color: Colors.green),
              label: const Text(
                'Salva',
                style: TextStyle(color: Colors.green),
              ),
              onPressed: () async {
                StudentUpdateRequest studentUpdateRequest = StudentUpdateRequest(passwordHash: widget.student_logged!.password, biography: bioController.text);
                var new_student = await studentService.updateStudent(widget.IDStudent, studentUpdateRequest);
                if (new_student != null) {
                  setState(() {
                    bio = studentUpdateRequest.biography; // Aggiorna il valore di bio
                    bioController.text = bio; // Aggiorna il campo di testo
                  });
                  await secureStorageService.save(new_student);
                }
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

}
