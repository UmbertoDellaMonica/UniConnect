import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:uni_connect/Screens/home/components/nav_bar.dart';
import 'package:uni_connect/Screens/signup/services/signup_service.dart';
import 'package:uni_connect/shared/utils/constants.dart';
import 'package:uni_connect/shared/custom_loading_bar.dart';

import '../../../../shared/custom_alert_dialog.dart';
import '../../../../shared/custom_dropdown_menu.dart';

class DesktopSignupPage extends StatefulWidget {
  @override
  _DesktopSignupPageState createState() => _DesktopSignupPageState();
}

class _DesktopSignupPageState extends State<DesktopSignupPage> {


  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  late String _selectedItem; // Variabile per memorizzare l'elemento selezionato nel dropdown

  final _formKey = GlobalKey<FormState>();
  bool _isObscure = true;

  bool isLoading = true; // Variabile per tracciare lo stato del caricamento
  SignUpService signUpService = SignUpService();

  @override
  void initState() {
    super.initState();
    // Simula un caricamento asincrono dei dati per 2 secondi
      setState(() {
        isLoading = false; // Imposta isLoading su false quando il caricamento è completo
        this._selectedItem= "Dipartimento di Informatica";
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
      child: Scaffold(
        appBar: CustomAppBar(),
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        body: Center(

          child: _buildMainBody(size, theme)
        ),
      ),
    );
  }

  /// Build Main Body - Section
  Widget _buildMainBody(Size size, ThemeData theme) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Image
        Expanded(
          flex: 1,
          child: Transform.scale(
            scale: 0.8,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: Image.asset(
                '/images/signup.jpg',
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),

        SizedBox(width: 20),
        // Form
        _buildForm(size)
      ],
    );
  }

  /// Build Form
  Expanded _buildForm(Size size){
    return Expanded(
      flex: 1, child:
      Form(
        key: _formKey,
        child: Column(
          children: [
            Text(
              'Registrati',
              style: Constants.kLoginTitleStyle(size),
            ),
            /// Username Form
            _buildUsernameForm(),
            SizedBox(
              height: size.height * 0.01,
            ),
            /// Email Form
            _buildEmailForm(),
            SizedBox(
              height: size.height * 0.01,
            ),
            /// Password Controller
            _buildPasswordForm(),
            SizedBox(
              height: size.height * 0.01,
            ),
            SizedBox(
              height: size.height * 0.01,
            ),
            _buildDropDownMenu(context),
            Text(
              'Creando un account, accetti i nostri Termini di Servizio e la nostra Politica sulla Privacy',
              style: Constants.kLoginTermsAndPrivacyStyle(size),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: size.height * 0.01,
            ),
            signUpButton(),
            SizedBox(
              height: size.height * 0.03,
            ),
            /// Build  Section - AlreadyRegister
            _buildAlreadyRegisteres(size),
            SizedBox(
              height: size.height * 0.02,
            ),
            _buildHomeButton(context)
          ],
        ),
      ),
    );
  }

  /// Form Component --- Section

  /// Sign Button
  Widget signUpButton() {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Color(0xA91E88D0)),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
        ),
        onPressed: () => {
          if (_formKey.currentState!.validate()) {
            // ... Navigate To your Home Page
             _SignUpButtonPressed()
          }
        },
        child: const Text('Registrati', style: TextStyle(color: Colors.white, fontSize: 16)),
      ),
    );
  }
  /// Build - AlreadyRegistered - Section
  GestureDetector _buildAlreadyRegisteres(Size size) {
    return GestureDetector(
      onTap: () {
        context.go("/signin");
        nameController.clear();
        emailController.clear();
        passwordController.clear();
        _formKey.currentState?.reset();
      },
      child: RichText(
        text: TextSpan(
          text: 'Hai già un account?',
          style: Constants.kHaveAnAccountStyle(size),
          children: [
            TextSpan(
                text: " Accedi",
                style: Constants.kLoginOrSignUpTextStyle(size)),
          ],
        ),
      ),
    );
  }
  /// Password Field - Section
  TextFormField _buildPasswordForm() {
    return TextFormField(
      style: Constants.kTextFormFieldStyle(),
      controller: passwordController,
      obscureText: _isObscure,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.lock_open),
        suffixIcon: IconButton(
          icon: Icon(
            _isObscure ? Icons.visibility : Icons.visibility_off,
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
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Per favore inserisci una password';
        } else if (value.length < 7) {
          return 'Almeno 7 caratteri';
        }
        return null;
      },
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
  /// Username Field - section
  TextFormField _buildUsernameForm() {
    return TextFormField(
      style: Constants.kTextFormFieldStyle(),
      decoration: const InputDecoration(
        prefixIcon: Icon(Icons.person),
        hintText: 'Username',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
      ),
      controller: nameController,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Per favore inserisci il tuo Nome e Cognome ';
        }
        return null;
      },
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
    
  ///Build Home Button 
  Widget _buildHomeButton(BuildContext context) {
    // Aggiungiamo il bottone per tornare alla home
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          context.go("/");  // Naviga verso la home page
        },
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Color(0xA91E88D0)),
          padding: MaterialStateProperty.all(EdgeInsets.all(20)),
          shape: MaterialStateProperty.all(RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          )),
        ),
        child: Text('Torna alla Home', style: TextStyle(color: Colors.white, fontSize: 16)),
      ),
    );
  }



  /// Metodo per eseguire tutta la logica della registrazione
  /// Recupera i valori dal Form
  /// Verifica se le password coincidono
  void _SignUpButtonPressed() async {
    // Recupera i valori dai controller
    String fullName = this.nameController.text;
    String email = this.emailController.text;
    String password = this.passwordController.text;
    String departmentStudent = this._selectedItem;
    /// SignUp Action
    bool registrationStatus = await signUpService.signUpStudent(email,fullName,password,departmentStudent);
    if(registrationStatus){
      /// TRUE Registration
      CustomPopUpDialog.show(context, AlertDialogType.Signup, CustomType.success, path: "/signin");
    }else{
      /// FALSE Registration
      CustomPopUpDialog.show(context, AlertDialogType.Signup, CustomType.error);
    }
  }

}
