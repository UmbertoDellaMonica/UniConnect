import 'package:flutter/material.dart';

class FooterBar extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        padding: EdgeInsets.all(10),
        color: Colors.grey[200],
        child: Center(
          child: Text(
            '© 2024 UniConnect. Tutti i diritti riservati.',
            style: TextStyle(
              fontSize: 14,
              color: Color.fromARGB(255, 142, 137, 190),
            ),
          ),
        ),
      ),
    );
  }

}