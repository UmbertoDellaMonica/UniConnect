import 'package:flutter/material.dart';


import 'package:get_it/get_it.dart';
import 'package:uni_connect_front_end/shared/components/molecules/custom_loading_bar.dart';
import 'package:uni_connect_front_end/shared/components/molecules/custom_nav_bar.dart';
import 'package:uni_connect_front_end/shared/services/secure_storage_service.dart';
import 'package:uni_connect_front_end/student/home-page-student/components/custom_menu_home_page_student.dart';
import 'package:uni_connect_front_end/student/student.dart';


class HomePageUser extends StatefulWidget {

  final String IDStudent;

  
  const HomePageUser({
    Key? key,
     required this.IDStudent, 
    }) : super(key: key);

  @override
  State<HomePageUser> createState() => _HomePageState();
}

class _HomePageState extends State<HomePageUser> with SingleTickerProviderStateMixin {

  late AnimationController _drawerSlideController;

  late SecureStorageService secureStorageService;

  Student? user;


  @override
  void initState() {
    super.initState();
    _drawerSlideController = AnimationController(vsync: this,duration: const Duration(milliseconds: 150),);
    /// Recupero l'Istanza del SecureStorageService
    final storage = GetIt.I.get<SecureStorageService>();

    if(storage!=null){
      print("storage non è nullo!");
      secureStorageService = storage;
      /// Recupero i dati dello Studente che si è loggato 
      _fetch_Data();
    }
  }

  /// _fetchData() recupera i dati dal SecureStorageService 
  /// Recupera i dati dello Studente loggato 
  Future<void> _fetch_Data() async {
  final retrievedUser = await secureStorageService.get();
  if (retrievedUser != null) {
    setState(() {
      user = retrievedUser;
    });
  }
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
  
  // Indice della pagina corrente
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    // Ottieni l'istanza di UserProvider
    if (user == null) {

      /// Loading Bar - Sezione dedicata al mascheramento del recupero non istantaneo dei dati 
      return CustomLoadingIndicator(progress: 4.5);

      } else {

      //String departement = user!.departmentUnisa; //TODO: gettarsi con hive il valore dell'attore    
      //String wallet = user!.wallet; //TODO: gettarsi con hive il wallet
      //Future<List<Product>> productList = Future.value([]);

      return Scaffold(
          appBar: _buildAppBar(),
            body: Stack(
              children: [
                Padding(
                  padding: EdgeInsets.all(50.5),
                  //child: 
                    //CustomProductList(productList: productList, onProductTap: handleProductTap, emptyMsg: emptyMsg),
                ),
                _buildDrawer(),  
              ],
            ),
            //floatingActionButton: CustomBalance(user: user!),
            //floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
          );
    }
  }

  /*void handleProductTap(BuildContext context, Product product) {
    // Fai qualcosa in base alla pagina in cui ti trovi
    print("Prodotto ${product.name} cliccato!");
    // Esegui azioni diverse in base alla pagina
    DialogProductDetails.show(
      context, 
      product.seller,
      product,
      DialogType.DialogPurchase,
      widget.userType,
      user!.wallet
      );
  }*/


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
      title: 'UniConnect-Student HomePage',
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
          child: _isDrawerClosed() ? const SizedBox() :  CustomMenuHomeUserPageEnv(userData: user!, secureStorageService: secureStorageService),
        );
      },
    );
  }





}