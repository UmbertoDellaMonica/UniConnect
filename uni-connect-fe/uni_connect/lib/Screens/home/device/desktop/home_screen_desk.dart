import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uni_connect/Screens/home/components/content_row.dart';
import 'package:uni_connect/Screens/home/components/footer_bar.dart';
import 'package:uni_connect/Screens/home/components/nav_bar.dart';
import 'package:uni_connect/Screens/home/components/welcome_image.dart';
import 'package:uni_connect/shared/custom_loading_bar.dart';
import 'package:uni_connect/shared/services/router_service.dart';

import '../../utils/constants_home.dart';

class DesktopWelcomePage extends StatefulWidget {
  @override
  _DesktopWelcomePageState createState() => _DesktopWelcomePageState();
}

class _DesktopWelcomePageState extends State<DesktopWelcomePage> {

  final ScrollController _scrollController = ScrollController();
  final RouterService routerService = RouterService();
  bool _showFooter = false;

  bool isLoading = true; // Variabile per tracciare lo stato del caricamento

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
    // Simula un caricamento asincrono dei dati per 2 secondi
    Future.delayed(const Duration(milliseconds: 400), () {
      setState(() {
        isLoading = false; // Imposta isLoading su false quando il caricamento è completo
      });
    });
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
    if(isLoading){
      return const CustomLoadingIndicator(progress: 4.5);
    }
    return Scaffold(
      appBar: CustomAppBar(),
      body:
        Stack(
          children:[
                _buildBody(),
                const SizedBox(height: 100),
            if (_showFooter)
                FooterBar()
        ],
      )
    );
  }
    /// Build Body of HomeScreen
    SingleChildScrollView _buildBody(){
      return
        SingleChildScrollView(
        controller: _scrollController,
        child: 
        Column(
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Transform.scale(
                      scale: 0.9, // Scala l'immagine al 50% delle sue dimensioni originali
                      child: RoundedImage(welcomeImage),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(32.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Benvenuto in UniConnect!',
                            style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 20),
                          const Text(
                            homePageDescription,
                            style: TextStyle(fontSize: 18),
                          ),
                          const SizedBox(height: 40),
                          ElevatedButton(
                            onPressed: () {
                              // Azione per il pulsante di accesso
                              routerService.goSignup(context);
                            },
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white, backgroundColor: Colors.blueAccent, padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24), // Colore del testo del pulsante
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30), // Bordi arrotondati
                                side: const BorderSide(color: Colors.blueAccent), // Bordo del pulsante
                              ),
                              elevation: 3, // Aggiungi un'ombra leggera
                            ),
                            child: const Text(
                              "Registrati",
                              style: TextStyle(fontSize: 18), // Aggiorna le dimensioni del testo
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(32.0),
                child: Column(
                  children: [
                    ContentRow(
                      imagePath: loginImage,
                      titleContent: "Login",
                      description: homePageLoginDescription,
                      reverseOrder: true,
                    ),
                    const SizedBox(height: 100),

                    ContentRow(
                      imagePath: chatImage,
                      titleContent: "SignUp",
                      description: homePageSignupDescription,
                      reverseOrder: false,
                    ),
                    const SizedBox(height: 100),
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
