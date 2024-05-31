import 'package:flutter/material.dart';
import 'package:uni_connect_front_end/shared/components/atoms/custom_input_validator.dart';
import 'package:uni_connect_front_end/shared/components/atoms/custom_button.dart';
import 'package:uni_connect_front_end/shared/color_utils.dart';
import 'package:uni_connect_front_end/shared/enums.dart';
import 'package:uni_connect_front_end/shared/components/molecules/custom_nav_bar.dart';
import 'package:uni_connect_front_end/shared/custom_alert_dialog.dart';
import 'package:uni_connect_front_end/shared/components/atoms/custom_dropdown.dart';
import 'package:uni_connect_front_end/sign_in/components/custom_menu_singin.dart';
import 'package:uni_connect_front_end/sign_in/service/sign_in_service.dart';
import 'package:uni_connect_front_end/shared/services/secure_storage_service.dart';
import 'package:uni_connect_front_end/student/student.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';




class UniConnectSignInPage extends StatefulWidget {
  const UniConnectSignInPage({super.key, required this.title});

  final String title;

  @override
  State<UniConnectSignInPage> createState() => _MySignInPageAnimations();
}

class _MySignInPageAnimations extends State<UniConnectSignInPage> with SingleTickerProviderStateMixin{


  /// DropDown Items - Departement Student 
  var dropdownItems = Enums.dropdownItems;  


  late AnimationController _drawerSlideController;

  /// Select value to Menu 
  late String selectStudentDepartement;

  /// Controller of Text 
  TextEditingController ? _emailController;
  TextEditingController ?_passwordController;

  /// Dynamic Value to Retrieve 
  late String emailInput;
  late String passwordInput;
  

  final signinService = SigninService();

  late SecureStorageService secureStorageService;


   @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    selectStudentDepartement = "Dipartimento di Informatica";
    
