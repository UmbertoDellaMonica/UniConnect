import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:uni_connect/shared/utils/constants.dart';

import 'custom_button.dart';

class CustomPopUpDialog  {

  static String getPopupTitle(AlertDialogType dialogType, CustomType result) {

    bool isSuccess = result == CustomType.success; //Se il result è un successo restituisce true, altrimenti false

    switch(dialogType) {
      case AlertDialogType.Signup:
        return (isSuccess) ? "Registrazione avvenuta con successo." : "Errore durante la registrazione.";

      case AlertDialogType.Signin:
        return (isSuccess) ? "Autenticazione avvenuta con successo." : "Errore durante l'autenticazione.";

      case AlertDialogType.Logout:
        return (isSuccess) ? "Logout riuscito" :" Errore Logout";

      case AlertDialogType.PostCreate:
        return (isSuccess) ? "Post pubblicato" :" Errore creazione del Post! ";

      case AlertDialogType.PostDelete:
        return (isSuccess) ? "Post Cancellato" :" Errore cancellazione del Post! ";

      case AlertDialogType.PostUpdate:
        return (isSuccess) ? "Post Aggiornato" :" Errore aggiornamento del Post! ";

      case AlertDialogType.Follow:
        return (isSuccess) ? "Following !" :" Errore follow! ";

      case AlertDialogType.UnFollow:
        return (isSuccess) ? "Unfollow!" :" Errore Unfollow! ";


    }

  }

  static String getPopupBody(AlertDialogType dialogType, CustomType result, {String? productName, String? errorDetail}){

    bool isSuccess = result == CustomType.success; //Se il result è un successo restituisce true, altrimenti false

    switch(dialogType) {
      case AlertDialogType.Signup:
        return (isSuccess)
            ? "Grazie per esserti registrato, ora puoi accedere alla nostra app."
            : "La registrazione non è andata a buon fine, ti invitiamo a riprovare. $errorDetail";

      case AlertDialogType.Signin:
        return (isSuccess)
            ? "Premi Ok per accedere essere indirizzato all'area utente."
            : "L'autenticazione non è andata a buon fine, ti invitiamo a riprovare. $errorDetail";

      case AlertDialogType.Logout:
        return(isSuccess)
            ? "Premere OK per andare alla pagina iniziale!" : "Logout non andato a buon fine!";

      case AlertDialogType.PostCreate:
        return(isSuccess)
            ? "Premere OK per ritornare a pubblicare post!" : "Pubblicazione Post non riuscita !";

      case AlertDialogType.PostDelete:
        return(isSuccess)
            ? "Premere OK per ritornare a visualizzare il profilo!" : "Eliminazione Post Non riuscita !";


      case AlertDialogType.PostUpdate:
        return(isSuccess)
            ? "Premere OK per ritornare a visualizzare il profilo!" : "Aggiornamento Post Non riuscita !";
      case AlertDialogType.Follow:
        return(isSuccess)
            ? "Premere OK per ritornare a visualizzare il profilo!" : "Follow dell'utente riuscito !";
      case AlertDialogType.UnFollow:
        return(isSuccess)
            ? "Premere OK per ritornare a visualizzare il profilo!" : "Unfollow Non riuscita!";

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