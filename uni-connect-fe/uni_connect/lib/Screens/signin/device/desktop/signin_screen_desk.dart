import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:lottie/lottie.dart';
import 'package:uni_connect/Screens/signin/services/signin_service.dart';
import 'package:uni_connect/shared/services/storage_service.dart';

import '../../../../models/student.dart';
import '../../../../shared/custom_alert_dialog.dart';
import '../../../../shared/custom_dropdown_menu.dart';
import '../../../../shared/services/router_service.dart';
import '../../../../shared/utils/constants.dart';
import '../../../../shared/custom_loading_bar.dart';
import '../../../home/components/nav_bar.dart';

class DesktopSigninPage extends StatefulWidget {
  const DesktopSigninPage({super.key});

  @override
  State<DesktopSigninPage> createState() => _DesktopSigninPageState();
}

class _DesktopSigninPageState extends State<DesktopSigninPage> {

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  late String _selectedItem;


  bool _isObscure = true;
  bool isLoading = true; // Variabile per tracciare lo stato del caricamento


  final _formKey = GlobalKey<FormState>();
  /// Signin Service
  final SigninService signinService = SigninService();
  /// Secure Storage Service
  late SecureStorageService secureStorageService;
  final RouterService _routerService = RouterService();


  Student? student_logged ;

  @override
  void initState() {
    super.initState();
    // Secure Storage Service - retrieve
    final storage = GetIt.I.get<SecureStorageService>();
    secureStorageService = storage;
    _fetchData();
  }