    super.initState();

    
    _drawerSlideController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
    );
    final storage = GetIt.I.get<SecureStorageService>();
    secureStorageService = storage;
  }

   @override
  void dispose() {
    // Clean up the controllers when the Widget is disposed
    _emailController?.dispose(); 
     _passwordController?.dispose();
    _drawerSlideController.dispose();
    super.dispose();
  }


    bool _isDrawerOpen() {
      return _drawerSlideController.value == 1.0;
    }

    bool _isDrawerOpening() {
      return _drawerSlideController.status == AnimationStatus.forward;
    }

    bool _isDrawerClosed() {
      return _drawerSlideController.value == 0.0;
    }

    void _toggleDrawer() {
      if (_isDrawerOpen() || _isDrawerOpening()) {
        _drawerSlideController.reverse();
      } else {
        _drawerSlideController.forward();
      }
    }

    /**
     * Construisce la NavBar Custom
     * - Inserimento del Logo 
     * - Inserimento del Testo 
     * - Inserimento del Menù 
     */
    PreferredSizeWidget _buildAppBar() {
      return CustomAppBar(
        leading: Image.asset('../assets/filiera-token-logo.png',width: 1000, height: 1000, fit: BoxFit.fill),
        centerTitle: true,
        title: 'UniConnect-Login',
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        automaticallyImplyLeading: false,
        actions: [
          AnimatedBuilder(
            animation: _drawerSlideController,
            builder: (context, child) {
              return IconButton(
                onPressed: _toggleDrawer,
                icon: _isDrawerOpen() || _isDrawerOpening()
                    ? const Icon(
                        Icons.clear,
                        color: Colors.blue,
                      )
                    : const Icon(
                        Icons.menu,
                        color: Colors.blue,
                      ),
              );
            },
          ),
        ],
      );
    }


    Widget _buildDrawer() {
      return AnimatedBuilder(
        animation: _drawerSlideController,
        builder: (context, child) {
          return FractionalTranslation(
            translation: Offset(1.0 - _drawerSlideController.value, 0.0),
            child: _isDrawerClosed() ? const SizedBox() : const CustomMenuSignin(),
          );
        },
      );
    }


      /**
     * Build Layout 
     */
    @override
    Widget build(BuildContext context) {
      return Scaffold(
        // Nav Bar 
        appBar: _buildAppBar(),
        body: Stack(
            children: <Widget>[
              // Form di iscrizione
              _buildFormLogin(context),
              _buildDrawer()
            ],
          ),
      );
    }



  
    /**
     * Build Login Form 
     */
    Widget _buildFormLogin(BuildContext context) {
    return Center(
      child: Expanded(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.4,
          padding: const EdgeInsets.all(40.0),
          decoration: BoxDecoration(
            border: Border.all(
              color: ColorUtils.getColor(CustomType.neutral),
            ),
            borderRadius: BorderRadius.circular(30.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, // Allineato a sinistra
            children: <Widget>[
              Text(
                'Login', // Titolo "Login"
                style: TextStyle(
                  fontSize: 24.0, // Dimensione del testo
                  fontWeight: FontWeight.bold, // Grassetto
                  color: ColorUtils.getColor(CustomType.neutral), // Colore neutral
                ),
              ),
              const SizedBox(height: 20),
              /// Email Controller 
              CustomInputValidator(
                inputType: TextInputType.emailAddress,
                labelText: 'Email',
                controller: _emailController!,
              ),
              const SizedBox(height: 20),
              /// Password Controller 
              CustomInputValidator(
                inputType: TextInputType.visiblePassword,
                labelText: 'Password',
                controller: _passwordController!,
              ),
              const SizedBox(height: 20),
              /// DropDown - Section
              _buildDropDownSection(context),
              const SizedBox(height: 20),
              /// Login Button - Action
              _buildLoginButton(context), 
              const SizedBox(height: 20),
              Center(
                child: Text(
                  'Non sei ancora registrato ?',
                  style: TextStyle(
                    color: ColorUtils.labelColor,
                  ),
                ),
              ),
              CustomButton(
                  expandWidth: true,
                  text: "Registrati",
                  type: CustomType.neutral,
                  onPressed: () => context.go('/signup')),
            ],
          ),
        ),
      ),
    );
  }

   /// Build Back Button
   Widget _buildRegisterButton(BuildContext context) {
    return  Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text('Non sei registrato ?'),
                SizedBox(width: 20,height: 0),
                
                ElevatedButton(
                  child: const Text('Registrati'),

                  onPressed: () => context.go('/signup'),
                
                ),
              ],
            );
  }


  Widget _buildDropDownSection(BuildContext context){
    return CustomDropdown<String>(
                items: dropdownItems,
                value: "Dipartimento di Informatica",
                onChanged: (value) {
                  setState(() {
                    selectStudentDepartement = value!;
                  });
                },
              );
  }

  /// Login Button - Section 
  Widget _buildLoginButton(BuildContext context){
    return 
    CustomButton(
                expandWidth: true,
                text: "Login",
                type: CustomType.neutral,
                onPressed: () async => await  _SignInButtonPressed()
    );
  }



  /// Login Button - Action 
  Future<void> _SignInButtonPressed() async {
    emailInput = _emailController!.text;
    passwordInput = _passwordController!.text;
    /// SignIn Student - Action 
    bool loginStatus = await signinService.signInStudent(emailInput, passwordInput, selectStudentDepartement);
    if(loginStatus){ 
      print("Sono qui, sto per prendere i dati!");
      /// Show Success Login 
      Student? userLogged = await signinService.onLoginSuccess(emailInput);

      /// TODO : SecureStorageService 
      /// SecureStorageService.save() salva i miei dati nel SecureStorage di Flutter  
      await secureStorageService.save(userLogged!);

      /// Mostra un alert di Successo in riferimento alla Login()
      /// Mi ridireziona alla pagina di Home-Page-User
      CustomPopUpDialog.show(context, AlertDialogType.Signin, CustomType.success, path: '/home-page/'+userLogged.id);
    }  else{

      /// Error Login 
      /// Show Error Login 
      CustomPopUpDialog.show(context, AlertDialogType.Signin, CustomType.error);
    }
      
      

  }

 






}