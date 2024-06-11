import 'package:flutter/cupertino.dart';
import 'package:uni_connect/shared/design/post/post_item.dart';
import '../../../../shared/design/post/post_form.dart';

class PostListPeopleHome extends StatefulWidget {
  final String IDStudent;

  const PostListPeopleHome({required this.IDStudent});

  @override
  _PostListPeopleHomeState createState() => _PostListPeopleHomeState();
}

class _PostListPeopleHomeState extends State<PostListPeopleHome> {
  // Lista dei post (puoi modificarla per adattarla ai tuoi dati reali)
  List<String> posts = List.generate(30, (index) => 'Post $index');

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          PostForm(IDStudent: widget.IDStudent),
          SizedBox(height: 20),
          // Visualizzazione dei post degli altri utenti
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: posts.length, // Numero di post degli altri utenti
            itemBuilder: (context, index) {
              return PostItem(index: index);
            },
          ),
        ],
      ),
    );
  }
}
