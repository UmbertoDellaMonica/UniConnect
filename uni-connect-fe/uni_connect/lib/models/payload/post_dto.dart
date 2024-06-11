
class PostRequest {
  final String content;
  final String created_at;
  final int likes;
  final String studentId;

  PostRequest({
    required this.content,
    required this.created_at,
    required this.likes,
    required this.studentId,
  });

  Map<String, dynamic> toJson() {
    return {
      'content': content,
      'created_at': created_at,
      'likes': likes,
      'studentId': studentId,
    };
  }
}

class PostResponse {
  final String ID;
  final String content;
  final String created_at;
  final int likes;

  PostResponse({
    required this.ID,
    required this.content,
    required this.created_at,
    required this.likes,
  });

  factory PostResponse.fromJson(Map<String, dynamic> json) {
    return PostResponse(
      ID: json['ID'],
      content: json['content'],
      created_at: json['created_at'],
      likes: json['likes'],
    );
  }
}