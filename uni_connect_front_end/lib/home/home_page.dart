// Molecules File 

import 'package:uni_connect_front_end/home/components/custom_menu_home_page.dart';
import 'package:uni_connect_front_end/home/components/slide_card.dart';
import '../shared/components/molecules/custom_nav_bar.dart';



import 'package:flutter/material.dart';


class UniConnectHomePage extends StatefulWidget {
  
  const UniConnectHomePage({super.key});

  @override
  State<UniConnectHomePage> createState() => _UniConnectHomePageAnimations();

}


class _UniConnectHomePageAnimations extends State<UniConnectHomePage> with SingleTickerProviderStateMixin {

  late AnimationController _drawerSlideController;
  
  @override
  void initState() {
    super.initState();

    _drawerSlideController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
    );
  }

  @override
  void dispose() {
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


@override
Widget build(BuildContext context) {
  return MaterialApp(
    title: 'UniConnect-App',
    home: Scaffold(
      // AppBar comune a tutti 
      appBar: _buildAppBar(),
      body: Stack(
        children: [
          _buildHomePage(),
          _buildDrawer(),
        ],
      ),
    ),
  );
}


  // TODO : Modify the body of application
  Widget _buildHomePage() {
  return Center(
    child: Container(
      width: MediaQuery.of(context).size.width * 0.4, // Larghezza al 40% della larghezza dello schermo
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SlideInCard(
            imagePosition: ImagePosition.left,
            title: 'Partita di Latte',
            description: 'Il nostro latte è estratto da allevamenti selezionati, garantendo la massima freschezza e qualità. Grazie alla nostra filiera token, puoi tracciare ogni passo del percorso del latte, assicurandoti che provenga da fonti affidabili e sostenibili. Goditi il gusto puro e cremoso del nostro latte, arricchendo la tua giornata con una sana dose di nutrienti.',
            image: const AssetImage('../assets/milk.png'), // Sostituisci con il percorso dell'immagine 1
          ),
          const SizedBox(height: 5.0),
          SlideInCard(
            imagePosition: ImagePosition.right,
            title: 'Blocco di Formaggio',
            description: "Il nostro blocco di formaggio artigianale è il risultato di una cura meticolosa e di una produzione attenta. Ottenuto da latte di alta qualità, ogni blocco rappresenta un'opera d'arte culinaria. La sua consistenza cremosa e il sapore ricco rendono questo formaggio perfetto per una varietà di piatti. Scegli il nostro blocco di formaggio per elevare il gusto delle tue creazioni culinarie.",
            image: const AssetImage('../assets/cheese_block.png'), // Sostituisci con il percorso dell'immagine 2
          ),
          const SizedBox(height: 5.0),
          SlideInCard(
            imagePosition: ImagePosition.left,
            title: 'Pezzo di Formaggio',
            description: "Il nostro pezzo di formaggio è un'esperienza di degustazione unica nel suo genere. Prodotto in quantità limitate e con ingredienti pregiati, questo formaggio offre un equilibrio perfetto di sapori intensi. Ogni pezzo è confezionato con cura, garantendo che tu possa gustare il meglio della tradizione casearia. Aggiungi un tocco di raffinatezza ai tuoi aperitivi o alle tue ricette preferite con il nostro pezzo di formaggio esclusivo.",
            image: const AssetImage('../assets/cheese_piece.png'), // Sostituisci con il percorso dell'immagine 3
          ),
        ],
      ),
    ),
  );
}




   /// Construisce la NavBar Custom
   /// - Inserimento del Logo 
   /// - Inserimento del Testo 
   /// - Inserimento del Menù 
  PreferredSizeWidget _buildAppBar() {
    return CustomAppBar(
      leading: Image.asset('../assets/filiera-token-logo.png',width: 1000, height: 1000, fit: BoxFit.fill),
      centerTitle: true,
      title: 'UniConnect App',
      backgroundColor: Colors.transparent,
      elevation: 2.0,
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
          child: _isDrawerClosed() ? const SizedBox() : const CustomMenuHomePage(),
        );
      },
    );
  }

}


