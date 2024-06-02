import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:uni_connect/Screens/home/components/content_row.dart';
import 'package:uni_connect/Screens/home/components/footer_bar.dart';
import 'package:uni_connect/Screens/home/components/nav_bar.dart';
import 'package:uni_connect/Screens/home/components/welcome_image.dart';
import 'package:uni_connect/shared/custom_loading_bar.dart';

import '../../utils/constants_home.dart';

class DesktopWelcomePage extends StatefulWidget {
  @override
  _DesktopWelcomePageState createState() => _DesktopWelcomePageState();
}

class _DesktopWelcomePageState extends State<DesktopWelcomePage> {

  final ScrollController _scrollController = ScrollController();
  bool _showFooter = false;

  bool isLoading = true; // Variabile per tracciare lo stato del caricamento

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
    // Simula un caricamento asincrono dei dati per 2 secondi
    Future.delayed(Duration(seconds: 1), () {
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
      return CustomLoadingIndicator(progress: 4.5);
    }
    return Scaffold(
      appBar: CustomAppBar(),
      body:
        Stack(
          children:[
                _buildBody(),
                SizedBox(height: 100),
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
                          Text(
                            'Benvenuto in UniConnect!',
                            style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 20),
                          Text(
                            homePageDescription,
                            style: TextStyle(fontSize: 18),
                          ),
                          SizedBox(height: 40),
                          ElevatedButton(
                            onPressed: () async {
                              // Azione per il pulsante di accesso
                              context.go("/signup");
                            },
                            child: Text('Registrati'),
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
                      titleContent: "Follow",
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
