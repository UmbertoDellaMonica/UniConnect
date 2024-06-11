import 'package:flutter/material.dart';
import 'package:uni_connect/Screens/home/components/content_row.dart';
import 'package:uni_connect/Screens/home/components/footer_bar.dart';
import 'package:uni_connect/Screens/home/components/nav_bar.dart';
import 'package:uni_connect/Screens/home/components/welcome_image.dart';
import 'package:uni_connect/shared/services/router_service.dart';

import '../../utils/constants_home.dart';

class MobileWelcomePage extends StatefulWidget {
  @override
  _MobileWelcomePageState createState() => _MobileWelcomePageState();
}

class _MobileWelcomePageState extends State<MobileWelcomePage> {


  final ScrollController _scrollController = ScrollController();
  bool _showFooter = false;
  final RouterService routerService = RouterService();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      setState(() {
        _showFooter = true;
      });
    } else {
      setState(() {
        _showFooter = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Stack(
        children: [
            /// Build Body of HomwScreen
            _buildBody(),

          SizedBox(height: 100),
            /// Check if scroll is arrived to Bottom
            if (_showFooter)
                /// Display Footer
                FooterBar()
        ],
      ),
    );
  }

  SingleChildScrollView _buildBody(){
    return
      SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: [
            RoundedImage(welcomeImage),
            Padding(
              padding: const EdgeInsets.all(32.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Benvenuto nella nostra App Social!',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),
                  Text(
                    homePageDescription,
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 40),
                  ElevatedButton(
                    onPressed: () {
                      // Azione per il pulsante di accesso
                      routerService.goSignup(context);
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.black, backgroundColor: Colors.greenAccent, padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24), // Colore del testo del pulsante
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30), // Bordi arrotondati
                        side: BorderSide(color: Colors.greenAccent), // Bordo del pulsante
                      ),
                      elevation: 3, // Aggiungi un'ombra leggera
                    ),
                    child: Text(
                      "Registrati",
                      style: TextStyle(fontSize: 18), // Aggiorna le dimensioni del testo
                    ),
                  ),
                  // Ulteriori informazioni
                  SizedBox(height: 100),
                  ContentRow(
                    imagePath: loginImage,
                    titleContent: "Login",
                    description: homePageLoginDescription,
                    reverseOrder: true,
                  ),
                  SizedBox(height: 100),
                  ContentRow(
                    imagePath: chatImage,
                    titleContent: "SignUp",
                    description: homePageSignupDescription,
                    reverseOrder: false,
                  ),
                  SizedBox(height: 100),
                  ContentRow(
                    imagePath: followImage,
                    titleContent: "Follow us",
                    description: homePageFeaturesDesccription,
                    reverseOrder: true,
                  ),
                ],
              ),
            ),
          ],
        ),
      );
  }



}
