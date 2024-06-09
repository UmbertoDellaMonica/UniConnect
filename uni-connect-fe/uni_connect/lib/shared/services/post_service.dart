
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:uni_connect/shared/services/api_builder_service.dart';
import '../../models/payload/post_dto.dart';

class PostService {


  ApiBuilderService apiBuilderService = ApiBuilderService();

  static const String _Url = 'http://127.0.0.1:8443';

  static const String _api = 'api';

  static const String _version = 'v1';

  static const String _queryStudentPost = 'student/post';
  
  static const String _queryStudentAllPost = 'student/post/all';

  /// TODO : Get Post - ({post_id}) as Path Variable
  /// TODO : Delete Post - ({post_id}) as Path Variable
  /// TODO : GetList  Post - /all
  
  Future<PostResponse?> createPost(String studentId, String content) async {
    late String Url = apiBuilderService.buildUrl(
        _api, _Url, _version, _queryStudentPost);

    final postRequest = PostRequest(
      content: content,
      created_at: DateTime.now().toIso8601String(),
      likes: 0,
      studentId: studentId,
    );

    final headers = {
      'Content-Type': 'application/json',
      'IDStudent': studentId,
    };

    final response = await http.post(
      Uri.parse(Url),
      headers: headers,
      body: jsonEncode(postRequest.toJson()),
    );

    if (response.statusCode == 201) {
      final obj = jsonDecode(response.body);
      print("Obj : "+obj.toString());
      return PostResponse.fromJson(obj);
    } else {
      print('Failed to create post: ${response.statusCode}');
      return null;
    }
  }

  Future<List<PostResponse?>?> getPosts(String studentId) async {
    late String Url = apiBuilderService.buildUrl(
        _api, _Url, _version, _queryStudentAllPost);
    final response = await http.get(
      Uri.parse(Url),
      headers: {'IDStudent': studentId},
    );

    print("response status code : "+response.statusCode.toString());

    if (response.statusCode == 200) {
      Iterable list = json.decode(response.body);
      return list.map((json) => PostResponse.fromJson(json)).toList();
    } else if(response.statusCode == 204){
      return null;
    }else{
      throw Exception('Failed to load posts');
    }
  }

  Future<bool> deletePost(String IDPost, String IDStudent) async {
    late String Url = apiBuilderService.buildUrl(
        _api, _Url, _version, '$_queryStudentPost/$IDPost');

    // Aggiungi l'header per l'ID dello studente
    Map<String, String> headers = {
      'IDStudent': IDStudent,
    };

    try {
      // Effettua la chiamata HTTP DELETE al backend
      var response = await http.delete(
        Uri.parse(Url),
        headers: headers,
      );

      print("Response: "+response.body);
      print("Response: "+response.statusCode.toString());

      // Controlla lo stato della risposta
      if (response.statusCode == 204) {
        // Se il post è stato eliminato con successo, restituisci true
        return true;
      } else {
        // Se il post non è stato trovato, restituisci false
        return false;
      }
    } catch (e) {
      // Se si verifica un errore durante la chiamata, restituisci false
      return false;
    }
  }

  Future<PostResponse?> editPost(String IDPost, String IDStudent, String newContent) async {
    late String Url = apiBuilderService.buildUrl(
        _api, _Url, _version, '$_queryStudentPost/$IDPost');
    final response = await http.put(
      Uri.parse(Url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'IDStudent': IDStudent,
      },
      body: jsonEncode(<String, String>{
        'content': newContent,
      }),
    );

    if (response.statusCode == 200) {
      final obj = jsonDecode(response.body);
      print("Obj : "+obj.toString());
      return PostResponse.fromJson(obj);
    } else {
      return null;
    }
  }


}