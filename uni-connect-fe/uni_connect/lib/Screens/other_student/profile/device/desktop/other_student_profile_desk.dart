import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:uni_connect/Screens/other_student/profile/components/cover_image_without_add.dart';
import 'package:uni_connect/Screens/other_student/profile/components/profile_info_without_editing.dart';
import 'package:uni_connect/Screens/student/student_profile/components/student_profile_recent_post.dart';
import 'package:uni_connect/models/payload/post_dto.dart';
import 'package:uni_connect/shared/services/post_service.dart';

import '../../../../../models/student.dart';
import '../../../../../shared/custom_loading_bar.dart';
import '../../../../../shared/services/image_services.dart';
import '../../../../../shared/services/storage_service.dart';
import '../../../../../shared/services/student_service.dart';
import '../../../../home/components/nav_bar.dart';
import '../../components/biography_without_edit.dart';

class DesktopOtherStudentProfilePage extends StatefulWidget {

  final Student? other_student;
  DesktopOtherStudentProfilePage({required this.other_student});





  @override
  _DesktopOtherStudentProfilePageState createState() => _DesktopOtherStudentProfilePageState();
}

class _DesktopOtherStudentProfilePageState extends State<DesktopOtherStudentProfilePage> {


  /// Tag - Loading Information
  bool isLoading = true;
  /// Tag - Check if the User already Follow the person
  bool isFollowing = false;


  late Student? student_logged = null;

  late List<PostResponse?>? listPostResponse;

  PostService postService = PostService();

  late SecureStorageService secureStorageService;

  final ImageUploadService _imageUploadService = ImageUploadService();

  StudentService studentService = StudentService();



  @override
  void initState() {
    super.initState();
    this.listPostResponse = null;
    // Secure Storage Service - retrieve
    final storage = GetIt.I.get<SecureStorageService>();
    secureStorageService = storage;
    // Esegui la navigazione solo dopo che la pagina è stata completamente costruita
    _fetchData();
  }


  Future<void> _checkFollowingStatus() async {
    setState(() {
      isLoading = true;
    });
    print("ID Student Logged : "+student_logged!.id);
    print("ID Student Logged : "+widget.other_student!.id);
    bool following = await studentService.checkFollow(student_logged!.id, widget.other_student!.id);

    setState(() {
      isFollowing = following;
      isLoading = false;
    });
  }

  Future<void> toggleFollowStatus() async {
    setState(() {
      isLoading = true;
    });

    try {
      if (isFollowing) {
        await studentService.unfollowStudent(student_logged!.id, widget.other_student!.id);
      } else {
        await studentService.followStudent(student_logged!.id, widget.other_student!.id);
      }
      setState(() {
        isFollowing = !isFollowing;
      });
    } catch (error) {
      print("Errore: $error");
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }






  Future<void> _fetchData() async {
    var retrieveUser = await secureStorageService.get();
    if (retrieveUser != null) {
      setState(() {
        student_logged = retrieveUser;
      });
    }
    var listPost = await postService.getPosts(widget.other_student!.id);
    if(listPost != null){
      setState(() {
        this.listPostResponse = listPost;
        isLoading=false;
      });
    }else{
      setState(() {
        isLoading=false;
        this.listPostResponse = null;
      });
    }
    await _checkFollowingStatus();
  }


  @override
  void dispose() {
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return CustomLoadingIndicator(progress: 4.5);
    }
    return Scaffold(
      appBar: CustomAppBarLogged(this.student_logged),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            OtherStudentCoverImageWidget(
                userEmail: widget.other_student!.email,
                imageUploadService: _imageUploadService),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: OtherStudentProfileInfo(student: widget.other_student),
                  ),
                  SizedBox(width: 20.0),
                  ElevatedButton(
                    onPressed: toggleFollowStatus,
                    child: Text(isFollowing ? 'Smetti di seguire' : 'Segui'),
                  ),
                ],
              ),
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: OtherStudentBiographyWidget(),
            ),
            Divider(),
            StudentProfileRecentPost(
                listPostResponse: this.listPostResponse,
                studentLogged: widget.other_student,
                postService: this.postService
            ),
            Divider(),
          ],
        ),
      ),
    );
  }




}