  Future<void> _fetchData() async {
    var retrieveUser = await secureStorageService.get();
    if (retrieveUser != null) {
      setState(() {
        student_logged = retrieveUser;
        _selectedItem = "Dipartimento di Informatica";
        isLoading = false;
        _routerService.goStudentHome(context, student_logged!.id);
      });
    }else{
      setState(() {
        _selectedItem = "Dipartimento di Informatica";
        isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    if (isLoading) {
      return const CustomLoadingIndicator(progress: 4.5);
    } else {
      if(student_logged !=null){
        _routerService.goStudentHome(context, student_logged!.id);
      }

      return Scaffold(
        appBar: CustomAppBar(),
        body: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Transform.scale(
                  scale: 0.9,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: Image.asset(
                      '/images/login.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(width: size.width * 0.06),
            Expanded(
              flex: 2,
              child: _buildMainBody(
                size,
              ),
            ),
          ],
        ),
      );
    }
  }



  /// Main Body
  Widget _buildMainBody(Size size) {
    var animation = Lottie.asset('wave.json', height: size.height * 0.2, width: size.width, fit: BoxFit.fill,);
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment:
        size.width > 600 ? MainAxisAlignment.center : MainAxisAlignment.start,
        children: [
          size.width > 600 ? Container() : animation,
          SizedBox(
            height: size.height * 0.03,
          ),
          /// Build Title
          _buildTitle(size),
          const SizedBox(
            height: 10,
          ),
          /// Build Sub-Title
          _buildSubTitle(size),
          SizedBox(
            height: size.height * 0.03,
          ),
          _buildForm(size),
          SizedBox(height: size.height * 0.05),
          _buildHomeButton(context)
        ],
      ),
    );
  }



  /// Build Title
  _buildTitle(Size size) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0),
      child: Text(
        'Login',
        style: Constants.kLoginTitleStyle(size),
      ),
    );
  }
  /// Build Sub-Title
  _buildSubTitle(Size size) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0),
      child: Text(
        'Benvenuto Utente',
        style: Constants.kLoginSubtitleStyle(size),
      ),
    );
  }
  /// Build Form
  Widget _buildForm(Size size) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            /// username or Gmail
            _buildEmailForm(),
            SizedBox(
              height: size.height * 0.02,
            ),
            // Password Form
            _buildPasswordForm(),
            SizedBox(
              height: size.height * 0.01,
            ),
            Text(
              'Creando un\'account accetti i Termini del Servizio e la nostra Policy sulla Privacy',
              style: Constants.kLoginTermsAndPrivacyStyle(size),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: size.height * 0.02,
            ),
            _buildDropDownMenu(context),
            SizedBox(
              height: size.height * 0.02,
            ),
            /// Login Button
            _loginButton(),
            SizedBox(
              height: size.height * 0.03,
            ),

            /// Navigate To Login Screen
            GestureDetector(
              onTap: () {
                _routerService.goSignup(context);
                emailController.clear();
                passwordController.clear();
                _formKey.currentState?.reset();
                _isObscure = false;
              },
              child: RichText(
                text: TextSpan(
                  text: 'Non hai un account ?',
                  style: Constants.kHaveAnAccountStyle(size),
                  children: [
                    TextSpan(
                        text: " Registrati ",
                        style: Constants.kLoginOrSignUpTextStyle(
                          size,
                        )
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }


  /// Email Field - Section
  TextFormField _buildEmailForm() {
    return                 TextFormField(
      style: Constants.kTextFormFieldStyle(),
      controller: emailController,
      decoration: const InputDecoration(
        prefixIcon: Icon(Icons.email_rounded),
        hintText: 'Email',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Per favore inserisci una email';
        } else if (!value.contains('@')) {
          return 'Per favore inserisci una email valida';
        }
        return null;
      },
    );
  }
  /// Build Password Form
  Widget _buildPasswordForm() {
    return TextFormField(
      style: Constants.kTextFormFieldStyle(),
      controller: passwordController,
      obscureText: _isObscure,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.lock_open),
        suffixIcon: IconButton(
          icon: Icon(
            _isObscure
                ? Icons.visibility
                : Icons.visibility_off,
          ),
          onPressed: () {
            setState(() {
              _isObscure = !_isObscure;
            });
          },
        ),
        hintText: 'Password',
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
      ),
      // The validator receives the text that the user has entered.
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter some text';
        } else if (value.length < 7) {
          return 'at least enter 6 characters';
        }
        return null;
      },
    );
  }
  /// Login Button
  Widget _loginButton() {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(const Color(0xA91E88D0)),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
        ),
        onPressed: () async {
          // Validate returns true if the form is valid, or false otherwise.
          if (_formKey.currentState!.validate()) {
            // ... Navigate To your Home Page
            await _SignInButtonPressed();
          }
        },
        child: const Text('Login', style: TextStyle(color: Colors.white, fontSize: 16)),
      ),
    );
  }
  /// HomeButton
  Widget _buildHomeButton(BuildContext context) {
    // Aggiungiamo il bottone per tornare alla home
      return SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () {
            _routerService.goHome(context);
          },
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all(const Color(0xA91E88D0)),
            padding: WidgetStateProperty.all(const EdgeInsets.all(20)),
            shape: WidgetStateProperty.all(RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            )),
          ),
          child: const Text('Torna alla Home', style: TextStyle(color: Colors.white, fontSize: 16)),
        ),
      );
    }
  /// DropDown Menu - section
  Widget _buildDropDownMenu(BuildContext context) {
    return CustomDropdown<String>(
      items: Enums.dropdownItems,
      value: "Dipartimento di Informatica",
      onChanged: (value) {
        setState(() {
          _selectedItem = value!;
        });
      },
    );
  }

  /// Login Button - Action
  Future<void> _SignInButtonPressed() async {
    String email = emailController.text;
    String password = passwordController.text;

    /// SignIn Student - Action
    bool loginStatus = await signinService.signInStudent(
        email, password, _selectedItem);
    if (loginStatus) {

      /// Show Success Login
      Student? userLogged = await signinService.onLoginSuccess(email);

      /// SecureStorageService.save() salva i miei dati nel SecureStorage di Flutter
      await secureStorageService.save(userLogged!);

      /// Mostra un alert di Successo in riferimento alla Login()
      /// Mi ridireziona alla pagina di Home-Page-User
      String id = userLogged!.id;
      CustomPopUpDialog.show(
          context, AlertDialogType.Signin, CustomType.success,path: '/home-page/$id');
    } else {

      /// Error Login
      /// Show Error Login
      CustomPopUpDialog.show(context, AlertDialogType.Signin, CustomType.error);
    }
  }

}