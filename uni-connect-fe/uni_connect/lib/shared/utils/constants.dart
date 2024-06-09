import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


enum CustomType { neutral, neutralShade, error, warning, success }

enum AlertDialogType { Signup, Signin, Logout, PostCreate, PostDelete, PostUpdate}


enum DepartmentUnisa {
  AGRICOLA,
  ARCHITETTURA,
  BIOMEDICHE,
  FORMAZIONE_BENICULTURALI,
  CHIMICHE,
  ECONOMICHE_STATISTICHE,
  GIURIDICHE,
  INGEGNERIA_ELETTRICA,
  INGEGNERIA_EDILE,
  INGEGNERIA_INDUSTRIALE,
  INFORMATICA,
  MATEMATICA_FISICA,
  MEDICINA_CHIRURGIA_ODONTOIATRIA,
  FARMACIA,
  MOTORIE_UMANE_SOCIALI,
  POLITICHE_SOCIALI,
  LINGUAGGIO_BENICULTURALI,
  FISICA,
  SCUOLA_MEDICINA;
}


class Enums {


  static String loremIpsumString = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer nec odio. Praesent libero. Sed cursus ante dapibus diam. Sed nisi. Nulla quis sem at nibh elementum imperdiet. Duis sagittis ipsum. Praesent mauris. Fusce nec tellus sed augue semper porta. Mauris massa. Vestibulum lacinia arcu eget nulla. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos.Curabitur sodales ligula in libero. Sed dignissim lacinia nunc. Curabitur tortor. Pellentesque nibh. Aenean quam. In scelerisque sem at dolor. Maecenas mattis. Sed convallis tristique sem. Proin ut ligula vel nunc egestas porttitor. Morbi lectus risus, iaculis vel, suscipit quis, luctus non, massa. Fusce ac turpis quis ligula lacinia aliquet. Mauris ipsum. Nulla metus metus, ullamcorper vel, tincidunt sed, euismod in, nibh. Quisque volutpat condimentum velit. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos.Nam nec ante. Sed lacinia, urna non tincidunt mattis, tortor neque adipiscing diam, a cursus ipsum ante quis turpis. Nulla facilisi. Ut fringilla. Suspendisse potenti. Nunc feugiat mi a tellus consequat imperdiet. Vestibulum sapien. Proin quam. Etiam ultrices. Suspendisse in justo eu magna luctus suscipit. Sed lectus. Integer euismod lacus luctus magna. Quisque cursus, metus vitae pharetra auctor, sem massa mattis sem, at interdum magna augue eget diam. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Morbi lacinia molestie dui. Praesent blandit dolor. Sed non quam. In vel mi sit amet augue congue elementum. Morbi in ipsum sit amet pede facilisis laoreet. Donec lacus nunc, viverra nec.Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed non risus. Suspendisse lectus tortor, dignissim sit amet, adipiscing nec, ultricies sed, dolor. Cras elementum ultrices diam. Maecenas ligula massa, varius a, semper congue, euismod non, mi. Proin porttitor, orci nec nonummy molestie, enim est eleifend mi, non fermentum diam nisl sit amet erat. Duis semper. Duis arcu massa, scelerisque vitae, consequat in, pretium a, enim. Pellentesque congue. Ut in risus volutpat libero pharetra tempor. Cras vestibulum bibendum augue. Praesent egestas leo in pede. Praesent blandit odio eu enim. Pellentesque sed dui ut augue blandit sodales. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Aliquam nibh. Mauris ac mauris sed pede pellentesque fermentum. Maecenas adipiscing ante non diam sodales hendrerit.Ut velit mauris, egestas sed, gravida nec, ornare ut, mi. Aenean ut orci vel massa suscipit pulvinar. Nulla sollicitudin. Fusce varius, ligula non tempus aliquam, nunc turpis ullamcorper nibh, in tempus sapien eros vitae ligula. Pellentesque rhoncus nunc et augue. Integer id felis. Curabitur aliquet pellentesque diam. Integer quis metus vitae elit lobortis egestas. Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Morbi vel erat non mauris convallis vehicula. Nulla et sapien. Integer tortor tellus, aliquam faucibus, convallis id, congue eu, quam. Mauris ullamcorper felis vitae erat. Proin feugiat, augue non elementum posuere, metus purus iaculis lectus, et tristique ligula justo vitae magna.";
  static List<String> dropdownItems = [
    "Dipartimento di Agraria",
    "Dipartimento di Architettura",
    "Dipartimento di Scienze Biomediche",
    "Dipartimento di Scienze della Formazione", "Beni Culturali e Turismo",
    "Dipartimento di Scienze Chimiche",
    "Dipartimento di Scienze Economiche e Statistiche",
    "Dipartimento di Scienze Giuridiche",
    "Dipartimento di Ingegneria dell'Informazione ed Elettrica",
    "Dipartimento di Ingegneria Civile, Edile e Ambientale",
    "Dipartimento di Ingegneria Industriale",
    "Dipartimento di Informatica",
    "Dipartimento di Matematica e Fisica",
    "Dipartimento di Medicina, Chirurgia e Odontoiatria",
    "Dipartimento di Farmacia",
    "Dipartimento di Scienze Motorie, Umane e Sociali",
    "Dipartimento di Scienze Politiche e Sociali",
    "Dipartimento di Scienze del Linguaggio e Beni Culturali",
    "Dipartimento di Fisica",
    "Scuola di Medicina"
  ];


