// ignore_for_file: constant_identifier_names

enum CustomType { neutral, neutralShade, error, warning, success }

enum DialogType { DialogConversion, DialogPurchase, Inventory }

enum AlertDialogType { Signup, Signin, Buy, Conversion, Add }

enum DepartementUnisa {
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
  
    static Map<String,String> departementUnisaAsString = {
    
        "Dipartimento di Agraria":DepartementUnisa.AGRICOLA.name,
        "Dipartimento di Architettura":DepartementUnisa.ARCHITETTURA.name,
        "Dipartimento di Scienze Biomediche":DepartementUnisa.BIOMEDICHE.name,
        "Dipartimento di Scienze della Formazione ,Beni Culturali e Turismo":DepartementUnisa.FORMAZIONE_BENICULTURALI.name,
        "Dipartimento di Scienze Chimiche":DepartementUnisa.CHIMICHE.name,
        "Dipartimento di Scienze Economiche e Statistiche":DepartementUnisa.ECONOMICHE_STATISTICHE.name ,
        "Dipartimento di Scienze Giuridiche":DepartementUnisa.GIURIDICHE.name,
        "Dipartimento di Ingegneria dell'Informazione ed Elettrica":DepartementUnisa.INGEGNERIA_ELETTRICA.name, 
        "Dipartimento di Ingegneria Civile, Edile e Ambientale":DepartementUnisa.INGEGNERIA_EDILE.name, 
        "Dipartimento di Ingegneria Industriale":DepartementUnisa.INGEGNERIA_INDUSTRIALE.name, 
        "Dipartimento di Informatica":DepartementUnisa.INFORMATICA.name,
        "Dipartimento di Matematica e Fisica":DepartementUnisa.MATEMATICA_FISICA.name,
        "Dipartimento di Medicina, Chirurgia e Odontoiatria":DepartementUnisa.MEDICINA_CHIRURGIA_ODONTOIATRIA.name, 
        "Dipartimento di Farmacia":DepartementUnisa.FARMACIA.name,
        "Dipartimento di Scienze Motorie, Umane e Sociali":DepartementUnisa.MOTORIE_UMANE_SOCIALI.name, 
        "Dipartimento di Scienze Politiche e Sociali":DepartementUnisa.POLITICHE_SOCIALI.name,
        "Dipartimento di Scienze del Linguaggio e Beni Culturali":DepartementUnisa.LINGUAGGIO_BENICULTURALI.name,
        "Dipartimento di Fisica":DepartementUnisa.FISICA.name,
        "Scuola di Medicina":DepartementUnisa.SCUOLA_MEDICINA.name 

    };

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

    static String getDepartementAsvalue(String departementSelected){
      if(departementUnisaAsString.containsKey(departementSelected)){
        print("Questo è il dipartimento selezionato : "+departementUnisaAsString[departementSelected].toString());
        return departementUnisaAsString[departementSelected].toString();
      }else{
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