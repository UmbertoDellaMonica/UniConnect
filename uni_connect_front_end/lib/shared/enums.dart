// ignore_for_file: constant_identifier_names

enum CustomType { neutral, neutralShade, error, warning, success }

enum DialogType { DialogConversion, DialogPurchase, Inventory }

enum AlertDialogType { Signup, Signin, Buy, Conversion, Add }

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
  

      static List<String> dropdownItems = [
        "Dipartimento di Agraria",
        "Dipartimento di Architettura",
        "Dipartimento di Scienze Biomediche",
        "Dipartimento di Scienze della Formazione", "Beni Culturali e Turismo",
        "Dipartimento di Scienze Chimiche",
        "Dipartimento di Scienze Economiche e Statistiche" ,
        "Dipartimento di Scienze Giuridiche",
        "Dipartimento di Ingegneria dell'Informazione ed Elettrica", 
        "Dipartimento di Ingegneria Civile, Edile e Ambientale", 
        "Dipartimento di Ingegneria Industriale", 
        "Dipartimento di Informatica",
        "Dipartimento di Matematica e Fisica",
        "Dipartimento di Medicina, Chirurgia e Odontoiatria", 
        "Dipartimento di Farmacia" ,
        "Dipartimento di Scienze Motorie, Umane e Sociali", 
        "Dipartimento di Scienze Politiche e Sociali",
        "Dipartimento di Scienze del Linguaggio e Beni Culturali",
        "Dipartimento di Fisica",
        "Scuola di Medicina" 
      ];


      /// Dropdown -> Name Student Department
      /// Questo metodo viene utilizzato nel momento in cui ,io voglio scegliere nel SignUp a quale dipartimento appartengo 
      /// Lo mando al Server e lo riconosce come uno degli Enum che abbiamo Segnalato 
      static String getDepartmentStudent(String department){

        if(dropdownItems.contains(department)){
          switch(department){

              case "Dipartimento di Agraria": return DepartmentUnisa.AGRICOLA.name;
              case"Dipartimento di Architettura":return DepartmentUnisa.ARCHITETTURA.name;
              case"Dipartimento di Scienze Biomediche":return DepartmentUnisa.BIOMEDICHE.name;
              case"Dipartimento di Scienze della Formazione Beni Culturali e Turismo":return DepartmentUnisa.FORMAZIONE_BENICULTURALI.name;
              case "Dipartimento di Scienze Chimiche":return DepartmentUnisa.CHIMICHE.name;
              case"Dipartimento di Scienze Economiche e Statistiche":return DepartmentUnisa.ECONOMICHE_STATISTICHE.name;
              case "Dipartimento di Scienze Giuridiche":return DepartmentUnisa.GIURIDICHE.name;
              case"Dipartimento di Ingegneria dell'Informazione ed Elettrica":return DepartmentUnisa.INGEGNERIA_ELETTRICA.name; 
              case "Dipartimento di Ingegneria Civile, Edile e Ambientale":return  DepartmentUnisa.INGEGNERIA_EDILE.name;
              case"Dipartimento di Ingegneria Industriale":return DepartmentUnisa.INGEGNERIA_INDUSTRIALE.name; 
              case "Dipartimento di Informatica":return DepartmentUnisa.INFORMATICA.name;
              case"Dipartimento di Matematica e Fisica":return DepartmentUnisa.MATEMATICA_FISICA.name;
              case"Dipartimento di Medicina, Chirurgia e Odontoiatria": return DepartmentUnisa.MEDICINA_CHIRURGIA_ODONTOIATRIA.name;
              case "Dipartimento di Farmacia": return DepartmentUnisa.FARMACIA.name;
              case "Dipartimento di Scienze Motorie, Umane e Sociali": return DepartmentUnisa.MOTORIE_UMANE_SOCIALI.name;
              case "Dipartimento di Scienze Politiche e Sociali":return DepartmentUnisa.POLITICHE_SOCIALI.name;
              case "Dipartimento di Scienze del Linguaggio e Beni Culturali": return DepartmentUnisa.LINGUAGGIO_BENICULTURALI.name;
              case "Dipartimento di Fisica": return DepartmentUnisa.FISICA.name;
              case"Scuola di Medicina" : return DepartmentUnisa.SCUOLA_MEDICINA.name;

              default : return ""; 
          }
        }else {
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