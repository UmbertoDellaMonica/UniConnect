import 'package:flutter/material.dart';
import 'package:uni_connect/shared/custom_alert_dialog.dart';
import 'package:uni_connect/shared/services/post_service.dart';
import 'package:uni_connect/shared/utils/constants.dart';

class PostForm extends StatefulWidget {
  final String IDStudent;
  const PostForm({super.key, required this.IDStudent});

  @override
  _PostFormState createState() => _PostFormState();
}

class _PostFormState extends State<PostForm> {

  final TextEditingController _contentController = TextEditingController();

  final PostService postService = PostService();



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
                controller: _contentController,
                decoration: const InputDecoration(
                  hintText: 'A cosa stai pensando?',
                  border: InputBorder.none,
                ),
                maxLines: null,
              ),
              const Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    icon: const Icon(Icons.photo, color: Colors.green),
                    onPressed: () {
                      // Aggiungi foto
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.video_call, color: Colors.red),
                    onPressed: () {
                      // Aggiungi video
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.insert_emoticon, color: Colors.yellow),
                    onPressed: () {
                      // Aggiungi emoji
                    },
                  ),
                ],
              ),
              const SizedBox(height: 16),
              /// Todo : Build Button Publish
              _buildPublishButton()
            ],
          ),
        ),
      ),
    );
  }

  /// ----------------- Widget -------------------///

  Widget _buildPublishButton(){
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.lightBlue,
          elevation: 5,
          foregroundColor: Colors.blueAccent,
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          textStyle: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        onPressed: () =>  publishPost(context),
        child: const Text(
          'Pubblica',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }


  /// Action - Perform Creating Post ///
  Future<void> publishPost(context) async {
    // Azione per pubblicare il post
    if (await postService.createPost(widget.IDStudent, _contentController.text) != null) {
      CustomPopUpDialog.show(context, AlertDialogType.PostCreate, CustomType.success);
      //Pulisci il campo di testo dopo la pubblicazione del post
      _contentController.clear();
    }else{
      CustomPopUpDialog.show(context, AlertDialogType.PostCreate, CustomType.error);
    }
  }

}
