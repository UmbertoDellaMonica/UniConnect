import 'package:flutter/material.dart';
/// Component Page 
import 'package:get_it/get_it.dart';
import 'package:uni_connect_front_end/shared/color_utils.dart';
import 'package:uni_connect_front_end/shared/components/molecules/custom_loading_bar.dart';
import 'package:uni_connect_front_end/shared/components/molecules/custom_nav_bar.dart';
import 'package:uni_connect_front_end/shared/enums.dart';
import 'package:uni_connect_front_end/shared/services/secure_storage_service.dart';
import 'package:uni_connect_front_end/student/student-profile/components/custom_floating_button_delete.dart';
import 'package:uni_connect_front_end/student/student-profile/components/custom_menu_profile.dart';
import 'package:uni_connect_front_end/student/student-profile/components/custom_view_profile.dart';
import 'package:uni_connect_front_end/student/student.dart';


class UserProfilePage extends StatefulWidget {
  
  UserProfilePage({
    super.key,
      required String IDStudent
      });


  @override
  State<UserProfilePage> createState() => _UserProfilePageAnimations();
}


class _UserProfilePageAnimations extends State<UserProfilePage> with SingleTickerProviderStateMixin {


  late AnimationController _drawerSlideController;

  Student? user;

  late SecureStorageService secureStorageService;




    @override
    void initState() {
      super.initState();
      
      _drawerSlideController = AnimationController(vsync: this,duration: const Duration(milliseconds: 150),);

      final storage = GetIt.I.get<SecureStorageService>();
      
      if(storage!=null){
        print("storage non è nullo!");
        secureStorageService = storage;
        _fetch_Data();  
      }
    }

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


    @override
    Widget build(BuildContext context) {
      if (user == null) {
        // Se user non è ancora stato inizializzato, visualizza un indicatore di caricamento o un altro widget di fallback
        return CustomLoadingIndicator(progress: 4.5);
      } else {
        // Se user è stato inizializzato, costruisci il widget CustomViewProfile
        return Scaffold(
              appBar: _buildAppBar(),
              body: Stack(
                children: [
                    Center(
                      child: IntrinsicHeight(
                        child: IntrinsicWidth(child: 
                          Container(
                          width: MediaQuery.of(context).size.width * 0.4,
                          padding: const EdgeInsets.all(40.0),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: ColorUtils.getColor(CustomType.neutral),
                            ),
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          child: CustomViewProfile(userData: user!),
                        ),
                      ),
                    ),
                  ),
                  CustomDeleteUserButton(),
                  _buildDrawer(),
                ],
              ),
            );
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
      title: 'Filiera-Token-Setting',
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
          child: _isDrawerClosed() ? const SizedBox() : CustomMenu(userData: user!,secureStorageService: secureStorageService,),
        );
      },
    );
  }

  



}





