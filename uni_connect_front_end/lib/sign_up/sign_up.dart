import 'dart:async';



import 'package:uni_connect_front_end/shared/components/atoms/custom_input_validator.dart';
import 'package:uni_connect_front_end/shared/components/atoms/custom_button.dart';
import 'package:uni_connect_front_end/shared/color_utils.dart';
import 'package:uni_connect_front_end/shared/enums.dart';



import 'package:uni_connect_front_end/shared/components/molecules/custom_nav_bar.dart';
import 'package:uni_connect_front_end/sign_up/components/custom_menu_singup.dart';
import 'package:uni_connect_front_end/shared/custom_alert_dialog.dart';
import 'package:uni_connect_front_end/shared/components/atoms/custom_dropdown.dart';


import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:uni_connect_front_end/sign_up/service/signup_service.dart';
import 'package:uni_connect_front_end/student/utils/password_service_utils.dart';


class UniConnectSignUpPage extends StatefulWidget {

  const UniConnectSignUpPage({super.key,required this.title});

  final String title;

  @override
  State<UniConnectSignUpPage> createState() => _MySignUpPageAnimations();

}

class _MySignUpPageAnimations extends State<UniConnectSignUpPage> with SingleTickerProviderStateMixin{

  var dropdownItems = Enums.dropdownItems;
  
  late String selectedDepartementStudent;
  late String nameInput;
  late String cognomeInput;
  late String fullName;
  late String emailInput;
  late String passwordInput;
  late String confermaPasswordInput;
  late String walletInput;
  
  TextEditingController ?_nameController;
  TextEditingController ?_lastNameController;
  TextEditingController ? _emailController;
  TextEditingController ?_passwordController;
  TextEditingController ?_confirmPasswordController;

  /// Injection of Service 
  final signUpService = SignUpService();
  /// Injection of Static Widget 
  final customPopUpDialog = CustomPopUpDialog();

  late AnimationController _drawerSlideController;



  
  @override
  void initState() {
    _nameController = TextEditingController();
    _lastNameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
    selectedDepartementStudent = "Dipartimento di Informatica";
    super.initState();

     _drawerSlideController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
    );
  }


   @override
  void dispose() {
    // Clean up the controllers when the Widget is disposed
    _nameController?.dispose();
    _lastNameController?.dispose();
    _emailController?.dispose(); 
     _passwordController?.dispose();
    _confirmPasswordController?.dispose();
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
      title: 'UniConnect SignUp',
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
          child: _isDrawerClosed() ? const SizedBox() : const CustomMenuSignup(),
        );
      },
    );
}


  /**
   * Build Form di Registrazione 
   */
  Widget buildFormRegistrazione(BuildContext context) {
    // Form di iscrizione
    return Center(
      child: Expanded(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.4,
          height: MediaQuery.of(context).size.height*2.5,
          padding: const EdgeInsets.all(30.0),
          decoration: BoxDecoration(
            border: Border.all(
              color: ColorUtils.getColor(CustomType.neutral),
            ),
            borderRadius: BorderRadius.circular(30.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Registrazione', // Titolo "Login"
                style: TextStyle(
                  fontSize: 24.0, // Dimensione del testo
                  fontWeight: FontWeight.bold, // Grassetto
                  color: ColorUtils.getColor(CustomType.neutral), // Colore neutral
                ),
              ),
              const SizedBox(height: 10),
              /// Name Controller 
              CustomInputValidator(
                inputType: TextInputType.name,
                labelText: 'Nome',
                controller: _nameController!,
              ),
              const SizedBox(height: 10),
              /// Cognome Controller 
              CustomInputValidator(
                inputType: TextInputType.name,
                labelText: 'Cognome',
                controller: _lastNameController!,
              ),
              const SizedBox(height: 10),
              /// Email Controller 
              CustomInputValidator(
                inputType: TextInputType.emailAddress,
                labelText: 'Email',
                controller: _emailController!,
              ),
              const SizedBox(height: 10),
              /// Password Controller 
              CustomInputValidator(
                inputType: TextInputType.visiblePassword,
                labelText: 'Password',
                controller: _passwordController!,
              ),
              const SizedBox(height: 10),
              /// Password Confirmed Controller 
              CustomInputValidator(
                inputType: TextInputType.visiblePassword,
                labelText: 'Conferma password',
                controller: _confirmPasswordController!,
              ),
              const SizedBox(height: 10),
              /// DropDown Section
                buildDropDownSection(context),
              const SizedBox(height: 10),
              /// Registration - Section 
                buildRegisterButton(context),
              const SizedBox(height: 10),
              /// Login Text - Section 
              Center(
                child: Text(
                  'Hai già un account?',
                  style: TextStyle(
                    color: ColorUtils.labelColor,
                  ),
                ),
              ),
              /// Login Button 
              buildIsRegisteredButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildIsRegisteredButton(BuildContext context){
      return 
          CustomButton(
            expandWidth: true,
            text: "Login",
            type: CustomType.neutral,
            onPressed: () => context.go('/signin'),
      );
  }

  Widget buildRegisterButton(BuildContext context){
    return 
    CustomButton(
                expandWidth: true,
                text: "Registrati",
                type: CustomType.neutral,
                onPressed: () async =>await _SignUpButtonPressed() 
      );
  }

  Widget buildDropDownSection(BuildContext context){
      return CustomDropdown<String>(
                items: dropdownItems,
                value: "Dipartimento di Informatica",
                onChanged: (value) {
                  setState(() {
                    selectedDepartementStudent = value!;
                  });
                },
              );
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Stack(
          children: <Widget>[
            /// Registration Form 
            buildFormRegistrazione(context),
            _buildDrawer(),
          ],
        ),
    );
  }





  /// Metodo per eseguire tutta la logica della registrazione 
  /// Recupera i valori dal Form 
  /// Verifica se le password coincidono
  Future<void>_SignUpButtonPressed() async {
      // Recupera i valori dai controller
      nameInput = _nameController!.text;
      cognomeInput = _lastNameController!.text;
      emailInput = _emailController!.text;
      passwordInput = _passwordController!.text;
      confermaPasswordInput = _confirmPasswordController!.text;
      fullName = nameInput + " " + cognomeInput;
      /// Check Password and Password Hashed 
      if(PasswordService.checkPassword(passwordInput,confermaPasswordInput)) {
          /// Visualizza il Dialog - Error 
          CustomPopUpDialog.show(context, AlertDialogType.Signup, CustomType.error, errorDetail: "Le password non corrispondono.");
      } else {
        /// SignUp Action 
        bool registrationStatus = await signUpService.signUpStudent(emailInput,fullName,passwordInput,selectedDepartementStudent);
        if(registrationStatus){
          /// TRUE Registration
          CustomPopUpDialog.show(context, AlertDialogType.Signup, CustomType.success, path: "/signin");
          }else{
          /// FALSE Registration
          CustomPopUpDialog.show(context, AlertDialogType.Signup, CustomType.error);
        }
      }
    } 




}