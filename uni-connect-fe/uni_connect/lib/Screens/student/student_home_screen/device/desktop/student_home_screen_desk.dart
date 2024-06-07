import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:uni_connect/Screens/student/student_home_screen/components/post_list_people_home.dart';
import 'package:uni_connect/shared/services/storage_service.dart';

import '../../../../../models/student.dart';
import '../../../../../shared/custom_loading_bar.dart';
import '../../../../home/components/nav_bar.dart';
import '../../components/connected_home_people.dart';
import '../../components/user_profile_home.dart';


class DesktopStudentHomePage extends StatefulWidget {

  @override
  _DesktopStudentHomePageState createState() => _DesktopStudentHomePageState();
}

class _DesktopStudentHomePageState extends State<DesktopStudentHomePage> {


  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  late String _selectedItem; // Variabile per memorizzare l'elemento selezionato nel dropdown

  final _formKey = GlobalKey<FormState>();
  bool _isObscure = true;

  bool isLoading = true; // Variabile per tracciare lo stato del caricamento

  late Student? student_logged;

  late SecureStorageService secureStorageService;


  @override
  void initState() {
    super.initState();
    // Secure Storage Service - retrieve
    final storage = GetIt.I.get<SecureStorageService>();
    secureStorageService = storage;
    // Simula un caricamento asincrono dei dati per 2 secondi
    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        isLoading = false; // Imposta isLoading su false quando il caricamento è completo
        this._selectedItem= "Dipartimento di Informatica";
      });
    });

    // Esegui la navigazione solo dopo che la pagina è stata completamente costruita
    WidgetsBinding.instance?.addPostFrameCallback((_) async {
      var retrieveUser = await secureStorageService.get();
      student_logged = retrieveUser;
      if (student_logged != null) {
        print("OK!");
      }else{
        print("Error");
      }
    });
  }


  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if(isLoading){
      return CustomLoadingIndicator(progress: 4.5);
    }
    var size = MediaQuery.of(context).size;
    var theme = Theme.of(context);
    return GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child:
        Scaffold(
          appBar: CustomAppBarLogged(student_logged),
          backgroundColor: Colors.white,
          resizeToAvoidBottomInset: false,
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: LayoutBuilder(
              builder: (context, constraints) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Colonna sinistra: Profilo utente
                    Expanded(
                      flex: 2,
                      child: UserProfileHome(IDStudent: this.student_logged!.id,),
                    ),
                    const SizedBox(width: 20),
                    // Colonna centrale: Post e form del post
                    Expanded(
                      flex: 4,
                      child: PostListPeopleHome(),
                    ),
                    // Colonna destra: Persone connesse
                    const SizedBox(width: 20),
                    Expanded(
                      flex: 1,
                      child: ConnectedPeopleHome(),
                    ),
                  ],
                );
              },
            ),
          ),
        ));
  }
}