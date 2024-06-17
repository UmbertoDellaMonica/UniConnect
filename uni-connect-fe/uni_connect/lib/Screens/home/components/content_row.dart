import 'package:flutter/material.dart';
import 'package:uni_connect/Screens/home/components/welcome_image.dart';
import 'package:uni_connect/shared/services/router_service.dart';

class ContentRow extends StatelessWidget {

  /// Path of the image 
  final String imagePath;

  /// Title Content
  final String titleContent;
  
  /// Description of the Section
  final String description;

  /// Showing the opposite Order 
  final bool reverseOrder;

  RouterService routerService = RouterService();


   ContentRow({super.key,
    required this.imagePath,
    required this.titleContent,
    required this.description,
    required this.reverseOrder,
  });

  @override
  Widget build(BuildContext context) {

    List<Widget> children = [
      _buildImage(),
      const SizedBox(width: 50),
      _buildSectionDescription(context)
      
    ];
    /// Check if is reverse the Order
    if (reverseOrder) {
      children = children.reversed.toList();
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
      child: Card(
        elevation: 4.0,
        color: const Color(0xA9D0ECFF),

        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Row(
            children: children,
          ),
        ),
      ),
    );
  }



  Expanded _buildImage(){
    return Expanded(
        flex: 1,
        child: RoundedImage(imagePath),
      );
  }


  Expanded _buildSectionDescription(BuildContext context){
    /// Check if there are reverse Order 
    CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.end;
    TextAlign textAlign = TextAlign.start;

    if(reverseOrder == true){
      /// Setting the Alignment to End if the Order is reverse 
      crossAxisAlignment = CrossAxisAlignment.start;
      textAlign = TextAlign.end;
    }


    return Expanded(
        flex: 3,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: crossAxisAlignment,

          children: [
            Text(
              textAlign: textAlign,
              titleContent,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              description,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Azione per il pulsante
                // Check Action
                if (titleContent.contains("Login")) {
                  routerService.goSignin(context);
                } else if (titleContent.contains("SignUp")) {
                  routerService.goSignup(context);
                } else if (titleContent.contains("Follow")) {
                  /// TODO: Inserisci la route per il contesto giusto
                }
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white, backgroundColor: Colors.blueAccent, padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24), // Colore del testo del pulsante
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30), // Bordi arrotondati
                  side: const BorderSide(color: Colors.blueAccent), // Bordo del pulsante
                ),
                elevation: 3, // Aggiungi un'ombra leggera
              ),
              child: Text(
                titleContent,
                style: const TextStyle(fontSize: 18), // Aggiorna le dimensioni del testo
              ),
            ),

          ],
        ),
      );
  }
}
