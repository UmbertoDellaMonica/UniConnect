import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:uni_connect/Screens/student/student_profile/components/student_profile_bio.dart';
import 'package:uni_connect/Screens/student/student_profile/components/student_profile_images.dart';
import 'package:uni_connect/Screens/student/student_profile/components/student_profile_info.dart';
import 'package:uni_connect/Screens/student/student_profile/components/student_profile_recent_post.dart';
import 'package:uni_connect/models/payload/post_dto.dart';
import 'package:uni_connect/shared/custom_alert_dialog.dart';
import 'package:uni_connect/shared/services/post_service.dart';
import 'package:uni_connect/shared/utils/constants.dart';

import '../../../../../models/student.dart';
import '../../../../../shared/custom_loading_bar.dart';
import '../../../../../shared/services/image_services.dart';
import '../../../../../shared/services/storage_service.dart';
import '../../../../../shared/services/student_service.dart';
import '../../../../home/components/nav_bar.dart';

class DesktopOtherStudentProfilePage extends StatefulWidget {

  final String OtherIDStudent;


  const DesktopOtherStudentProfilePage({
    super.key,
    required this.OtherIDStudent,
  });





  @override
  _DesktopOtherStudentProfilePageState createState() => _DesktopOtherStudentProfilePageState();
}

class _DesktopOtherStudentProfilePageState extends State<DesktopOtherStudentProfilePage> {


  /// Tag - Loading Information
  bool isLoading = true;
  /// Tag - Check if the User already Follow the person
  bool isFollowing = false;


  late Student? student_logged;
  late Student? other_student;

  late List<PostResponse?>? listPostResponse;

  PostService postService = PostService();

  late SecureStorageService secureStorageService;

  final ImageUploadService _imageUploadService = ImageUploadService();

  StudentService studentService = StudentService();



  @override
  void initState() {
    super.initState();
    listPostResponse = null;
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
    print("ID Student Logged : "+other_student!.id);
    bool following = await studentService.checkFollow(student_logged!.id, other_student!.id);

    setState(() {
      isFollowing = following;
      isLoading = false;
    });
  }

  Future<void> toggleFollowStatus() async {

    try {
      if (isFollowing) {
        await studentService.unfollowStudent(student_logged!.id, other_student!.id);
      } else {
        await studentService.followStudent(student_logged!.id, other_student!.id);
      }
      setState(() {
        isFollowing = !isFollowing;
        if(isFollowing == true){
          CustomPopUpDialog.show(context, AlertDialogType.Follow,CustomType.success);
        }else{
          CustomPopUpDialog.show(context, AlertDialogType.UnFollow,CustomType.success);
        }
      });
    } catch (error) {
      print("Errore: $error");
      if(isFollowing==true){
        CustomPopUpDialog.show(context, AlertDialogType.Follow,CustomType.error);
      }else{
        CustomPopUpDialog.show(context, AlertDialogType.UnFollow,CustomType.error);
      }
    }
  }

  Future<void> _fetchData() async {

    /// Retrieve Data from Server of Other Student
    other_student = await studentService.getStudentByID(widget.OtherIDStudent);
    /// Retrieve Data from Secure Storage Flutter
    var retrieveUser = await secureStorageService.get();
    if (retrieveUser != null) {
      setState(() {
        student_logged = retrieveUser;
      });
    }
    var listPost = await postService.getPosts(other_student!.id);
    if(listPost != null){
      setState(() {
        listPostResponse = listPost;
        isLoading=false;
      });
    }else{
      setState(() {
        isLoading=false;
        listPostResponse = null;
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
      return const CustomLoadingIndicator(progress: 4.5);
    }
    return Scaffold(
      appBar: CustomAppBarLogged(student_logged:student_logged,enableSearch: true,IDStudent: student_logged!.id,),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CoverImageWidget(
                userEmail: other_student!.email,
                imageUploadService: _imageUploadService,
            enableEditing: false
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: StudentProfileInfo(student: other_student,enableEditing: false,),
                  ),
                  const SizedBox(width: 20.0),
                  /// Logic Button - Follow - Unfollow
                  ElevatedButton(
                    onPressed: toggleFollowStatus,
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.resolveWith<Color>(
                            (Set<MaterialState> states) {
                          if (states.contains(MaterialState.disabled)) {
                            return Colors.grey; // Colore quando il pulsante è disabilitato
                          }
                          return isFollowing ? Colors.red : Colors.blue; // Cambia colore a seconda se l'utente sta seguendo o meno
                        },
                      ),
                      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                        const EdgeInsets.all(24.0), // Imposta il padding del pulsante
                      ),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0), // Imposta il bordo arrotondato
                        ),
                      ),
                    ),
                    child: Text(
                      isFollowing ? 'Smetti di seguire' : 'Segui',
                      style: const TextStyle(
                        fontSize: 18.0, // Imposta la dimensione del testo
                        fontWeight: FontWeight.bold, // Imposta il grassetto
                        color: Colors.white, // Colore del testo
                      ),
                    ),
                  ),

                ],
              ),
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: BiographyWidget(IDStudent: student_logged!.id, currentBio: other_student!.biography, enableEditing: false,),
            ),
            const Divider(),
            StudentProfileRecentPost(
                listPostResponse: listPostResponse,
                studentLogged: other_student,
                postService: postService,
              enableEditing: false,
            ),
            const Divider(),
          ],
        ),
      ),
    );
  }




}
