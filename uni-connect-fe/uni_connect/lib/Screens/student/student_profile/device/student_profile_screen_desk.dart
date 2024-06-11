import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:uni_connect/Screens/student/student_profile/components/student_profile_bio.dart';
import 'package:uni_connect/Screens/student/student_profile/components/student_profile_images.dart';
import 'package:uni_connect/Screens/student/student_profile/components/student_profile_info.dart';
import 'package:uni_connect/Screens/student/student_profile/components/student_profile_recent_post.dart';
import 'package:uni_connect/models/payload/post_dto.dart';
import 'package:uni_connect/shared/services/post_service.dart';

import '../../../../models/student.dart';
import '../../../../shared/custom_loading_bar.dart';
import '../../../../shared/services/image_services.dart';
import '../../../../shared/services/storage_service.dart';
import '../../../home/components/nav_bar.dart';

class DesktopStudentProfilePage extends StatefulWidget {
  @override
  _DesktopStudentProfilePageState createState() => _DesktopStudentProfilePageState();
}

class _DesktopStudentProfilePageState extends State<DesktopStudentProfilePage> {
  // Aggiungi qui eventuali variabili di stato necessarie
  // Aggiungi qui eventuali variabili di stato necessarie

  bool isLoading = true; // Variabile per tracciare lo stato del caricamento

  late Student? student_logged;
  late List<PostResponse?>? listPostResponse;

  PostService postService = PostService();

  late SecureStorageService secureStorageService;

  final ImageUploadService _imageUploadService = ImageUploadService();




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

  Future<void> _fetchData() async {
      var retrieveUser = await secureStorageService.get();
      if (retrieveUser != null) {
        print("OK!");
        print(retrieveUser.toString());
        setState(() {
          student_logged = retrieveUser;
          print("Student : Bio :"+student_logged!.biography.toString());
        });
      }
      var listPost = await postService.getPosts(student_logged!.id);
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

  }


  @override
  void dispose() {
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {

    if(isLoading){
      return const CustomLoadingIndicator(progress: 4.5);
    }
    return Scaffold(
      appBar: CustomAppBarLogged(student_logged:student_logged,enableSearch: true,IDStudent: student_logged!.id,),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            /// Cover -Image Profile
            CoverImageWidget(
                userEmail: student_logged!.email,
                imageUploadService: _imageUploadService),
            /// Information and BioGraphy- Profile
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: StudentProfileInfo(student: student_logged),
                ),
                const SizedBox(width: 20.0), // Spazio tra le due sezioni
                Expanded(

                  child: BiographyWidget(
                    IDStudent: student_logged!.id,
                    student_logged: student_logged,
                    currentBio: student_logged!.biography,
                  ),
                ),
              ],
            ),
            const Divider(),
            StudentProfileRecentPost(
                listPostResponse: listPostResponse,
                studentLogged: student_logged,
                postService: postService
            ),
            const Divider(),
            //StudentProfileRecentPhoto(imagePaths: studentImagePaths)
            ],
        ),
      ),
    );
  }




}
