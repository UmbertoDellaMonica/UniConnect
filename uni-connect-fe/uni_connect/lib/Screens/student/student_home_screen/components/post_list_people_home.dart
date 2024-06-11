import 'dart:async';
import 'package:flutter/material.dart';
import 'package:uni_connect/shared/design/post/post_item.dart';
import 'package:uni_connect/shared/services/post_service.dart';
import '../../../../models/payload/post_dto.dart';
import '../../../../shared/design/post/post_form.dart';

class PostListPeopleHome extends StatefulWidget {
  final String IDStudent;

  const PostListPeopleHome({required this.IDStudent});

  @override
  _PostListPeopleHomeState createState() => _PostListPeopleHomeState();
}

class _PostListPeopleHomeState extends State<PostListPeopleHome> {

  List<PostResponse> posts = [];
  bool isLoading = true;
  Timer? _timer; // Add a Timer variable
  PostService postService = PostService();

  @override
  void initState() {
    super.initState();
    _fetchRecentPosts();
    // Create a periodic timer that fetches recent posts every 5 minutes
    _timer = Timer.periodic(const Duration(seconds: 30), (timer) {
      setState(() {
        isLoading = true;
      });
      _fetchRecentPosts();
    });
  }

  Future<void> _fetchRecentPosts() async {
    var fetch_post = await postService.fetchRecentPosts(widget.IDStudent);
    if (fetch_post.isNotEmpty) {
      setState(() {
        posts = fetch_post;
        isLoading = false;
      });
    } else {
      // Handle error or no content
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _timer?.cancel(); // Cancel the timer when the widget is disposed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          PostForm(IDStudent: widget.IDStudent),
          const SizedBox(height: 20),
          isLoading
              ? const Center(child: CircularProgressIndicator())
              : posts.isEmpty
              ? const Center(child: Text('No recent posts found'))
              : ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: posts.length, // Number of recent posts
            itemBuilder: (context, index) {
              return PostItem(post: posts[index],);
            },
          ),
        ],
      ),
    );
  }
}
