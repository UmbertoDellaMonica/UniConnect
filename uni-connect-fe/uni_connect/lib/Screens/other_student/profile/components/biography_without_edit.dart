

import 'package:flutter/material.dart';

import '../../../../shared/utils/constants.dart';

class OtherStudentBiographyWidget extends StatefulWidget {
  @override
  _OtherStudentBiographyWidgetState createState() => _OtherStudentBiographyWidgetState();
}

class _OtherStudentBiographyWidgetState extends State<OtherStudentBiographyWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20.0),
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
                      Icon(Icons.person_outline, size: 30, color: Colors.blue),
                      SizedBox(width: 10),
                      Text(
                        'Biografia:',
                        style: TextStyle(
                          fontSize: 22.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Divider(),
                  SizedBox(height: 10),
                  Text(
                    Enums.loremIpsumString,
                    style: TextStyle(
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
}