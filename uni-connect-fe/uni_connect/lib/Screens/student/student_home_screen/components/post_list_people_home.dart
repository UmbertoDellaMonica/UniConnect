
import 'package:flutter/cupertino.dart';
import 'package:uni_connect/shared/design/post/post_item.dart';

import '../../../../shared/design/post/post_form.dart';

class PostListPeopleHome extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          PostForm(),
          SizedBox(height: 20),
          // Visualizzazione dei post degli altri utenti
          ListView.builder(
            shrinkWrap: true,
            physics: AlwaysScrollableScrollPhysics(),
            itemCount: 30, // Numero di post degli altri utenti
            itemBuilder: (context, index) {
              return PostItem(index: index);
            },
          ),
        ],
      ),
    );
  }

}