import 'package:flutter/material.dart';
import 'package:uni_connect/Screens/home/components/nav_bar.dart';
import 'package:uni_connect/Screens/signup/services/signup_service.dart';
import 'package:uni_connect/shared/services/router_service.dart';
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

  final RouterService routerService = RouterService();

  @override
  void initState() {
    super.initState();
    // Simula un caricamento asincrono dei dati per 2 secondi
    Future.delayed(const Duration(milliseconds: 400), (){
      setState(() {
        isLoading =
        false; // Imposta isLoading su false quando il caricamento è completo
        this._selectedItem = "Dipartimento di Informatica";
      });
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
      return const CustomLoadingIndicator(progress: 4.5);
    }
    var size = MediaQuery.of(context).size;
    var theme = Theme.of(context);
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(

        appBar:  CustomAppBar(),
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        body: Padding(
      padding: const EdgeInsets.all(50.0),
      child: _buildMainBody(size, theme),
    ),)
    );
  }

  /// Build Main Body - Section
  Widget _buildMainBody(Size size, ThemeData theme) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Image
        Expanded(
          flex: 1,
          child: Transform.scale(
            scale: 0.9,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: Image.asset(
                '/images/signup.jpg',
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),

        const SizedBox(width: 20),
        // Form
        _buildForm(size)
      ],
    );
  }

  /// Build Form

  Expanded _buildForm(Size size) {
    return Expanded(
      flex: 1,
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Registrati',
              style: Constants.kLoginTitleStyle(size),
            ),
            _buildUsernameForm(),
            SizedBox(height: size.height * 0.01),
            _buildEmailForm(),
            SizedBox(height: size.height * 0.01),
            _buildPasswordForm(),
            SizedBox(height: size.height * 0.01),
            SizedBox(height: size.height * 0.01),
            _buildDropDownMenu(context),
            Text(
              'Creando un account, accetti i nostri Termini di Servizio e la nostra Politica sulla Privacy',
              style: Constants.kLoginTermsAndPrivacyStyle(size),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: size.height * 0.01),
            signUpButton(),
            SizedBox(height: size.height * 0.03),
            _buildAlreadyRegistered(size),
            SizedBox(height: size.height * 0.02),
            _buildHomeButton(context),
          ],
        ),
      ),
    );
  }

  Widget signUpButton() {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(const Color(0xA91E88D0)),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
        ),
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            _signUpButtonPressed(context);
          }
        },
        child: const Text(
          'Registrati',
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
    );
  }

  GestureDetector _buildAlreadyRegistered(Size size) {
    return GestureDetector(
      onTap: () {
        routerService.goSignin(context);
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

  TextFormField _buildEmailForm() {
    return TextFormField(
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

  Widget _buildHomeButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          routerService.goHome(context);
        },
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(const Color(0xA91E88D0)),
          padding: MaterialStateProperty.all(const EdgeInsets.all(20)),
          shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              )),
        ),
        child: const Text(
          'Torna alla Home',
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
    );
  }

  void _signUpButtonPressed(context) async {
    String fullName = nameController.text;
    String email = emailController.text;
    String password = passwordController.text;
    String departmentStudent = _selectedItem;

    bool registrationStatus = await signUpService.signUpStudent(
        email, fullName, password, departmentStudent);

    if (registrationStatus) {
      CustomPopUpDialog.show(context, AlertDialogType.Signup, CustomType.success,
          path: "/signin");
    } else {
      CustomPopUpDialog.show(context, AlertDialogType.Signup, CustomType.error);
    }
  }

}
