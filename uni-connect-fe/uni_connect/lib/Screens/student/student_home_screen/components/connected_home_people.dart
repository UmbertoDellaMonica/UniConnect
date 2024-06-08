import 'package:flutter/material.dart';

class ConnectedPeopleHome extends StatelessWidget {


  const ConnectedPeopleHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Persone connesse',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const Divider(),
            Expanded(
              child: ListView.builder(
                itemCount: 40, // Numero di persone connesse
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: const CircleAvatar(
                      backgroundColor: Colors.blue,
                      child: Text('P'), // Placeholder per l'immagine
                    ),
                    title: Text('Persona ${index + 1}'),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}