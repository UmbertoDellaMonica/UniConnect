

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PostForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'A cosa stai pensando?',
                  border: InputBorder.none,
                ),
                maxLines: null,
              ),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    icon: Icon(Icons.photo, color: Colors.green),
                    onPressed: () {
                      // Aggiungi foto
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.video_call, color: Colors.red),
                    onPressed: () {
                      // Aggiungi video
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.insert_emoticon, color: Colors.yellow),
                    onPressed: () {
                      // Aggiungi emoji
                    },
                  ),
                ],
              ),
              SizedBox(height: 16),
              SizedBox(
                width: double.infinity, // Imposta la larghezza del pulsante a 100%
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.lightBlue,
                    elevation: 5,
                    foregroundColor: Colors.blueAccent,
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    textStyle: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: () {
                    // Azione per pubblicare il post
                  },
                  child: const Text(
                    'Pubblica',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}