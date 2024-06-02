import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class CustomLoadingIndicator extends StatelessWidget {
  final double progress;

  const CustomLoadingIndicator({Key? key, required this.progress}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Progressione lineare
          Container(
            height: 8,
            width: 200,
            margin: EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              color: Colors.grey[200], // Colore dello sfondo
              borderRadius: BorderRadius.circular(4),
            ),
            child: FractionallySizedBox(
              widthFactor: progress, // Dove 'progress' è un valore tra 0 e 1 che rappresenta la percentuale di avanzamento
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.blue, // Colore della barra di progressione
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
          ),

          // Progressione circolare con testo
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
              ),
              SizedBox(width: 16),
              Text(
                'Loading...',
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),

          // Personalizzazione con Flutter Spinkit
          SizedBox(height: 16),
          SpinKitDoubleBounce(
            color: Colors.blue, // Colore della barra di progressione
            size: 50.0, // Dimensione della barra di progressione
          ),
        ],
      ),
    );
  }
}
