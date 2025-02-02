import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../models/payload/post_dto.dart';
import '../../../../models/student.dart';
import '../../../../shared/custom_alert_dialog.dart';
import '../../../../shared/design/post/post_item_profile.dart';
import '../../../../shared/services/post_service.dart';
import '../../../../shared/utils/constants.dart';

class StudentProfileRecentPost extends StatefulWidget {

  final List<PostResponse?>? listPostResponse;
  final Student? studentLogged;
  final PostService postService;
  /// TRUE -  enable active editing
  /// FALSE - Mot Enable Active editing
  final bool enableEditing;

  const StudentProfileRecentPost({
    Key? key,
    required this.listPostResponse,
    required this.studentLogged,
    required this.postService,
    required this.enableEditing,
  }) : super(key: key);

  @override
  _RecentPostWidgetState createState() => _RecentPostWidgetState();
}

class _RecentPostWidgetState extends State<StudentProfileRecentPost> {
  @override
  Widget build(BuildContext context) {
    int numberPosts = widget.listPostResponse != null ? widget.listPostResponse!
        .length : 0;

    return Container(
      margin: const EdgeInsets.all(30),
      padding: const EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Post Recenti:',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10.0),
            GridView.builder(
              padding: const EdgeInsets.all(20),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 10,
                mainAxisSpacing: 15,
                childAspectRatio: 2.0,
                mainAxisExtent: 200,
              ),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: numberPosts,
              itemBuilder: (BuildContext context, int index) {
                return PostItemProfile(
                  index: index,
                  student_logged: widget.studentLogged,
                  postResponse: widget.listPostResponse![index],

                  onDelete: () async {
                    if (widget.enableEditing) {
                      String IDPost = widget.listPostResponse![index]!.ID;
                      String IDStudent = widget.studentLogged!.id;
                      if (await widget.postService.deletePost(
                          IDPost, IDStudent)) {
                        setState(() {
                          widget.listPostResponse!.removeAt(index);
                        });
                        CustomPopUpDialog.show(
                            context, AlertDialogType.PostDelete,
                            CustomType.success);
                      } else {
                        CustomPopUpDialog.show(
                            context, AlertDialogType.PostDelete,
                            CustomType.error);
                      }
                    }
                  },
                  onEdit: () async {
                    if (widget.enableEditing) {
                      String IDPost = widget.listPostResponse![index]!.ID;
                      String IDStudent = widget.studentLogged!.id;
                      String newContent = await _showEditDialog(
                          context, widget.listPostResponse![index]!.content);

                      /// Equals or Not
                      if (newContent.compareTo(
                          widget.listPostResponse![index]!.content) != 0) {
                        PostResponse? response = await widget.postService
                            .editPost(IDPost, IDStudent, newContent);
                        if (response != null) {
                          setState(() {
                            widget.listPostResponse![index] = response;
                          });
                          CustomPopUpDialog.show(
                              context, AlertDialogType.PostUpdate,
                              CustomType.success);
                        } else {
                          CustomPopUpDialog.show(
                              context, AlertDialogType.PostUpdate,
                              CustomType.error);
                        }
                      } else {
                        return;
                      }
                    }
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<String> _showEditDialog(BuildContext context, String currentContent) async {
    TextEditingController _controller = TextEditingController(text: currentContent);
    String newContent = currentContent;

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          title: const Text(
            'Modifica Post',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextField(
              controller: _controller,
              maxLines: null,
              decoration: const InputDecoration(
                hintText: "Modifica il contenuto del post",
                border: InputBorder.none,
              ),
            ),
          ),
          actions: [
            TextButton.icon(
              icon: const Icon(Icons.cancel, color: Colors.red),
              label: const Text(
                'Annulla',
                style: TextStyle(color: Colors.red),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton.icon(
              icon: const Icon(Icons.save, color: Colors.green),
              label: const Text(
                'Salva',
                style: TextStyle(color: Colors.green),
              ),
              onPressed: () {
                newContent = _controller.text;
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );

    return newContent;
  }

}