  /// Dropdown -> Name Student Department
  /// Questo metodo viene utilizzato nel momento in cui ,io voglio scegliere nel SignUp a quale dipartimento appartengo
  /// Lo mando al Server e lo riconosce come uno degli Enum che abbiamo Segnalato
  static String getDepartmentStudent(String department) {
    if (dropdownItems.contains(department)) {
      switch (department) {
        case "Dipartimento di Agraria":
          return DepartmentUnisa.AGRICOLA.name;
        case"Dipartimento di Architettura":
          return DepartmentUnisa.ARCHITETTURA.name;
        case"Dipartimento di Scienze Biomediche":
          return DepartmentUnisa.BIOMEDICHE.name;
        case"Dipartimento di Scienze della Formazione Beni Culturali e Turismo":
          return DepartmentUnisa.FORMAZIONE_BENICULTURALI.name;
        case "Dipartimento di Scienze Chimiche":
          return DepartmentUnisa.CHIMICHE.name;
        case"Dipartimento di Scienze Economiche e Statistiche":
          return DepartmentUnisa.ECONOMICHE_STATISTICHE.name;
        case "Dipartimento di Scienze Giuridiche":
          return DepartmentUnisa.GIURIDICHE.name;
        case"Dipartimento di Ingegneria dell'Informazione ed Elettrica":
          return DepartmentUnisa.INGEGNERIA_ELETTRICA.name;
        case "Dipartimento di Ingegneria Civile, Edile e Ambientale":
          return DepartmentUnisa.INGEGNERIA_EDILE.name;
        case"Dipartimento di Ingegneria Industriale":
          return DepartmentUnisa.INGEGNERIA_INDUSTRIALE.name;
        case "Dipartimento di Informatica":
          return DepartmentUnisa.INFORMATICA.name;
        case"Dipartimento di Matematica e Fisica":
          return DepartmentUnisa.MATEMATICA_FISICA.name;
        case"Dipartimento di Medicina, Chirurgia e Odontoiatria":
          return DepartmentUnisa.MEDICINA_CHIRURGIA_ODONTOIATRIA.name;
        case "Dipartimento di Farmacia":
          return DepartmentUnisa.FARMACIA.name;
        case "Dipartimento di Scienze Motorie, Umane e Sociali":
          return DepartmentUnisa.MOTORIE_UMANE_SOCIALI.name;
        case "Dipartimento di Scienze Politiche e Sociali":
          return DepartmentUnisa.POLITICHE_SOCIALI.name;
        case "Dipartimento di Scienze del Linguaggio e Beni Culturali":
          return DepartmentUnisa.LINGUAGGIO_BENICULTURALI.name;
        case "Dipartimento di Fisica":
          return DepartmentUnisa.FISICA.name;
        case"Scuola di Medicina" :
          return DepartmentUnisa.SCUOLA_MEDICINA.name;

        default :
          return "";
      }
    } else {
      return "";
    }
  }
  /*
    *  Questa funzione restituisce un testo di default basandosi sul CustomType
    */
  static String getTypeButton(CustomType type) {
    switch (type) {
      case CustomType.neutral: case CustomType.neutralShade:
      return "Conferma";
      case CustomType.error:
        return "Cancella";
      case CustomType.warning:
        return "Annulla";
      case CustomType.success:
        return "OK";
    }
  }
}


