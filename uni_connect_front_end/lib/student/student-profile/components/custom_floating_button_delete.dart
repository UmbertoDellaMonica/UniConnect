import 'package:flutter/material.dart';


class CustomDeleteUserButton extends StatelessWidget {

  const CustomDeleteUserButton({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Positioned(
        bottom: 16.0,
        right: 16.0,
        child: _buildDeleteAccountButton(context) );
  }

  FloatingActionButton _buildDeleteAccountButton(BuildContext context){
    return FloatingActionButton(
      backgroundColor: Colors.red,
      
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),

      child: const Icon(Icons.delete),
      /// Action to Delete User 
      onPressed: () {  
        _showActionDelete(context);
      },
      
    );
  }

  void _showActionDelete(context){
    // Mostra un dialogo di conferma per l'eliminazione dell'account
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text("Elimina account"),
            content: const Text("Sei sicuro di voler eliminare il tuo account?"),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Annulla"),
              ),
              TextButton(
                onPressed: () {
                  // Elimina l'account
                  // ...
                  Navigator.pop(context);
                },
                child: const Text("Elimina"),
              ),
            ],
          ),
        );
  }



}
