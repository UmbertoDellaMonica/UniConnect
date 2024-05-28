import 'package:uni_connect_front_end/shared/components/atoms/custom_button.dart';
import 'package:uni_connect_front_end/shared/enums.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomPopUpDialog  {

  static String getPopupTitle(AlertDialogType dialogType, CustomType result) {

    bool isSuccess = result == CustomType.success; //Se il result è un successo restituisce true, altrimenti false

    switch(dialogType) {
      case AlertDialogType.Signup:
        return (isSuccess) ? "Registrazione avvenuta con successo." : "Errore durante la registrazione.";
      
      case AlertDialogType.Signin:
        return (isSuccess) ? "Autenticazione avvenuta con successo." : "Errore durante l'autenticazione.";

      case AlertDialogType.Buy:
        return (isSuccess) ? "Acquisto avvenuto con successo." : "Errore durante l'acquisto.";

      case AlertDialogType.Conversion:
        return (isSuccess) ? "Conversione avvenuta con successo." : "Errore durante la conversione.";

      //La add è sclusiva del MilkBatch
      case AlertDialogType.Add:
        return (isSuccess) ? "Aggiunta avvenuta con successo." : "Errore durante l'aggiunta.";
    }

  }

  static String getPopupBody(AlertDialogType dialogType, CustomType result, {String? productName, String? errorDetail}){
    
    bool isSuccess = result == CustomType.success; //Se il result è un successo restituisce true, altrimenti false

    switch(dialogType) {
      case AlertDialogType.Signup:
        return (isSuccess) ? "Grazie per esserti registrato, ora puoi accedere alla nostra app." : "La registrazione non è andata a buon fine, ti invitiamo a riprovare. $errorDetail";
      
      case AlertDialogType.Signin:
        return (isSuccess) ? "Premi Ok per accedere essere indirizzato all'area utente." : "L'autenticazione non è andata a buon fine, ti invitiamo a riprovare. $errorDetail";

      case AlertDialogType.Buy:
        return (isSuccess) ? "Hai acquistato il prodotto $productName e ora puoi visualizzarlo nella pagina apposita." : "L'acquisto del prodotto $productName non è andato a buon fine. $errorDetail";

      case AlertDialogType.Conversion:
        return (isSuccess) ? "Hai convertito il prodotto $productName e ora puoi visualizzare il prodotto ottenuto nell'inventario." : "La conversione del prodotto $productName non è andata a buon fine. $errorDetail";

      //La add è sclusiva del MilkBatch
      case AlertDialogType.Add:
        return (isSuccess) ? "Una Partita di Latte è stata aggiunta al tuo inventario con successo." : "Errore durante l'aggiunta della Partita di Latte nel tuo inventario. $errorDetail";
    }

  }

  static show(BuildContext context, AlertDialogType dialogType, CustomType result, {String? path, String? productName, String? errorDetail}) {

  errorDetail ??= ""; // Se nullo, mette la stringa vuota.

  Icon icon;
  if(result == CustomType.success) {
    icon = const Icon(
      Icons.done,
      color: Colors.green,
      size: 32.0,
    );
  } else {
    icon = const Icon(
      Icons.error,
      color: Colors.red,
      size: 32.0,
    );
  }

  showDialog(context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(getPopupTitle(dialogType, result)),
        content: Text(getPopupBody(dialogType, result, productName: productName, errorDetail: errorDetail)),
        actions: [
          Container(
            padding: EdgeInsets.only(bottom: 16.0),
            child: CustomButton(
              text: "Ok",
              type: result,
              onPressed: () {
                Navigator.of(context).pop(); // Chiudi l'AlertDialog
                if (path != null) {
                  context.go(path);
                }
              },
            ),
          )
        ],

        backgroundColor: Colors.green[50], // Colore verde
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        contentTextStyle: const TextStyle(
          color: Colors.black,
          fontSize: 16.0,
        ),
        titleTextStyle: const TextStyle(
          color: Colors.black,
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
        ),
        actionsPadding: const EdgeInsets.symmetric(horizontal: 16.0),
        elevation: 4.0,
        icon: icon,
      );
    },
  ).then((value) {
    // Questo blocco di codice verrà eseguito dopo la chiusura dell'AlertDialog
    if (path != null) {
      context.go(path);
    }
  });
}

}