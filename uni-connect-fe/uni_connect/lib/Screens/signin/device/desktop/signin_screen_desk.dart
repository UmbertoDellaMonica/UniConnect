import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:uni_connect/Screens/home/components/welcome_image.dart';

import '../../../../constants.dart';
import '../../../../shared/custom_loading_bar.dart';
import '../../../home/components/nav_bar.dart';

class DesktopSigninPage extends StatefulWidget {
  const DesktopSigninPage({Key? key}) : super(key: key);

  @override
  State<DesktopSigninPage> createState() => _DesktopSigninPageState();
}

class _DesktopSigninPageState extends State<DesktopSigninPage> {

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool _isObscure = true;
  bool isLoading = true; // Variabile per tracciare lo stato del caricamento


  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {

    super.initState();
    // Simula un caricamento asincrono dei dati per 2 secondi
    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        isLoading = false; // Imposta isLoading su false quando il caricamento è completo
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
    var size = MediaQuery.of(context).size;
    if(isLoading){
      return CustomLoadingIndicator(progress: 4.5);
    }
    return Scaffold(
      appBar: CustomAppBar(),
      body: Row(
        children: [
          Expanded(
            flex: 3,
            child: RoundedImage('images/login.jpg'),
          ),
          SizedBox(width: size.width * 0.06),
          Expanded(
            flex: 5,
            child: _buildMainBody(
              size,
            ),
          ),
        ],
      ),
    );
  }



  /// Main Body
  Widget _buildMainBody(Size size) {
    var animation = Lottie.asset('wave.json', height: size.height * 0.2, width: size.width, fit: BoxFit.fill,);
    return Column(
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

            /// Login Button
            _loginButton(),
            SizedBox(
              height: size.height * 0.03,
            ),

            /// Navigate To Login Screen
            GestureDetector(
              onTap: () {
                context.go('/signup');
                nameController.clear();
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


  /// Build Email Form
  Widget _buildEmailForm() {
    return TextFormField(
      style: Constants.kTextFormFieldStyle(),
      decoration: const InputDecoration(
        prefixIcon: Icon(Icons.person),
        hintText: 'Username or Gmail',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
      ),
      controller: nameController,
      // The validator receives the text that the user has entered.
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter username';
        } else if (value.length < 4) {
          return 'at least enter 4 characters';
        } else if (value.length > 13) {
          return 'maximum character is 13';
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
        } else if (value.length > 13) {
          return 'maximum character is 13';
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
          backgroundColor: MaterialStateProperty.all(Color(0xA91E88D0)),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
        ),
        onPressed: () {
          // Validate returns true if the form is valid, or false otherwise.
          if (_formKey.currentState!.validate()) {
            // ... Navigate To your Home Page
          }
        },
        child: Text('Login', style: TextStyle(color: Colors.white, fontSize: 16)),
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


}