class ColorUtils {

  /*
   *  Questa funzione restituire un colore basandosi sul CustomType
   */
  static Color getColor(CustomType type) {
    switch (type) {
      case CustomType.neutral:
        return Colors.blue;
      case CustomType.neutralShade:
        return Colors.blue.shade50;
      case CustomType.error:
        return Colors.red;
      case CustomType.warning:
        return Colors.amber;
      case CustomType.success:
        return Colors.green;
    }
  }

  static const Color labelColor = Color.fromARGB(255, 101, 133, 170);
}


class Constants{

  static Color  kPrimaryColor = Color.fromARGB(255, 80, 125, 202);
  static Color kPrimaryLightColor = Colors.white;


 static TextStyle kLoginTitleStyle(Size size) => GoogleFonts.ubuntu(
    fontSize: size.height * 0.030,
    fontWeight: FontWeight.bold,
  );

  static TextStyle kLoginSubtitleStyle(Size size) => GoogleFonts.ubuntu(
    fontSize: size.height * 0.030,
  );

 static TextStyle kLoginTermsAndPrivacyStyle(Size size) =>
      GoogleFonts.ubuntu(fontSize: 15, color: Colors.grey, height: 1.5);

  static TextStyle kHaveAnAccountStyle(Size size) =>
      GoogleFonts.ubuntu(fontSize: size.height * 0.022, color: Colors.black);

  static TextStyle kLoginOrSignUpTextStyle(
      Size size,
      ) =>
      GoogleFonts.ubuntu(
        fontSize: size.height * 0.022,
        fontWeight: FontWeight.w500,
        color: Color(0xA91E88D0),
      );

  static TextStyle kTextFormFieldStyle() => const TextStyle(color: Colors.black);


  static String signupImage = "../assets/images/signup.png";

  static String titleApp = 'UniConnect';

  static String logoImage = '../assets/images/logo.png';

  static String welcomeImage = "../assets/images/welcome.jpg";
  static String loginImage = "../assets/images/login.jpg";
  static String followImage = "../assets/images/follow.jpg";
  static String chatImage = "../assets/images/chat.jpg";

  /// Description HomePage
  static String homePageDescription = "Entra in un mondo esclusivo creato appositamente per gli studenti universitari, dove le tue connessioni vanno oltre il campus.";
  static String homePageLoginDescription = "Hai già un account? Accedi qui per iniziare a esplorare tutte le possibilità offerte dal nostro social network per studenti universitari.";
  static String homePageSignupDescription = "Unisciti a noi e scopri un nuovo modo di connetterti con altri studenti universitari. Registrati ora e fai parte della nostra comunità!";
  static String homePageFeaturesDesccription = "Scopri un ambiente dinamico e stimolante dove puoi condividere le tue esperienze universitarie, esplorare nuove opportunità accademiche, trovare collaboratori per progetti accattivanti e connetterti con una comunità che condivide la tua passione per l'apprendimento e la crescita.";


}