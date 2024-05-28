enum CustomType { neutral, neutralShade, error, warning, success }

enum Actor { MilkHub, CheeseProducer, Retailer, Consumer, unknown }

enum Asset { MilkBatch, CheeseBlock, CheesePiece }

enum DialogType { DialogConversion, DialogPurchase, Inventory }

enum AlertDialogType { Signup, Signin, Buy, Conversion, Add }

enum DipartimentoUnisa {
  Agraria,
  Architettura,
  ScienzeBiomediche,
  ScienzeFormazioneBeniCulturaliTurismo,
  ScienzeChimiche,
  ScienzeEconomicheStatistiche,
  ScienzeGiuridiche,
  IngegneriaInformazioneElettrica,
  IngegneriaCivileEdileAmbientale,
  IngegneriaIndustriale,
  informatica,
  Matematica,
  MedicinaChirurgiaOdontoiatria,
  Farmacia,
  ScienzeMotorieUmaneSociali,
  ScienzePoliticheSociali,
  ScienzeLinguaggioBeniCulturali,
  Fisica,
  scuolaMedicina,
}



class Enums {
  
  /*
  *   Questa funzione restituisce un testo di default basandosi sull'Actor dati in input
  */
  static String getActorText(Actor actor) {
    switch(actor) {
      case Actor.MilkHub:
        return "MilkHub";
      case Actor.CheeseProducer:
        return "CheeseProducer";
      case Actor.Retailer:
        return "Retailer";
      case Actor.Consumer:
        return "Consumer";
      case Actor.unknown:
        return "";
    }
  }


  /*
  *   Questa funzione restituisce un testo di default basandosi sull'Actor dati in input
  */
  static Actor getActor(String actorName) {
    print("Get Actor Name : "+actorName);
    switch(actorName) {
      case "MilkHub":
        return Actor.MilkHub;
      case "CheeseProducer":
        return Actor.CheeseProducer;
      case "Retailer":
        return Actor.Retailer;
      case "Consumer":
      return Actor.Consumer;
      default :
      return Actor.unknown;  
    }
  }



  /*
   *  Questa funzione restituisce un testo di default basandosi sul CustomType
   */
  static String getDefaultText(CustomType type) {
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

  /*
   *  Questa funzione restituisce il path di un asset passato in input 
   */
  static String getAssetPath(Asset asset) {
    switch(asset) {
      case Asset.MilkBatch:
        return "milk.png";
      case Asset.CheeseBlock:
        return "cheese_block.png";
      case Asset.CheesePiece:
        return "cheese_piece.png";
    }
  }

  /*
  *   Questa funzione restituisce un id basandosi sull'Actor dati in input
  */
  static int getActorId(Actor actor) {
    switch(actor) {
      case Actor.MilkHub:
        return 1;
      case Actor.CheeseProducer:
        return 2;
      case Actor.Retailer:
        return 3;
      case Actor.Consumer:
        return 4;
      case Actor.unknown:
        return 0;
    }
  } 

}